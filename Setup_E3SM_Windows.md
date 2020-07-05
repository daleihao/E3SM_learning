# Setup E3SM in Centos-7 of Win-10
## 1. Install Centos-7 on the Windows Subversion System for Linux
	refer to https://docs.microsoft.com/en-us/windows/wsl/install-win10

## 2. Install Packages with yum

	export MainDir=/usr/bin
1. gcc:

	sudo yum group install "Development Tools"
	
	 sudo wget https://ftp.gnu.org/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.gz
	 sudo tar -zxvf gcc-8.3.0.tar.gz
	 ./contrib/download_prerequisites
	 sudo ./configure --enable-languages=c,c++,fortran --disable-multilib
	 sudo make
	 sudo make install
	 scl enable devtoolset-6 bash
	 scl enable devtoolset-8 bash
2. cmake:

	sudo yum install cmake

3. mpich
	 cd /usr/local
	 
	 sudo wget http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz
	 
	 sudo tar -zxvf mpich-3.3.2.tar.gz
	 
	 cd mpich-3.3.2
	 
	 sudo ./configure --prefix=$MainDir
	 
	 sudo make
	 
	 sudo make install
	 
4. zlib
export MainDir=/home/dalei

  	cd /home/dalei
	
	wget https://zlib.net/fossils/zlib-1.2.11.tar.gz
	
	
	tar -zxvf zlib-1.2.11.tar.gz
	
	cd zlib-1.2.11
	
	./configure --prefix=${MainDir}/zlib
	
	make
	
	make install
	
5. hdf5

	export CC=/usr/bin/bin/mpicc
	export CXX=/usr/bin/bin/mpicxx
	export FC=/usr/bin/bin/mpif90
	export F77=/usr/bin/bin/mpif77
	
  	cd ~/install
	
	wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.20/src/hdf5-1.8.20.tar.gz
	
	tar -zxvf hdf5-1.8.20.tar.gz
	
	cd hdf5-1.8.20
	
	./configure --prefix=${MainDir}/hdf5  --with-zlib=${MainDir}/zlib --enable-fortran --enable-fortran2003  --with-pic
	
	make
	
	make install
	
6. netcdf-c
	
	cd /usr/local
	sudo wget https://github.com/Unidata/netcdf-c/archive/v4.6.2.tar.gz
	sudo tar -zxvf v4.6.2.tar.gz
	cd netcdf-c-4.6.2
	 export CPPFLAGS="-I/home/dalei/zlib/include -I/home/dalei/hdf5/include"
	 export  CFLAGS="-I/home/dalei/zlib/include -I/home/dalei/hdf5/include"
	 export  LDFLAGS="-L/home/dalei/zlib/lib -L/home/dalei/hdf5/lib -lhdf5 -lhdf5_hl -lz"
	  export LD_LIBRARY_PATH="/home/dalei/hdf5/lib:/home/dalei/zlib/lib:$LD_LIBRARY_PATH"
	./configure --prefix=/home/dalei/netcdf --disable-shared  --disable-dap
	
	make 
	
	make install
	
	
	tar zxvf cmake-3.*
cd cmake-3.*
./bootstrap --prefix=/home/dalei/cmake
make -j$(nproc)
make install
7. netcdf-fortran 
	cd /home/dalei/install2
wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.3.tar.gz

tar xzvf v4.4.3.tar.gz
cd netcdf-fortran-4.4.3
 export CPPFLAGS="-I/home/dalei/zlib/include -I/home/dalei/hdf5/include -I/home/dalei/netcdf/include"
 export  CFLAGS="-I/home/dalei/zlib/include -I/home/dalei/hdf5/include  -I/home/dalei/netcdf/include"
 export  LDFLAGS="-L/home/dalei/zlib/lib -L/home/dalei/hdf5/lib  -L/home/dalei/netcdf/lib -lhdf5 -lhdf5_hl -lz"

./configure --prefix=/home/dalei/netcdf --disable-shared
make
make check
make install
		
sudo yum install "perl(XML::LibXML)"


## 3.  setup E3SM
 scl enable devtoolset-8 bash
cd ~/model1/e3sm/cime/config/
chmod -R 700 .
cd ../script
 export RES=1x1_brazil
 export COMPSET=ICLM45
 export COMPILER=gnu
 export MACH=WE39911
 export CASE_NAME=test16
 cd ~/model1/e3sm/cime/scripts
 ./create_newcase \
 -case ${CASE_NAME} \
 -compset ${COMPSET} \
 -res ${RES} \
 -compiler ${COMPILER} \
 -mach ${MACH}
 cd $CASE_NAME
 
./xmlchange STOP_N=1,STOP_OPTION=nyears
./xmlchange PIO_VERSION=1
 ./case.setup

./case.build






# Install packages in Cygwin (Windows 10)

## 1. Install Cygwin
    including some packages (git, wget, c++, c++g++, etc.)
    
## 2. Install Package Management Tool: apt-cyg
    link: https://www.ccammack.com/posts/install-cygwin-and-apt-cyg/   https://github.com/transcode-open/apt-cyg
    wget rawgit.com/transcode-open/apt-cyg/master/apt-cyg
    install apt-cyg /bin
    rm apt-cyg

