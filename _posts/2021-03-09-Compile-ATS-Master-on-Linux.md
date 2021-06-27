# Installation on Linux

Follow steps [here](https://github.com/amanzi/amanzi/blob/master/INSTALL_ATS.md)

## Set up env

- make sure `open-mpi, lapack` has been installed
- install open-mpi

- Configure environment

```bash
#!/usr/bin/env bash

# EDIT THESE!
export ATS_BASE=/software/ATS-master
export ATS_BUILD_TYPE=Release
export ATS_VERSION=master
export OPENMPI_DIR=/usr # this is important to include only the directory instead of /usr/bin if mpirun exists inside /usr/bin
# END EDIT THESE!

export AMANZI_TPLS_BUILD_DIR=${ATS_BASE}/amanzi_tpls-build-${ATS_VERSION}-${ATS_BUILD_TYPE}
export AMANZI_TPLS_DIR=${ATS_BASE}/amanzi_tpls-install-${ATS_VERSION}-${ATS_BUILD_TYPE}

export AMANZI_SRC_DIR=${ATS_BASE}/repos/amanzi
export AMANZI_BUILD_DIR=${ATS_BASE}/amanzi-build-${ATS_VERSION}-${ATS_BUILD_TYPE}
export AMANZI_DIR=${ATS_BASE}/amanzi-install-${ATS_VERSION}-${ATS_BUILD_TYPE}

export ATS_SRC_DIR=${AMANZI_SRC_DIR}/src/physics/ats
export ATS_DIR=${AMANZI_DIR}

export PATH=${ATS_DIR}/bin:${PATH}
export PATH=${AMANZI_TPLS_DIR}/bin:${PATH}
export PYTHONPATH=${ATS_SRC_DIR}/tools/utils:${PYTHONPATH}
export PYTHONPATH=${AMANZI_TPLS_DIR}/SEACAS/lib:${PYTHONPATH}
```

## Download amanzi-ats

```bash
git clone -b master http://github.com/amanzi/amanzi $AMANZI_SRC_DIR

# optional when the previous clone does not download ats automatically
git clone -b ecoon/land_cover http://github.com/amanzi/ats $ATS_SRC_DIR
```



## Edit bootstrap

```bash
vi ${AMANZI_SRC_DIR}/build_ATS_generic.sh

# change the following bootstrap flags and options
${AMANZI_SRC_DIR}/bootstrap.sh \
   ${dbg_option} \
   --with-mpi=${OPENMPI_DIR} \
   --enable-shared \
   --disable-clm \
   --disable-geochemistry \
   --disable-structured  --enable-unstructured \
   --disable-stk_mesh --enable-mstk_mesh \
   --enable-hypre \
   --disable-silo \
   --disable-petsc \
   --disable-amanzi_physics \
   --enable-ats_physics \
   --disable-ats_dev \
   --disable-geochemistry \
   --amanzi-install-prefix=${AMANZI_DIR} \
   --amanzi-build-dir=${AMANZI_BUILD_DIR} \
   --tpl-install-prefix=${AMANZI_TPLS_DIR} \
   --tpl-build-dir=${AMANZI_TPLS_BUILD_DIR} \
   --tpl-download-dir=${ATS_BASE}/amanzi-tpls/Downloads \
   --tools-download-dir=${ATS_BASE}/amanzi-tpls/Downloads \
   --tools-build-dir=${ATS_BASE}/build \
   --tools-install-prefix=${ATS_BASE}/install \
   --with-cmake=`which cmake` \
   --with-ctest=`which ctest` \
   --branch_ats=${ATS_VERSION} \
   --parallel=8
   
# If TPLs have already been built, and you don't want to go
# through that long process again, replace
#   --tpl-install-prefix=${AMANZI_TPLS_DIR} \
#   --tpl-build-dir=${AMANZI_TPLS_BUILD_DIR} \
#   --tpl-download-dir=${ATS_BASE}/amanzi-tpls/Downloads \
# with
#   --tpl-config-file=${AMANZI_TPLS_DIR}/share/cmake/amanzi-tpl-config.cmake \   
```

## configure and install Amanzi-tpls, Amanzi, and ATS

- run the bootstrap

```bash
sh ${AMANZI_SRC_DIR}/build_ATS_generic.sh
```

After ~ 1hr, the installation would finish, with `ats` executable in `ats/amanzi-install-master-Release/bin/ats*`

## testing

- download testing problem

```bash
cd $ATS_BASE
mkdir testing
cd testing
git clone -b master http://github.com/amanzi/ats-demos
```

-  run test

```bash
export PATH="path/to/ats:$PATH"

cd ats-demos
cd 01_richards_steadystate
# serial
ats --xml_file=richards_steadystate.xml &> out.log

# parallel
mpirun -n 4 ats --xml_file=richards_steadystate.xml &> out.log
```