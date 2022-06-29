#!/usr/bin/env python
from __future__ import print_function
import os
import sys

from setuptools import Extension, setup, find_packages
from Cython.Build import cythonize


PACKAGES = find_packages()
MOD_NAMES = ["macos_signpost.log"]


def clean(path):
    for name in MOD_NAMES:
        name = name.replace(".", "/")
        for ext in [".so", ".html", ".cpp", ".c"]:
            file_path = os.path.join(path, name + ext)
            if os.path.exists(file_path):
                os.unlink(file_path)


def setup_package():
    extensions = [
        Extension(
            "macos_signpost.signpost",
            ["macos_signpost/signpost.pyx"],
            libraries=["blas"],
        ),
    ]

    setup(
        name="macos_signpost",
        zip_safe=True,
        packages=PACKAGES,
        package_data={"": ["*.pyx", "*.pxd"]},
        ext_modules=cythonize(extensions),
    )


if __name__ == "__main__":
    setup_package()
