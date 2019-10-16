# Conda environment in Jupyter

This will show how to create customized conda environment on Mac.

## Create new conda env

This example shows how to create new environment called `my_env` while specify the python version you want.

```bash
$ conda create --name my_env python=3.7
```

## install packages

Before you install any package, activate the new conda env just created.

```bash
$ conda activate my_env
```

Then install  `ipykernel` and other packages using `conda`

```bash
(my_env) $ conda install ipykernel numpy
```

Or using `pip`

```bash
(my_env) $ pip install matplotlib
```

## create kernel spec file

In order for Jupyter to find your kernel, run following command and choose the kernel name (i.e., `my_env-jupyter`)

```bash
(my_env) $ python -m ipykernel install --user --name my_env --display-name MyEnv-jupyter
```

## launch Jupyter

Lauch Jupyter lab and you should see you new kernel `my_env-jupyter` from the kernel dropdown.

```bash
$ jupyter lab
```



# Export Conda env

```bash
# only the main packages are exported
conda env export --from-history > environment.yml 

conda env create -f environment.yml # the env name is included in the .yml file

python -m ipykernel install --user --name widget --display-name widget

jupyter labextension install @jupyter-widgets/jupyterlab-manager # enable widget

```





