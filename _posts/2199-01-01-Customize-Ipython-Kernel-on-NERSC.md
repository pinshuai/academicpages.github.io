---
title: 'Customize Ipython Kernel on NERSC'
date: 2019-02-01
permalink: /posts/2012/08/blog-post-4/
tags:
  - Jupyter notebook
  - python
---

I will talk about customizing your kernel on Jupyter-dev.nersc.gov. Here I will use `nersc` as my new environment name. 

## Create a conda environment
  open terminal on Jupyterhub and follow the instructions on this [website](https://conda.io/docs/user-guide/tasks/manage-environments.html)
  - In terminal, type `conda env list` to see a list of environments, the current environment is indicated with an asterisk(*). 
  - Build idential conda environment on the same machine
  1. create spec file
  ```bash
  conda list --explicit > spec-file.txt
  ``` 
  2. create an identical environment; alternatively you can install all packages using `conda install -n nersc --file spec-file.txt`
  ```bash
  conda create --name nersc --file spec-file.txt
  ```

## Install packages 
  You can install any package that is not included in "spec-file.txt". 
  
  - First, activate your environment
  ```bash
  source activate nersc
  ```
  By default, the active environemnt is bracketed at the begining of command prompt
  ```bash
  (nersc) $
  ```
  You can see a list of installed packages using `conda list`.
  
  - Then, install package (e.g. `ipdb`) using `conda` in your new environment
  ```bash
  (nersc) $ conda install -c conda-forge ipdb
  ```
  - Alternately you can install package using `pip` 
  ```bash
  (nersc) $ pip install shapely
  ```
## Customize Jupyter Kernel
  - find `kernel.json` file
  The `kernel-spec` file should be located under your environment folder ($HOME/.conda/envs/nersc/share/jupyter/kernels/python3/kernel.json). Find detailed instruction [here](http://www.nersc.gov/users/data-analytics/data-analytics-2/jupyter-and-rstudio/)
  - edit `kernel.json` file to point python at the python in your`.conda` direcctory. You'll need to change the `"argv"` path to your conda directory like below:
  ```python
  {
 "argv": [
  "/global/homes/p/pshuai/.conda/envs/nersc/bin/python3",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Python 3",
 "language": "python"
}
```
  - save this file
## Choose your customized kernel
  Open [Jupyterhub](https://jupyter-dev.nersc.gov/user/pshuai/tree/global/project/projectdirs/m1800/jupyter/reach_scale_model/notebook) on Nersc, and switch current kernel to `Python [conda env:nersc]`. Then you should be able to import newly installed package on the kernel. 

---
# Common issue
1. **"ImportError: numpy.core.multiarray failed to import" when using virtual envirnment on NERSC**

  This is due to a version conflict.
  Solution: try `pip install -U numpy` update your numpy version.

