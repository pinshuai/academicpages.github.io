# Jupyter notebook markdown generator

These .ipynb files are Jupyter notebook files that convert a TSV containing structured data about talks (`talks.tsv`) or presentations (`presentations.tsv`) into individual markdown files that will be properly formatted for the academicpages template. The notebooks contain a lot of documentation about the process. The .py files are pure python that do the same things if they are executed in a terminal, they just don't have pretty documentation.

1. Add new entry in the `publication.csv` file.

2. Populate publication markdown files.

To execute in the command line:

```
cp ./src/publication.py .

python3 publication.py
```

note: the first column of `publication.csv` may need to be in `YYYY-MM-DD` date format to properly render in the website.
