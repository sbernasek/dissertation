# Quantitative analysis of cell fate decisions during development

This repo contains the latex source and figures for my dissertation.


### Dissertation structure

Each chapter, appendix, and table is in a separate `.tex` file.
Individual figure files are stored in `figures/` folder. Latex source for each table is stored in `tables/` folder.


### (Re-)generating the dissertation pdf

**NOTE:** The `Makefile` commands make use of [latexmk](http://mg.readthedocs.io/latexmk.html). Please make sure it is installed in your system if you want to use the commands below.

To compile the dissertation do:

    $ make
    OR
    $ make all


To remove the temporary latex (including bibtex) files:

    $ make decrap


To remove all auto-generated pdfs in addition to the temporary latex files:

    $ make clean


Copyright &copy; 2019 Sebastian Bernasek

