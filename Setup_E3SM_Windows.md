
# Setup E3SM in Cygwin (Windows 10)

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
