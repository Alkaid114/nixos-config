FLAKE = .
HOST = asus-tx5pro
USER = alkaid

.PHONY: switch test boot build-nixvim run-nixvim \
        switch-hm test-hm build-hm \
        update update-input format check \
        gc optimise show

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

# — Utility —
help:         ## show this help
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
