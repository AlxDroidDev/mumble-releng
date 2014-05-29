#!/bin/bash -ex
# Copyright 2013-2014 The 'mumble-releng' Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file in the source tree or at
# <http://mumble.info/mumble-releng/LICENSE>.

source common.bash

if [ -d qt-icns-iconengine-qt5 ]; then
	cd qt-icns-iconengine-qt5
else
	git clone git://github.com/mkrautz/qt-icns-iconengine.git qt-icns-iconengine-qt5
	cd qt-icns-iconengine-qt5
	git checkout qt5
fi

export PATH=${MUMBLE_PREFIX}/Qt5.2/bin:${PATH}
qmake
make