
Docker APK Build Environment
============================

An alpine linux environment for building apk packages using docker.

See http://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package for additional
documentation and
https://engineering.fundingcircle.com/blog/2015/04/28/create-alpine-linux-repository/
for some background about testing and signing packages.


.. contents::
    :backlinks: none


Setup
-----

To sign packages you'll need a key pair. To generate a pair of keys for this
purpose run:

.. code:: sh

    # builds an image and starts a container
    make build
    # generate keys
    ~/bin/setup.sh


Building a Package
------------------

Run ``make build`` to start the docker environment. In the build environment
cd to the package directory which contains an ``APKBUILD`` file and run
the build.

.. code:: sh

    cd /work/<repo>/<package>
    # Condtionally rebuild checksums if files has changed
    abuild checksum
    # Run the build
    abuild -c -r -P /target

The built packages will be in ``./target`` on the host.


Indexing and Signing
--------------------

.. code:: sh

    cd /target/<repo>/<arch>/
    apk index -o APKINDEX.tar.gz *.apk
    abuild-sign APKINDEX.tar.gz


Testing the Package
-------------------

.. code:: sh

    make test
    apk add <package>@custom
