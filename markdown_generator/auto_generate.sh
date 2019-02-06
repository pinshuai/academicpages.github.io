#!/bin/bash
echo "execute publications.ipynb"
jupyter nbconvert --to notebook --inplace --execute publications.ipynb 

echo "push changes to github"
git pull origin master
git add --all
git commit -m 'update publication list'
git push origin master
echo "Done!"


