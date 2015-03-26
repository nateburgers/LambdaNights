SOURCES = $(shell ls *.txt)
PRODUCTS = $(SOURCES:.txt=.html) 

all : $(PRODUCTS)

%.html : %.txt asciidoc.css source-highlight.css
	asciidoc -b html5 -a stylesdir=$(PWD) $<

