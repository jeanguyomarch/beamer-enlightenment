# The MIT License (MIT)
#
# Copyright © 2016 Jean Guyomarc'h
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.


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
