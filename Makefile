.PHONY: clone_repo

clone_repo:
	cd ~ && git clone https://github.com/Vortex5Root/CI.git ~/tools/CI && chmod +x ~/tools/CI/add_CI.sh

# Define the alias name and the command
ALIAS_NAME=add_ci
ALIAS_COMMAND='~/tools/CI/add_CI.sh'

# Define a rule to add the alias to ~/.bashrc
add_alias:
	@echo "Adding alias to ~/.bashrc"
	@echo "alias $(ALIAS_NAME)=$(ALIAS_COMMAND)" >> ~/.bashrc
	@echo "Reloading ~/.bashrc"
	@source ~/.bashrc
	@echo "Alias added successfully"

# Define a rule to check if the alias already exists (optional)
check_alias:
	@if grep -q "alias $(ALIAS_NAME)=$(ALIAS_COMMAND)" ~/.bashrc; then \
		echo "Alias already exists in ~/.bashrc"; \
	else \
		$(MAKE) add_alias; \
	fi

