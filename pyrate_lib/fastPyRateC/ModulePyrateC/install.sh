#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux; folder=Other;;
    Darwin*)    machine=Mac; folder=macOS;;
    CYGWIN*)    machine=Windows; folder=Windows;;
    MINGW*)     machine=Windows;  folder=Windows;;
    *)          machine="UNKNOWN"
esac

if [ ${machine} == "UNKNOWN" ]; then
  echo "This type of OS is not supported. Follow the manual installation instructions."
  exit
else
  echo "The installation will proceed for a '${machine}' system."
fi



echo "############################"
echo "Preparing boost c++ library."
# Get the boost c++ library
if [ ! -d "boost" ]; then
  echo ">Downloading"
  curl https://boostorg.jfrog.io/artifactory/main/release/1.84.0/source/boost_1_84_0.zip  -L -o boost_1_84_0.zip
  # Unzip it
  echo "> Unziping"
  unzip -q boost_1_84_0.zip
  # Move header files
  echo "> Moving files"
  mv boost_1_84_0/boost .
  # Clean up mess
  rm boost_1_84_0.zip
  rm -r boost_1_84_0
fi
echo "> done"
echo "############################"
echo ""



# Prepare swig interface
echo "############################"
echo "Preparing the Python interface"
swig -c++ -python FastPyRateC.i
echo "> done"
echo "############################"
echo ""



# Compiling the c++ code
echo "############################"
echo "Compiling the c++ code"
python setup.py build
echo "> done"
echo "############################"
echo ""



# Moving the library
echo "############################"
echo "Installing the library."

# remove old
if [ -f "../${folder}/_FastPyRateC.so" ]; then
  rm ../${folder}/_FastPyRateC.so
fi

mkdir -p "../${folder}/"
mv build/*/_FastPyRateC*.so ../${folder}/_FastPyRateC.so

echo "> done"
echo "############################"
echo ""



# Cleanup
echo "############################"
echo "Cleaning up."
rm FastPyRateC.py
rm FastPyRateC_wrap.cxx
rm -r build
rm -r boost
echo "> done"
echo "############################"
echo ""


# Checking status
if [ -f "../${folder}/_FastPyRateC.so" ]; then

  echo " >> Successful installation of FastPyRateC."

else

  echo " >> An error must avec occured during the installation."
  echo " >> Try to install the library manually."

fi
