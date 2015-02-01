# This thing was made by Daemon Lee Schmidt <DaemonLeeSchmidt@gmail.com> in 2015
# and is licensed under CC0 1.0 Universal,
# if you didn't get a LICENSE file with this Makefile, you can get it here:
# https://creativecommons.org/publicdomain/zero/1.0/

# Add single dependencies using this format. Kinda like cargo's TOML.
DEPNAMES += "hump"
DEPURLS += "https://github.com/vrld/hump"

# The name of the final .love zip file.
PACKAGE="Hatmaster-Flash"

# The main dealio. Should handle most situations nicely.
all:
	@$(foreach i,$(DEPNAMES),test -d $i || $(MAKE) init;)

	@$(MAKE) update
	@echo
	@mkdir -p build
	@echo "Grabbing and hugging (compressing) Lua files..."
	@find . -name '*.lua' -exec zip -9 build/$(PACKAGE).love {} \;

	@echo -e "\nDone!"

# Clone the repos. Simple.
init:
	@$(foreach i,$(DEPURLS),tput setaf 2; echo -e "Cloning $i..."; tput sgr0; git clone $(i);)

# Update the git repos. Not normally called by the user.
update:
	@$(foreach i,$(DEPNAMES),tput setaf 2 ; echo -e "Updating $i..."; tput sgr0 ; cd $(i); git pull; cd ..;)

# Basic clean up.
clean:
	rm -rf build vgcore.* callgrind.out.*

# Complete remove everything (including git clones) and start fresh... You'd do
# this before commiting your changes or whatever.
vaporize: clean
	rm -rf build $(DEPNAMES)

# Run. Runrunrun.
run:
	test -e build/$(PACKAGE).love || $(MAKE)
	love build/$(PACKAGE).love

.PHONY: all init update clean vaporize run
