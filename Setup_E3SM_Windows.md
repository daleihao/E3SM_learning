
# Setup E3SM in Cygwin (Windows 10)

## 1. Install Cygwin
    including some packages (git, wget, c++, c++g++, etc.)
    
## 2. Install Package Management Tool: apt-cyg
    link: https://www.ccammack.com/posts/install-cygwin-and-apt-cyg/
    wget rawgit.com/transcode-open/apt-cyg/master/apt-cyg
    install apt-cyg /bin
    rm apt-cyg

## 3. Install necessary packages via apt-cyg
    gcc cmake netcdf perl-XML-LibXML gfortune via apt-cyg
    mpich: http://people.cs.uchicago.edu/~asiegel/courses/cspp51085/quick-ref/mpich-install.txt
    gmake:  Use make    % cd /bin
                        % ln -s make gmake
 
## 4. Clone E3SM code from github

## 5. Test Case
