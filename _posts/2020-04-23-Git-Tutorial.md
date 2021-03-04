# Git tutorial

## Basics

This will cover the basics of `git` functions. 

## Collaboration

This will cover situation when you are collaborating with other people. 



### What to do when you have a conflict?

- Option 1 -- Fix it!
- Option 2 -- revert to head.



## Tips

1. Always use `git pull` before you push to the repo. 



## Resources

- Some good GUI to use. e.g., [Sublime Merge](https://www.sublimemerge.com/), [VScode](https://code.visualstudio.com/)
- Command diff tool. e.g., `vimdiff`. need to configure first. [tutorial](https://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/)

```bash
git config merge.tool vimdiff
git config merge.conflictstyle diff3
git config mergetool.prompt false

# after a merge conflict
git mergetool
```

