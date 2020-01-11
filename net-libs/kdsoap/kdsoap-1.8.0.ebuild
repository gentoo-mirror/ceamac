# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="A fast replacement for tigetvnc"
HOMEPAGE="https://github.com/KDAB/KDSoap/"
SRC_URI="https://github.com/KDAB/KDSoap/releases/download/${P}/${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2 GPL-3 LGPL-2.1 AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-frameworks/extra-cmake-modules"
RDEPEND="${DEPEND}"
