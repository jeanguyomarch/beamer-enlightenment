SOURCES := example.tex

gen-file-get = $(patsubst %.tex,%.$(1),$(SOURCES))

.PHONY: all pdf clean

all: pdf

pdf:
	latexmk -pdf

clean:
	latexmk -C
	$(RM) $(call gen-file-get,nav)
	$(RM) $(call gen-file-get,snm)
