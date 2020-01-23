# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="A Qt-based client-side and server-side SOAP component"
HOMEPAGE="https://github.com/KDAB/KDSoap/"
SRC_URI="https://github.com/KDAB/KDSoap/releases/download/${P}/${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2 GPL-3 LGPL-2.1 AGPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-frameworks/extra-cmake-modules:5
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"
