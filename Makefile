# Makefile for project crud-javascript

# Variabel
REPO = https://github.com/Gopartner/crud-javascript
COMMIT_MSG = "commit pada $(shell date +'%H:%M:%S-%d-%m-%Y')"

# Target: help
help:
	@echo "Available targets:"
	@echo "  1  : Create a new branch (git branch)"
	@echo "  2  : Switch to a branch (git checkout)"
	@echo "  3  : View commit log (git log)"
	@echo "  4  : Compare local & remote repo (git fetch)"
	@echo "  5  : Finishing - Add, commit, and push"
	@echo "==============================================="
	@echo ""
	@echo ""
	@read -p "Choose an action (1-5): " choice; \
	case $$choice in \
		1) \
			read -p "Enter new branch name: " branch_name; \
			git branch $$branch_name; \
			echo "New branch '$$branch_name' created."; \
			;; \
		2) \
			read -p "Enter branch name to switch to: " branch_name; \
			git checkout $$branch_name; \
			echo "Switched to branch '$$branch_name'."; \
			;; \
		3) \
			git log; \
			;; \
		4) \
			git fetch; \
			git status -uno; \
			;; \
		5) \
			git add .; \
			git commit -m $(COMMIT_MSG); \
			git push -u origin Master; \
			echo "Changes committed and pushed with dynamic timestamped commit message."; \
			;; \
		*) \
			echo "Invalid choice. Please choose a number between 1 and 5."; \
			;; \
	esac

.PHONY: help

