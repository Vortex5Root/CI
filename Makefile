SHELL := /bin/bash

clone_repo:
	cd ~ && git clone https://github.com/Vortex5Root/CI.git ~/tools/CI && chmod +x ~/tools/CI/add_CI.sh

# Define the alias name and the command
ALIAS_NAME=add_ci
ALIAS_COMMAND='~/tools/CI/add_CI.sh'

install: clone_repo add_alias check_alias

update:
	cd ~/tools/CI && git stash && git pull origin main && chmod +x ~/tools/CI/add_CI.sh

uninstall:
	rm -rf ~/tools/CI
	sed -i '/alias add_ci=~/d' ~/.bashrcma

# Define a rule to add the alias to ~/.bashrc
add_alias:
	@echo "Adding alias to ~/.bashrc"
	@echo "alias $(ALIAS_NAME)=$(ALIAS_COMMAND)" >> ~/.bashrc
	@echo "Reloading ~/.bashrc"
	@source ~/.bashrc
	@echo "Alias added successfully"

rebase_project:
	cd ~/tools/CI && git stash && git config pull.rebase true && git pull --rebase origin main && chmod +x ~/tools/CI/add_CI.sh

# Define a rule to check if the alias already exists (optional)
check_alias:
	@if grep -q "alias $(ALIAS_NAME)=$(ALIAS_COMMAND)" ~/.bashrc; then \
		echo "Alias already exists in ~/.bashrc"; \
	else \
		$(MAKE) add_alias; \
	fi

uninstall:
	rm -rf ~/tools/CI
	sed -i '/alias add_ci=~/d' ~/.bashrcma