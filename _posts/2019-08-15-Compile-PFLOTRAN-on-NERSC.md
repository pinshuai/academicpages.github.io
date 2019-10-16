# Install PFLOTRAN on NERSC

See this [documentation](https://www.pflotran.org/documentation/user_guide/how_to/installation/linux.html#linux-install) for installation on Linux machine.

## Install Petsc

Download Petsc from Bitbucket, and save it into directory `petsc_v3.11.3`, and checkout the latest version 3.11.3.

```bash
git clone https://gitlab.com/petsc/petsc.git petsc_v3.11.3
cd petsc_v3.11.3
git checkout v3.11.3
```

Set current dir as `PETSC_DIR`

```bash
export PETSC_DIR=$PWD
export PETSC_ARCH=cori_haswell_intel_19_0_3
```

### Choose compiler

- on **haswell** nodes, use `craype-haswell`,  it should be the default one on Cori by checking using `module list`,  otherwise,  do the following

  ```bash
  module load craype-haswell
  ```

- on **KNL** nodes, use `craype-mic-knl` by swapping the default with the new compiler.

  ```bash
  module swap craype-haswell craype-mic-knl
  ```

  

## configure petsc

- Load python module

```bash
module load python/2.7-anaconda-2019.07
```

- Use the following command to configure petsc.

```bash
./config/configure.py --with-cc=cc --with-cxx=CC --with-fc=ftn --CFLAGS='-fast -no-ipo' --CXXFLAGS='-fast -no-ipo' --FFLAGS='-fast -no-ipo' --with-shared-libraries=0 --with-debugging=1 --with-clanguage=c --PETSC_ARCH=$PETSC_ARCH --download-parmetis=1 --download-metis=1 --download-hdf5=1 --with-c2html=0 --with-clib-autodetect=0 --with-fortranlib-autodetect=0 --with-cxxlib-autodetect=0 --LIBS=-lstdc++
```

note: you can define `--PETSC_ARCH` to any name, and a subdir with the same name will be created within `./petsc_v3.11.3/cori_haswell_intel_19_0_3`

- use system installed hdf5 (optional)

```bash
module load cray-hdf5-parallel

./config/configure.py --with-cc=cc --with-cxx=CC --with-fc=ftn --CFLAGS='-fast -no-ipo' --CXXFLAGS='-fast -no-ipo' --FFLAGS='-fast -no-ipo' --with-shared-libraries=0 --with-debugging=1 --with-clanguage=c --PETSC_ARCH=$PETSC_ARCH --download-parmetis=1 --download-metis=1 --with-hdf5=1 --with-c2html=0 --with-clib-autodetect=0 --with-fortranlib-autodetect=0 --with-cxxlib-autodetect=0 --LIBS=-lstdc++
```

- example of currently loaded modules on `haswell ` node

```bash
Currently Loaded Modulefiles:
  1) modules/3.2.11.1                                 10) dmapp/7.1.1-7.0.0.1_5.26__g25e5077.ari           19) craype-haswell
  2) nsg/1.2.0                                        11) gni-headers/5.0.12.0-7.0.0.1_7.41__g3b1768f.ari  20) cray-mpich/7.7.6
  3) intel/19.0.3.199                                 12) xpmem/2.2.17-7.0.0.1_3.25__g7acee3a.ari          21) craype-hugepages2M
  4) craype-network-aries                             13) job/2.2.4-7.0.0.1_3.34__g36b56f4.ari             22) altd/2.0
  5) craype/2.5.18                                    14) dvs/2.11_2.2.140-7.0.0.1_13.1__gdf9ebba2         23) darshan/3.1.7
  6) cray-libsci/19.02.1                              15) alps/6.6.50-7.0.0.1_3.41__g962f7108.ari          24) gcc/8.2.0
  7) udreg/2.3.2-7.0.0.1_4.28__g8175d3d.ari           16) rca/2.2.20-7.0.0.1_4.39__g8e3fb5b.ari            25) cmake/3.14.4
  8) ugni/6.0.14.0-7.0.0.1_7.32__ge78e5b0.ari         17) atp/2.1.3                                        26) python/2.7-anaconda-2019.07
  9) pmi/5.0.14                                       18) PrgEnv-intel/6.0.5                               27) cray-hdf5-parallel/1.10.2.0
```



- when seeing the following means configuration is sucessful.

```bash
xxx=========================================================================xxx
 Configure stage complete. Now build PETSc libraries with (gnumake build):
   make PETSC_DIR=/global/project/projectdirs/m1800/pin/petsc_v3.11.1 PETSC_ARCH=cori_haswell_intel_19_0_3 all
xxx=========================================================================xxx
```

## compile Petsc

```bash
cd $PETSC_DIR
make all
```

## download and compile pflotran

```bash
git clone https://bitbucket.org/pflotran/pflotran pflotran
cd pflotran/src/pflotran
make -j 4 pflotran # use parallel thread to compile?
```

after compilation is complete, a new file named `pflotran*` executable is generated. 

## regression test

Do a regression test to see if pflotran if working.

```bash
export PFLOTRAN_EXE=/global/project/projectdirs/m1800/pin/pflotran/src/pflotran/pflotran
cd /global/project/projectdirs/m1800/pin/pflotran/regression_tests/default/543
```

request an interactive node to run the regression test.

```bash
salloc -N 1 -C haswell -q interactive -t 01:00:00 -L SCRATCH 
srun -n 1 $PFLOTRAN_EXE -pflotranin 543_flow.in # need to use one core to run this example
```

Within seconds, the test model should finish, and the installation processes are done!
