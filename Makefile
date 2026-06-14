SRC = $(wildcard *.md)

PDFS = $(SRC:.md=.pdf)
HTML = $(SRC:.md=.html)

# Page geometry. Vertical (top/bottom) kept tight to fit content; horizontal a bit wider.
PANDOCARGS = -V geometry:top=0.5in -V geometry:bottom=0.5in -V geometry:left=0.9in -V geometry:right=0.9in

all:    clean $(PDFS) $(HTML)

pdf:   clean $(PDFS)
html:  clean $(HTML)

%.pdf:  %.md header.tex
	pandoc $< $(PANDOCARGS) -H header.tex -o $@

%.html: %.md
	pandoc $< -s -c resume.css -o $@

ifeq ($(OS),Windows_NT)
  # on Windows
  RM = cmd //C del
else
  # on Unix
  RM = rm -f
endif

clean:
	$(RM) *.html *.pdf
