FLAKE = .
HOST = asus-tx5pro
USER = alkaid
MNT = /mnt

.PHONY: switch test boot build-nixvim run-nixvim \
        switch-hm test-hm build-hm \
        update update-input format check \
        gc optimise show \
        copy-flake gen-hardware check-hardware install

# — NixOS —
switch:   ## rebuild & switch to new generation
	sudo nixos-rebuild switch --flake $(FLAKE)#$(HOST)

test:     ## build but don't switch (activates in memory)
	sudo nixos-rebuild test --flake $(FLAKE)#$(HOST)

boot:     ## rebuild & set as boot default
	sudo nixos-rebuild boot --flake $(FLAKE)#$(HOST)

build-nixvim:  ## build standalone nixvim
	nix build $(FLAKE)#nixvim

run-nixvim:    ## run standalone nixvim
	nix run $(FLAKE)#nixvim

# — Home Manager —
switch-hm:    ## rebuild home-manager
	home-manager switch --flake $(FLAKE)#$(USER)

test-hm:      ## build & activate for current session only
	home-manager test --flake $(FLAKE)#$(USER)

build-hm:     ## build without activating
	home-manager build --flake $(FLAKE)#$(USER)

# — Flake Management —
update:       ## update all flake inputs
	nix flake update --flake $(FLAKE)

update-input: ## update a specific input (usage: make update-input name=nixpkgs)
	nix flake lock --flake $(FLAKE) --update-input $(name)

format:       ## format all .nix files
	nix fmt $(FLAKE)

check:        ## evaluate flake & check for errors
	nix flake check --flake $(FLAKE)

show:         ## show flake outputs
	nix flake show --flake $(FLAKE)

# — Store Maintenance —
gc:           ## garbage collect old generations
	sudo nix-collect-garbage -d && nix-collect-garbage -d

optimise:     ## deduplicate nix store
	nix store optimise
# — LiveCD Deployment —

copy-flake:  ## copy flake to target (exclude .git, result, .direnv)
	sudo rsync -a --delete \
		--exclude=.git \
		--exclude=result \
		--exclude=.direnv \
		--exclude=.hardware-generated \
		$(CURDIR)/ $(MNT)/etc/nixos/

gen-hardware: ## generate hardware-config & write into this flake
	rm -f hosts/$(HOST)/.hardware-generated
	sudo nixos-generate-config --root $(MNT)
	sudo cat $(MNT)/etc/nixos/hardware-configuration.nix > hosts/$(HOST)/hardware-configuration.nix
	touch hosts/$(HOST)/.hardware-generated

check-hardware: ## verify hardware-config has been regenerated for this host
	@if ! findmnt $(MNT) > /dev/null 2>&1; then \
		echo "\033[31mERROR: $(MNT) is not a mount point. Mount your root partition to $(MNT) first.\033[0m"; \
		exit 1; \
	fi
	@if findmnt -o FSTYPE -n $(MNT) | grep -q tmpfs; then \
		echo "\033[31mERROR: $(MNT) is tmpfs (livecd root), not your target root. Mount your root partition first.\033[0m"; \
		exit 1; \
	fi
	@if [ ! -f hosts/$(HOST)/.hardware-generated ]; then \
		echo "\033[31mERROR: Run 'make gen-hardware' first to generate hardware configuration for this host.\033[0m"; \
		exit 1; \
	fi

install: check-hardware copy-flake ## check, copy, then install (run after gen-hardware)
	@echo ""
	@echo "Mounts under $(MNT):"
	@findmnt --df -R $(MNT) 2>/dev/null || findmnt -R $(MNT)
	@echo ""
	@echo "Disk info for mounted devices:"
	@sudo findmnt -R $(MNT) -o SOURCE -n | sort -u | \
		xargs -r lsblk -o NAME,MODEL,SIZE,TYPE,FSTYPE,MOUNTPOINT 2>/dev/null || true
	@echo ""
	@echo "All block devices:"
	@lsblk -f
	@echo ""
	@echo -n "Confirm mounts are correct and continue? [y/N] "; \
		read ans; \
		case "$$ans" in \
			y|Y) ;; \
			*) echo "Aborted."; exit 1;; \
		esac
	@if [ ! -f $(MNT)/etc/nixos/flake.nix ]; then \
		echo "\033[31mERROR: flake.nix not found at $(MNT)/etc/nixos/. copy-flake may have failed.\033[0m"; \
		exit 1; \
	fi
	sudo nixos-install \
		--root $(MNT) \
		--flake /etc/nixos#$(HOST)

# — Utility —
help:         ## show this help
	@sed -n 's/^# — \(.*\) —$$/\n\1/p; s/^\([a-zA-Z_-]*\):.*## \(.*\)$$/\1\t\2/p' $(MAKEFILE_LIST) | \
		awk -F'\t' 'NF==1 {print "\n\033[1m" $$0 "\033[0m"} NF==2 {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'
