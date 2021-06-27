# Conda environment in Jupyter

This will show how to create customized conda environment on Mac.

## Create new conda env

This example shows how to create new environment called `my_env` while specify the python version you want.

```bash
$ conda create --name geo -c conda-forge python ipykernel numpy pandas scipy scikit-learn matplotlib seaborn tqdm shapely rasterio PyShp geopandas h5py xarray rioxarray
```

## create kernel spec file (must do this inside the activated env!)

In order for Jupyter to find your kernel, run following command and optionally choose the display kernel name (i.e., `MyEnv-jupyter`)

```bash
(my_env) $ python -m ipykernel install 
# or
(my_env) $ python -m ipykernel install --user --name geo --display-name geo
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



## launch Jupyter

Lauch Jupyter lab and you should see you new kernel `my_env-jupyter` from the kernel dropdown.

```bash
$ jupyter lab
```

## remove a jupyter kernel

```bash
#check available kernels
jupyter kernelspec list
# remove selected kernel
jupyter kernelspec uninstall unwanted-kernel
```



###  Install Jupyterlab extentions

```bash
#check installed server extension
jupyter serverextension list
# install selected extention
conda install -c conda-forge jupyterlab-git
```



# Export Conda env

```bash
# only the main packages are exported
conda env export --from-history > environment.yml 

conda env create -f environment.yml # the env name is included in the .yml file
conda activate widget
python -m ipykernel install --user --name widget --display-name widget

jupyter labextension install @jupyter-widgets/jupyterlab-manager # enable widget

```





