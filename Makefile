.PHONY: clone_repo

clone_repo:
	cd ~ && git clone <repository_url> /path/to/destination

.PHONY: add_CI

add_CI:
	echo "bash ~/CI/add_CI.sh" >> ~/.bashrc