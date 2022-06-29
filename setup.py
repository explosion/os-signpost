#!/usr/bin/env python
from __future__ import print_function
import os

from setuptools import Extension, setup, find_packages
from Cython.Build import cythonize


PACKAGES = find_packages()
MOD_NAMES = ["os_signpost.cy"]


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
            "os_signpost.cy",
            ["os_signpost/cy.pyx"],
        ),
    ]

    setup(
        name="os-signpost",
        zip_safe=True,
        packages=PACKAGES,
        package_data={"": ["*.pyx", "*.pxd"]},
        ext_modules=cythonize(extensions),
    )


if __name__ == "__main__":
    setup_package()
