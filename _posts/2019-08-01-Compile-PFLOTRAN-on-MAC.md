# Install PFLOTRAN on MAC

The [documentation](https://www.pflotran.org/documentation/user_guide/how_to/installation/linux.html#linux-install) shows the steps for Linux and is the same for MacOS.

## Install fortran compiler

Go to this [website](https://github.com/fxcoudert/gfortran-for-macOS/releases) to download the latest `gfortran` installer for macOS. Then install `gfortran` on mac.

## Download and install Petsc

```bash
git clone https://gitlab.com/petsc/petsc.git petsc_v3.11.3
cd petsc_v3.11.3
git checkout v3.11.3
```

## configure Petsc

note: only python v2 is supported.

```bash
python2.7 ./config/configure.py --CFLAGS='-O3' --CXXFLAGS='-O3' --FFLAGS='-O3' --with-debugging=no --download-mpich=yes --download-hdf5=yes --download-fblaslapack=yes --download-metis=yes --download-parmetis=yes --download-cmake=yes
```

define `PETSC_DIR` and `PETSC_ARCH`. You will see prompts when the configuration is completed.

```bash
export PETSC_DIR=$PWD
export PETSC_ARCH=arch-darwin-c-release 
```

## Compile Petsc

```bash
cd $PETSC_DIR
make all
```

## Download and compile PFLOTRAN

```bash
git clone https://bitbucket.org/pflotran/pflotran
cd pflotran/src/pflotran
make pflotran
```

## regression test

```bash
export MPIRUN=/Users/shua784/Dropbox/github/petsc/arch-darwin-c-debug/bin/mpiexec
$MPIRUN -n 1 $PFLOTRAN_EXE -pflotranin 543_flow.in # use one core for this test
```

Once the test model is finished (should take less than few seconds), the installation processes are done!