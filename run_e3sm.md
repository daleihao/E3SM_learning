# Get the E3SM code
git clone https://github.com/daleihao/E3SM.git e3sm
 
cd e3sm
git fetch origin
git checkout origin/master
git submodule update --init --recursive
