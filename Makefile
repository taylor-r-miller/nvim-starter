backup:
	cp -r ~/.config/nvim ~/.config/nvim-backup
uninstall:
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
install:
	make uninstall
	mkdir ~/.config/nvim
	cd .. && cp -a nvim-starter/* ~/.config/nvim
