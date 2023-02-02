# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Vector animation studio"
HOMEPAGE="https://www.synfig.org"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2+ CC-BY-3.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jack"

DEPEND="
	dev-cpp/atkmm:0
	dev-cpp/cairomm:0
	~dev-cpp/ETL-${PV}
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-cpp/libxmlpp:2.6
	dev-cpp/pangomm:1.4
	dev-libs/glib:2
	dev-libs/libsigc++:2
	~media-gfx/synfig-${PV}
	media-libs/mlt:=
	x11-libs/cairo
	x11-libs/gtk+:3
	jack? ( virtual/jack )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf $(use_enable jack)
}

src_install() {
	default

	mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
	rm -r "${ED}"/usr/share/mime || die
	find "${ED}" -name '*.la' -delete || die
}
