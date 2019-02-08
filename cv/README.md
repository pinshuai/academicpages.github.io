# Generate CV using R markdown and Tex template

This CV is modified from [Steven V. Miller](http://svmiller.com) (see this [post](http://svmiller.com/blog/2016/03/svm-r-markdown-cv/)) with minimal changes.
## Instructions

* Download files `svm-rmarkdown-cv.Rmd` and `svm-latex-cv.tex` from this [repo](https://github.com/svmiller/svm-r-markdown-templates) and put them in the same folder.
* Download [Basic Tex](http://www.tug.org/mactex/morepackages.html)
* Open `svm-rmarkdown-cv.Rmd` using Rstudio
* Change the content in the YAML and markdown
* Use `Knit` to generate the PDF (you may want to install any missing Tex fonts/packages using `sudo tlmgr install PACKAGENAME`)
