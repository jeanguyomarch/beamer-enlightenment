SOURCES := example.tex
IMG_DIR := img

SVG_FILES := $(IMG_DIR)/theme/e_logo.svg
PDF_FILES := $(patsubst %.svg,%.pdf,$(SVG_FILES))

gen-file-get = $(patsubst %.tex,%.$(1),$(SOURCES))

.PHONY: all pdf clean

all: pdf

pdf: $(PDF_FILES)
	latexmk -pdf $(SOURCES)

clean:
	latexmk -C
	$(RM) $(call gen-file-get,nav)
	$(RM) $(call gen-file-get,vrb)
	$(RM) $(call gen-file-get,snm)
	$(RM) $(PDF_FILES)

$(IMG_DIR)/%.pdf: $(IMG_DIR)/%.svg Makefile
	rsvg-convert -f pdf -o $@ $<
