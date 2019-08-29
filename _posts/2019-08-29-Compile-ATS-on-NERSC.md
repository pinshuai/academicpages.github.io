# compile ATS on NERSC

The instruction follows this [ATS Installation Guide](https://github.com/amanzi/ats/blob/master/INSTALL.md) with a few changes for compilation on NERSC Cori environment. To get some background on compiling codes on NERSC, see this [tutorial](https://www.nersc.gov/users/computational-systems/cori/programming/compiling-codes-on-cori/) on NERSC website.

## Pre-requirements

### Set programming env

The default environment on NERSC is `PrgEnv-intel`, and you need to switch to `PrgEnv-gnu`, which is applicable for most open-source codes.

```bash
module swap PrgEnv-intel PrgEnv-gnu
```

### Load `cmake`

The default `/usr/bin/cmake` did not work well. Load `cmake` using

```bash
module load cmake
```

You should be able to test if it has been loaded by running `which cmake`,  and you should see the directory: `/global/common/sw/cray/cnl7/haswell/cmake/3.14.4/gcc/8.2.0/2hef55n/bin/cmake`

The cmake version is `3.14.4`

###  Load MPI

For compiling on cray system, the use of `cray-mpich` is recommended.

```
module load cray-mpich
```

You can also show the installation path using

```bash
module show cray-mpich
```

**IMPORTANT: copy `MPICH_DIR` or `CRAY_MPICH_DIR`, you will need this later!** 

This is what it looks like using `module list`

```bash
Currently Loaded Modulefiles:
  1) modules/3.2.11.1                                 13) ugni/6.0.14.0-7.0.0.1_7.30__ge78e5b0.ari
  2) nsg/1.2.0                                        14) pmi/5.0.14
  3) gcc/8.2.0                                        15) dmapp/7.1.1-7.0.0.1_5.20__g25e5077.ari
  4) craype-haswell                                   16) gni-headers/5.0.12.0-7.0.0.1_7.39__g3b1768f.ari
  5) craype-hugepages2M                               17) xpmem/2.2.17-7.0.0.1_3.24__g7acee3a.ari
  6) craype-network-aries                             18) job/2.2.4-7.0.0.1_3.30__g36b56f4.ari
  7) craype/2.5.18                                    19) dvs/2.11_2.2.137-7.0.0.1_10.1__g04d35b33
  8) cray-mpich/7.7.6                                 20) alps/6.6.50-7.0.0.1_3.35__g962f7108.ari
  9) altd/2.0                                         21) rca/2.2.20-7.0.0.1_4.34__g8e3fb5b.ari
 10) darshan/3.1.7                                    22) atp/2.1.3
 11) cray-libsci/19.02.1                              23) PrgEnv-gnu/6.0.5
 12) udreg/2.3.2-7.0.0.1_4.27__g8175d3d.ari           24) cmake/3.14.4
```

### Set path

Set up some directories for use later. 

```bash
vi ~/.bash_profile.ext
```

Put the following in the file. The `OPENMPI_DIR` is the same as `MPICH_DIR` from previous step. 

```bash
# ----EDIT THESE!------#
export ATS_BASE=$HOME/ats
export ATS_BUILD_TYPE=Debug # or Release
export OPENMPI_DIR=/opt/cray/pe/mpt/7.7.6/gni/mpich-gnu/8.2
# ---------------------#

export ATS_SRC_DIR=${ATS_BASE}/repos/ats
export ATS_BUILD_DIR=${ATS_BASE}/ats-build-${ATS_BUILD_TYPE}
export ATS_DIR=${ATS_BASE}/ats-install-${ATS_BUILD_TYPE}

export AMANZI_SRC_DIR=${ATS_BASE}/repos/amanzi
export AMANZI_BUILD_DIR=${ATS_BASE}/amanzi-build-${ATS_BUILD_TYPE}
export AMANZI_DIR=${ATS_BASE}/amanzi-install-${ATS_BUILD_TYPE}

export AMANZI_TPLS_BUILD_DIR=${ATS_BASE}/amanzi-tpls-build-${ATS_BUILD_TYPE}
export AMANZI_TPLS_DIR=${ATS_BASE}/amanzi-tpls-install-${ATS_BUILD_TYPE}
export PATH=${ATS_DIR}/bin:${AMANZI_TPLS_DIR}/bin:${PATH}
export PYTHONPATH=${ATS_SRC_DIR}/tools/utils:${PYTHONPATH}
```

Put these in your bash profile (using `vi ~/.bash_profile.ext`), then do 

```bash
source ~/.bash_profile.ext
```

## Download and compile ATS

### make base dir

```bash
mkdir -p ${ATS_BASE}
cd ${ATS_BASE}
```

### clone Amanzi from Github

```bash
git clone -b amanzi-0.88 http://github.com/amanzi/amanzi $AMANZI_SRC_DIR
```

### clone ATS from Github

```bash
git clone -b ats-0.88 http://github.com/amanzi/ats $ATS_SRC_DIR
```

### configure Amanzi TPLs and Amanzi

- First, you need to modify the bootstrap script.

```bash
vi ${AMANZI_SRC_DIR}/bootstrap.sh
```

- Modify known compiler list, replace each compiler with compiler wrapper (i.e. `cc, CC and ftn`) on Nersc. For example,

```bash
known_c_compilers="cc"
known_cxx_compilers="CC"
known_fortran_compilers="ftn"
```

Turn on nersc flag, change from `FALSE` to `TRUE`

```bash
nersc=${TRUE}
```

Save the changes in `bootstrap.sh`

### run bootstrap

```bash
. ${ATS_SRC_DIR}/amanzi_bootstrap.sh
```

It will take 30 ~ 60 min... to complete.

### configure ATS

```bash
. ${ATS_SRC_DIR}/configure-ats.sh
```

## Run testing problem

### Download the example repo

```bash
cd $ATS_BASE
mkdir testing
cd testing
git clone -b ats-demos-0.88 http://github.com/amanzi/ats-demos
```

### Run a test

- first request some interactive node

```bash
salloc -N 1 -C haswell -q interactive -t 00:30:00 -L SCRATCH
```

- then run the test problem

```bash
cd ats-demos/01_richards_steadystate
ats --xml_file=./richards_steadystate.xml &> out.log
```

It should take less than a second to finish!

