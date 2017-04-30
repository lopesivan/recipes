PROJECT = recipes

prefix ?= /usr/local

install: install-$(PROJECT)

chmod-755-$(PROJECT):
	@(find . -maxdepth 1 -name \*.sh -exec readlink -f {} \; | \
		while read line; do \
			chmod +x $$line ;\
		done)

chmod-644-$(PROJECT):
	@(find . -maxdepth 1 -name \*.sh -exec readlink -f {} \; | \
		while read line; do \
			chmod -x $$line ;\
		done)

install-$(PROJECT): chmod-755-$(PROJECT)
	@(find . -maxdepth 1 -name \*.sh -exec readlink -f {} \; | \
		while read line; do \
			f=$${line##*/}; \
			l=$${f%.sh};    \
			ln -s $$line $(prefix)/bin/$${l##*/};\
		done)

clean: chmod-644-$(PROJECT)
	@(find . -maxdepth 1 -name \*.sh -exec readlink -f {} \; | \
		while read line; do \
			f=$${line##*/}; \
			l=$${f%.sh};    \
			rm $(prefix)/bin/$${l##*/};\
		done)
