SHELL := bash
NAME := boergers

UNAME := $(shell uname -s)

BOOTSTRAP_VERSION := 0.0.3
BOOTSTRAP_URL := https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v$(BOOTSTRAP_VERSION)/packwiz-installer-bootstrap.jar

ifeq ($(UNAME), Darwin)
	SED ?= gsed
	SHASUM ?= shasum -a 256
else
	SED ?= sed
	SHASUM ?= sha256sum
endif

ifndef OUTPUT
	ifeq ($(GITHUB_REF_TYPE),tag)
		OUTPUT ?= $(subst v,,$(GITHUB_REF_NAME))
	else
		OUTPUT ?= testing
	endif
endif

ifndef VERSION
	ifeq ($(GITHUB_REF_TYPE),tag)
		VERSION ?= $(subst v,,$(GITHUB_REF_NAME))
	else
		VERSION ?= $(shell git rev-parse --short HEAD)
	endif
endif

.PHONY: clean
clean:
	rm -f $(NAME)-*.mrpack $(NAME)-*.mrpack.sha256

.PHONY: docs
docs:
	cd docs; hugo

.PHONY: build
build: $(NAME)-$(OUTPUT).mrpack $(NAME)-$(OUTPUT).mrpack.sha256

$(NAME)-$(OUTPUT).mrpack:
	$(SED) -i 's|version = ".*"|version = "$(VERSION)"|' pack.toml
	packwiz modrinth export
	git checkout pack.toml
	mv $(NAME)-$(VERSION).mrpack $(NAME)-$(OUTPUT).mrpack

$(NAME)-$(OUTPUT).mrpack.sha256:
	$(SHASUM) $(NAME)-$(OUTPUT).mrpack >| $(NAME)-$(OUTPUT).mrpack.sha256

.PHONY: fetch
fetch: packwiz-installer-bootstrap.jar
	java -jar packwiz-installer-bootstrap.jar --no-gui pack.toml

packwiz-installer-bootstrap.jar:
	curl -sSLo packwiz-installer-bootstrap.jar $(BOOTSTRAP_URL)