## 3. Install necessary packages via apt-cyg
    gcc cmake netcdf perl-XML-LibXML gcc-fortune via apt-cyg
    mpich: http://people.cs.uchicago.edu/~asiegel/courses/cspp51085/quick-ref/mpich-install.txt (new version mpich-3.3.2.tar.gz)
    gmake:  Use make    % cd /bin
                        % ln -s make gmake
 
## 4. Clone E3SM code from github

## 5. Test Case



sudo apt install libxml2-utils

essential

netcdf libxml-libxml-perl

sudo ln -s /usr/bin/make /usr/bin/gmake

cmake

hdf5

https://www.wbhatti.org/notes/hdf5-with-cpp-support-debian.html

net-cdf-c

sudo ./configure --prefix=$ID/netcdf \
	--enable-shared --enable-static \
	--enable-netcdf-4 --disable-dap \
	CPPFLAGS="-I$ID/hdf5/include -I$ID/zlib/include" \
	LDFLAGS="-L$ID/hdf5/lib -Wl,-rpath=$ID/hdf5/lib \
	-L$ID/zlib/lib -Wl,-rpath=$ID/zlib/lib"
	
	
	
	Centos 7
	
	sudo yum group install "Development Tools": gcc g++ make
	sudo yum install cmake
	cd /usr/local
	sudo mkdir mpich
	cd mpich
	sudo wget http://www.mpich.org/static/downloads/3.1.3/mpich-3.1.3.tar.gz
	sudo tar -xf mpich-3.1.3.tar.gz 
	cd mpich-3.2.2
	sudo ./configure -prefix=/usr/bin |& tee c.txt
	sudo make 2>&1 | tee m.txt
	sudo make install 2>&1 | tee mi.txt
	
	sudo yum install "perl(XML::LibXML)"
	
	# Where to install libraries
	
export LIBBASE=/usr/bin

# Compilers
export SERIAL_FC=gfortran
export SERIAL_F77=gfortran
export SERIAL_CC=gcc
export SERIAL_CXX=g++
export MPI_FC=mpif90
export MPI_F77=mpif77
export MPI_CC=mpicc
export MPI_CXX=mpicxx
	
/usr/local/

zlib hdf5 netcdf

cmake
sudo wget https://src.fedoraproject.org/lookaside/extras/cmake/cmake-3.4.0-rc3.tar.gz/b949c919e82d5fe70cfd9e799f1da3a6/cmake-3.4.0-rc3.tar.gz

* zlib 
	cd /usr/local
	sudo mkdir zlib
	cd zlib
	sudo wget https://zlib.net/fossils/zlib-1.2.8.tar.gz
	sudo tar xzvf  zlib-1.2.8.tar.gz
	cd zlib-1.2.8
	sudo ./configure --prefix=/usr/bin/zlib
	sudo make
	sudo make install
	
* hdf5
	# Compilers
	export SERIAL_FC=gfortran
	export SERIAL_F77=gfortran
	export SERIAL_CC=gcc
	export SERIAL_CXX=g++
	export MPI_FC=mpif90
	export MPI_F77=mpif77
	export MPI_CC=mpicc
	export MPI_CXX=mpicxx
	cd /usr/local
	sudo mkdir hdf5
	cd hdf5
	sudo wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.14/src/hdf5-1.8.14.tar.bz2
	sudo tar xjvf hdf5-1.8.14.tar.bz2
	cd hdf5-1.8.14
	export FC=$MPI_FC
	export CC=$MPI_CC
	export CXX=$MPI_CXX
	sudo ./configure --prefix=/usr/bin --enable-parallel --with-zlib=/usr/bin --enable-fortran
	sudo make
	sudo make check
	sudo make install

* netcdf-c
${LIBBASE} = /usr/bin

cd /usr/local
	sudo mkdir netcdf
	cd netcdf
sudo wget https://github.com/Unidata/netcdf-c/archive/v4.4.0.tar.gz
sudo tar xzvf v4.4.0.tar.gz
cd netcdf-c-4.4.0
export CPPFLAGS="-I${LIBBASE}/include"
export LDFLAGS="-L${LIBBASE}/lib"
export LIBS="-lhdf5_hl -lhdf5 -lz -ldl"
export LD_LIBRARY_PATH=${LIBBASE}/lib:$LD_LIBRARY_PATH
export CC=$MPI_CC
sudo ./configure --prefix=${LIBBASE} --disable-dap --enable-netcdf4 --enable-pnetcdf --enable-parallel-tests --disable-shared
make
make check
make install
export NETCDF=${LIBBASE}


netcdf-fortran 
sudo wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.3.tar.gz

tar xzvf v4.4.3.tar.gz
cd netcdf-fortran-4.4.3
export FC=$MPI_FC
export F77=$MPI_F77
export LIBS="-lnetcdf ${LIBS}"
./configure --prefix=${LIBBASE} --enable-parallel-tests --disable-shared
make
make check
make install
	
	
	https://modules.readthedocs.io/en/latest/INSTALL.html
	install environmental modules:
	sudo yum install tcl
	sudo yum install tcl-devel
	
