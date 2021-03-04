# Install watershed-workflow 

This post follows Ethan's [documentation](https://ecoon.github.io/watershed-workflow/build/html/install.html) with few edits. It has been tested on Mac and Linux (i.e. NERSC).

## install Python env and packages

- for general use

```bash
$ conda create -n workflow-021121 -c conda-forge -c defaults python=3 ipython numpy matplotlib scipy meshpy fiona rasterio shapely cartopy descartes ipykernel requests sortedcontainers attrs pytest pandas geopandas netcdf4 tqdm libarchive # added a few more
$ conda activate watershed_workflow
```

Check python packages.

```bash
$ python -c 'import numpy, matplotlib, scipy, rasterio, fiona, shapely, cartopy, meshpy.triangle; print("SUCCESS")'
```

## install Exodus II (on Mac)

### install compiler (if applicable)

- Install `cmake`. 

  - Download binary for Mac from [here](https://cmake.org/download/). Follow the prompt for installation. 
  - Add to path. 

  ```
  $ export PATH="/Applications/CMake.app/Contents/bin:$PATH"
  ```

- Install `gfortran`
  - Download [Homebrew](https://brew.sh/)
  - `brew install gcc`

### Configure Exodus

- Clone `seacas`

```
$ git clone https://github.com/gsjaardema/seacas.git
```

- Clone `watershed-workflow`

```
$ git clone https://github.com/ecoon/watershed-workflow.git
```

- Edit `configure-seacas.sh`

```bash
$ cd watershed-workflow/workflow_tpls/
$ vi configure-seacas.sh

# edit the following lines
CC=`which clang`  # `which gcc` for Linux
CXX=`which clang++`  # `which g++` for Linux
FC=`which gfortran`
# add/change the following path
CONDA_PREFIX=/opt/anaconda3/envs/watershed_workflow
SEACAS_SRC_DIR=/path/to/seacas/repo
```

- Configure

```bash
$ sh configure-seacas.sh
```

- Check if successful

```bash
$ export PYTHONPATH=${SEACAS_SRC_DIR}/install/lib
$ python -c 'import exodus; print("SUCCESS")'
```

If the installation is not successful (i.e., nothing inside the `seacas/install`), following the steps below to re-install.

### change python version (optional) 

- Manually write python version in `CMakeCache.txt`

```bash
$ cd seacas/build
$ vi CMakeCache.txt
```

- search for `python` and make the following changes

```bash
//Path to a program.
PYTHON_EXECUTABLE:FILEPATH=/opt/anaconda3/bin/python

//Default version of Python to find (must be 2.6 or greater
PythonInterp_FIND_VERSION:STRING=3.7 
```

- install again

```bash
# assume inside build/
$ make install
```

### Install workflow packages

```bash
$ cd /path/to/watershed-workflow/repository
# add this and its subfolder `workflow_tpls` to `.bash_profile` to make it permanently
$ export PYTHONPATH=`pwd`:`pwd`/workflow_tpls:`pwd`/workflow:${PYTHONPATH}
# add the following for exodus to work
$ export PYTHONPATH="${PYTHONPATH}:/Users/shua784/Dropbox/github/seacas/install/lib" 

```

## Install Exodus II (on NERSC)

Follow most of the steps above but with a few changes.

### Configure modules

```bash
module load python
module load cmake
module swap PrgEnv-intel PrgEnv-gnu

export CRAYPE_LINK_TYPE=dynamic # important!
```

Loaded modules

```bash
Currently Loaded Modulefiles:
  1) modules/3.2.11.4
  2) altd/2.0
  3) darshan/3.1.7
  4) gcc/8.3.0
  5) craype-haswell
  6) craype-hugepages2M
  7) craype-network-aries
  8) craype/2.6.2
  9) cray-mpich/7.7.10
 10) cray-libsci/19.06.1
 11) udreg/2.3.2-7.0.1.1_3.33__g8175d3d.ari
 12) ugni/6.0.14.0-7.0.1.1_7.35__ge78e5b0.ari
 13) pmi/5.0.14
 14) dmapp/7.1.1-7.0.1.1_4.49__g38cf134.ari
 15) gni-headers/5.0.12.0-7.0.1.1_6.29__g3b1768f.ari
 16) xpmem/2.2.20-7.0.1.1_4.11__g0475745.ari
 17) job/2.2.4-7.0.1.1_3.37__g36b56f4.ari
 18) dvs/2.12_2.2.157-7.0.1.1_9.2__g083131db
 19) alps/6.6.58-7.0.1.1_6.5__g437d88db.ari
 20) rca/2.2.20-7.0.1.1_4.48__g8e3fb5b.ari
 21) atp/2.1.3
 22) PrgEnv-gnu/6.0.5
 23) python/3.7-anaconda-2019.10
 24) cmake/3.14.4
```



### Configure Exodus

Change the following in `watershed-workflow/workflow_tpls/configure-seacas.sh`

```bash
CC=`which cc`  # `which gcc` for Linux
CXX=`which CC`  # `which g++` for Linux
FC=`which ftn`

CONDA_PREFIX=/global/homes/p/pshuai/.conda/envs/watershed
SEACAS_SRC_DIR=/global/project/projectdirs/m1800/pin/github/seacas
...
```

### change python version

May need to change python version from 2.7 to 3.7.

```bash
$ cd seacas/build
$ vi CMakeCache.txt

//Path to a program.
PYTHON_EXECUTABLE:FILEPATH=/usr/common/software/python/3.7-anaconda-2019.10/bin/python

//Default version of Python to find (must be 2.6 or greater
PythonInterp_FIND_VERSION:STRING=3.7 # change this!
```

then reinstall

```bash
make install
```

`libexodus.so` should be inside `seacas/install/lib`.



## Common issues

1. if `workflow` module could not be imported, try adding the following to the notebook.

```python
import os,sys
sys.path.append(os.path.abspath("/Users/shua784/Dropbox/github/watershed-workflow"))
```

2. `tinytree` could not be imported

```bash
(watershed_workflow) $ pip install tinytree
```

3. `libexodus.so` is not found

```bash
export CRAYPE_LINK_TYPE=dynamic
```

Then delete seacas repo and re-clone from GitHub. Do the configure again.