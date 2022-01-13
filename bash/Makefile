.PHONY: all bashrc bash_profile profile clean

all: bashrc bash_profile profile

bashrc:
	echo 'source ~/.config/bash/bashrc' > ~/.bashrc
	@echo bashrc done!

bash_profile:
	echo 'source ~/.config/bash/profile' > ~/.bash_profile
	@echo bash_profile done!

profile:
	echo 'source ~/.config/bash/profile' > ~/.profile
	@echo profile done!

clean: 
	rm ~/.profile ~/.bash_profile ~/.bashrc
	@echo Clean done!
