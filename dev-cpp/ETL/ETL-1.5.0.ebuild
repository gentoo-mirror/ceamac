# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="ETL is a multi-platform class and template library"
HOMEPAGE="http://synfig.org"
SRC_URI="https://github.com/synfig/synfig/archive/refs/tags/v${PV}.tar.gz -> synfigstudio-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT=test

PATCHES=(
	"${FILESDIR}"/synfigstudio-1.5.0-fix-cflags.patch
)

S="${WORKDIR}/synfig-${PV}/ETL"

src_prepare() {
	default

	eautoreconf
}
