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


SOURCES := demo.tex
IMG_DIR := img
PREFIX := $(HOME)
TEXMF := $(PREFIX)/texmf
LATEX_DIR := tex/latex/beamerenlightenment
PACKAGE := beamerenligthenment
PACKAGE_DIR := _package
ARCHIVE := $(PACKAGE).zip

INSTALL_FILES := \
$(LATEX_DIR)/beamercolorthemeenlightenment.sty \
$(LATEX_DIR)/beamerinnerthemeenlightenment.sty \
$(LATEX_DIR)/beamerouterthemeenlightenment.sty \
$(LATEX_DIR)/beamerthemeenlightenment.sty \
$(LATEX_DIR)/e.png \
$(LATEX_DIR)/e_bg.png \
$(LATEX_DIR)/bg_glint.png \
$(LATEX_DIR)/e_logo.pdf

gen-file-get = $(patsubst %.tex,%.$(1),$(SOURCES))

.PHONY: all pdf clean package install uninstall logo

all: pdf

logo: $(IMG_DIR)/e_logo.svg
	rsvg-convert -f pdf -o $(LATEX_DIR)/e_logo.pdf $<

pdf: $(LATEX_DIR)/e_logo.pdf
	TEXMFHOME=.:$$TEXMFHOME latexmk -pdf $(SOURCES)

clean:
	latexmk -C
	$(RM) $(call gen-file-get,nav)
	$(RM) $(call gen-file-get,vrb)
	$(RM) $(call gen-file-get,snm)
	$(RM) $(ARCHIVE)

package: $(LATEX_DIR)/e_logo.pdf
	@$(RM) -r $(PACKAGE_DIR)
	@$(RM) $(ARCHIVE)
	@mkdir $(PACKAGE_DIR)
	@mkdir -p $(PACKAGE_DIR)/tex/latex/$(PACKAGE)
	@mkdir -p $(PACKAGE_DIR)/doc/latex/$(PACKAGE)
	@mkdir -p $(PACKAGE_DIR)/source/latex/$(PACKAGE)
	@$(foreach inst,$(INSTALL_FILES),cp $(inst) $(PACKAGE_DIR)/tex/latex/$(PACKAGE);)
	@cd $(PACKAGE_DIR) && zip -T -9 -r $(ARCHIVE) doc/ source/ tex/
	@mv $(PACKAGE_DIR)/$(ARCHIVE) $(ARCHIVE)
	@$(RM) -r $(PACKAGE_DIR)

install: package
	@unzip -o $(ARCHIVE) -d $(TEXMF)

uninstall:
	find $(TEXMF) -name $(PACKAGE) -type d -print | xargs $(RM) -vr
