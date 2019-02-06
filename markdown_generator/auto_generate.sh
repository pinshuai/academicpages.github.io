#!/bin/bash
echo "execute publications.ipynb"
jupyter nbconvert --to notebook --inplace --execute publications.ipynb 

echo "push changes to github"
pullmaster
git add .
git commit -m 'update publication list'
pushmaster
echo "Done!"


