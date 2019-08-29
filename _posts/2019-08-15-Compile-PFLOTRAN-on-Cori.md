# Install PFLOTRAN on NERSC

See this [documentation](https://www.pflotran.org/documentation/user_guide/how_to/installation/linux.html#linux-install) for installation on Linux machine.

## Install Petsc

Download Petsc from Bitbucket, and save it into directory `petsc_v3.10.2`, and checkout version 3.11.1.

```bash
git clone https://bitbucket.org/petsc/petsc petsc_v3.10.2
cd petsc_v3.10.2
git checkout v3.10.2
```

Set current dir as `PETSC_DIR`

```bash
export PETSC_DIR=$PWD
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

Use the following command to configure petsc.

```bash
./config/configure.py --with-cc=cc --with-cxx=CC --with-fc=ftn --CFLAGS='-fast -no-ipo' --CXXFLAGS='-fast -no-ipo' --FFLAGS='-fast -no-ipo' --with-shared-libraries=0 --with-debugging=1 --with-clanguage=c --PETSC_ARCH=cori_haswell_intel_19_0_3 --download-parmetis=1 --download-metis=1 --download-hdf5=1 --with-c2html=0 --with-clib-autodetect=0 --with-fortranlib-autodetect=0 --with-cxxlib-autodetect=0 --LIBS=-lstdc++
```

note: you can define `--PETSC_ARCH` to any name, and a subdir with the same name will be created within `./petsc_v3.11.1/cori_haswell_intel_19_0_3`

when seeing the following means configuration is sucessful.

```bash
xxx=========================================================================xxx
 Configure stage complete. Now build PETSc libraries with (gnumake build):
   make PETSC_DIR=/Users/shua784/Dropbox/github/petsc PETSC_ARCH=arch-darwin-c-debug all
xxx=========================================================================xxx
```

## compile Petsc

```bash
cd $PETSC_DIR
make all
```

## download and compile pflotran

```bash
git clone https://bitbucket.org/pflotran/pflotran
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
