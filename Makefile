
.PHONY: all
all: clean pub-get

.PHONY: pub-get
pub-get:
	@fvm flutter pub get

.PHONY: runner
runner:
	@dart run build_runner build --delete-conflicting-outputs

.PHONY: clean
clean:
	@fvm flutter clean

.PHONY: build-apk
build-apk:
	@fvm flutter build apk --split-per-abi



# Optional: Help menu
.PHONY: help
help:
	@echo "Makefile for Flutter commands"
	@echo "Usage:"
	@echo "  make clean        		- Clean the Flutter project"
	@echo "  make all          		- Clean & Pub get"
	@echo "  make runner       		- Build runner generated"
	@echo "  make pub-get      		- Pub get all package"
	@echo "  make build-apk    		- Build apk split abi"
