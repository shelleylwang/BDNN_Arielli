#!/usr/bin/env python

from setuptools import Extension, setup

module1 = Extension('_FastPyRateC',
                    include_dirs=['./'],
                    sources=['FastPyRateC.cpp', 'FastPyRateC_wrap.cxx'],
                    extra_compile_args=['-std=c++14'])

setup(name='FastPyRateC',
      author='Xavier Meyer',
      author_email='xav.meyer@gmail.com',
      url='https://github.com/dsilvestro/PyRate',
      version='1.0',
      description='This is a package with the main function of PyRate optimzied and implemented in C++.',
      ext_modules=[module1])
