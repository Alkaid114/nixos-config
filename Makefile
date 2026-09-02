FLAKE = .
HOST = asus-tx5pro
USER = alkaid
MNT = /mnt

.PHONY: switch test boot \
        switch-hm test-hm build-hm \
        update update-input format check \
        gc optimise show \
        copy-flake gen-hardware check-hardware confirm-mounts install \
        help

.DEFAULT_GOAL := help

# — NixOS —
switch:   ## rebuild & switch to new generation
	@scripts/nix.sh switch

test:     ## build but don't switch (activates in memory)
	@scripts/nix.sh test

boot:     ## rebuild & set as boot default
	@scripts/nix.sh boot

# — Home Manager —
switch-hm:    ## rebuild home-manager
	@scripts/nix.sh switch-hm

test-hm:      ## build & activate for current session only
	@scripts/nix.sh test-hm

build-hm:     ## build without activating
	@scripts/nix.sh build-hm

# — Flake Management —
update:       ## update all flake inputs
	@scripts/nix.sh update

update-input: ## update a specific input (usage: make update-input name=nixpkgs)
	@scripts/nix.sh update-input $(name)

format:       ## format all .nix files
	@scripts/nix.sh format

check:        ## evaluate flake & check for errors
	@scripts/nix.sh check

show:         ## show flake outputs
	@scripts/nix.sh show

# — Store Maintenance —
gc:           ## garbage collect old generations
	@scripts/nix.sh gc

optimise:     ## deduplicate nix store
	@scripts/nix.sh optimise

# — LiveCD Deployment —
copy-flake:  ## copy flake to target (exclude .git, result, .direnv)
	@scripts/nix.sh copy-flake

gen-hardware: ## generate hardware-config & write into this flake
	@scripts/nix.sh gen-hardware

check-hardware:
	@scripts/nix.sh check-hardware

confirm-mounts:
	@scripts/nix.sh confirm-mounts

install: ## check, confirm, copy, then install (run after gen-hardware)
	@scripts/nix.sh install

# — Utility —
help:         ## show this help
	@scripts/nix.sh help
