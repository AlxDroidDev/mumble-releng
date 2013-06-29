#!/bin/bash
SHA1="7df93ca2cc5274f0cef72ea71f06feed2594b92f"
curl -L -O "http://download.qt-project.org/official_releases/qt/5.0/5.0.2/single/qt-everywhere-opensource-src-5.0.2.tar.gz"
if [ "$(shasum -a 1 qt-everywhere-opensource-src-5.0.2.tar.gz | cut -b -40)" != "${SHA1}" ]; then
	echo qt5 checksum mismatch
	exit
fi
tar -zxf qt-everywhere-opensource-src-5.0.2.tar.gz
cd qt-everywhere-opensource-src-5.0.2
patch -p1 < ../patches/qt5-QOpenGL2ExState.patch
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS
export CFLAGS="-I$MUMBLE_PREFIX/include"
export CXXFLAGS="-I$MUMBLE_PREFIX/include"
OPENSSL_LIBS="-L$MUMBLE_PREFIX/lib -lssl -lcrypto" ./configure -v -platform macx-clang -no-c++11 -fully-process -static -no-reduce-exports -pch -nomake examples -nomake demos -nomake docs -nomake tests -release -qt-sql-sqlite -no-dbus -qt-pcre -qt-zlib -qt-libpng -qt-libjpeg -openssl-linked -mysql_config no -sdk ${OSX_SDK} -prefix ${MUMBLE_PREFIX}/Qt5.0 -opensource -confirm-license
make
make install
