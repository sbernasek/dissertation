#######
#
# Auto-generate the thesis pdf and clean up latex crap
#
# Author: Joao Moreira
#
######

# Name of thesis file with pdf extension instead of tex
THESIS = thesis.pdf
REFERENCES = thesis.bib

# Figures
FIGURES_DIR = ./figures
FIGURES = $(wildcard $(FIGURES_DIR)/*.eps)
FIGURES += $(wildcard $(FIGURES_DIR)/*.pdf)

# LaTeX input files
CHAPTERS = $(wildcard chapter_*.tex)
CHAPTERS += $(wildcard abstract.tex)
CHAPTERS += $(wildcard acknowledgements.tex)
CHAPTERS += $(wildcard appendix_*.tex)
CHAPTERS += $(wildcard variables*.tex)
# Latex variables with all relevant numerical values for chapter 3
LATEX_VARS = variables_movies.tex
TABLES_DIR = ./tables
TABLES = $(wildcard $(TABLES_DIR)/*.tex)

# Tools
LATEXMK = latexmk
# We need to exclude `recorder` option because otherwise latexmk seems to ignore
# changes in files passed as \input{} to $THESIS
LATEXMKOPT = -recorder- -silent
RM = rm -f

.PHONY: decrap clean

all: $(THESIS)

# Compile the tex manuscript file
$(THESIS): %.pdf:%.tex $(REFERENCES) $(CHAPTERS) $(LATEX_VARS) $(FIGURES) $(TABLES)
	$(LATEXMK) $(LATEXMKOPT) -pdf -pdflatex="pdflatex -interaction=nonstopmode -synctex=1 -shell-escape" $<
	@echo
	@echo "Successfully compiled $@!"
	@echo

# Remove all latex temporary files
decrap:
	$(LATEXMK) $(LATEXMKOPT) -c
	cd $(TABLES_DIR) && $(LATEXMK) $(LATEXMKOPT) -c
	$(RM) *.synctex.gz $(TABLES_DIR)/*.synctex.gz
	$(RM) *.bbl
	@echo
	@echo "Removed latex temporary files."
	@echo

# Remove all auto-generated pdfs in addition to the latex temporary files
clean: decrap
	$(RM) $(FIGURES_DIR)/*-converted-to*
	$(LATEXMK) $(LATEXMKOPT) -C
	@echo
	@echo "Removed thesis pdf files."
	@echo


