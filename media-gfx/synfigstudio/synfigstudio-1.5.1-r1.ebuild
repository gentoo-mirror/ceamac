# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Original ebuild By eroen <eroen-overlay@occam.eroen.eu>, 2018
# Modified by <ceamac.paragon@gmail.com>, 2020
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.

EAPI=8

inherit autotools xdg-utils

DESCRIPTION="Vector animation studio"
HOMEPAGE="https://www.synfig.org"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2+ CC-BY-3.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fontconfig jack"

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
	media-gfx/synfig
	media-libs/mlt
	x11-libs/cairo
	x11-libs/gtk+:3
	fontconfig? (
		media-gfx/synfig[fontconfig]
		media-libs/fontconfig
	)
	jack? ( virtual/jack )
	"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.1-fix-cflags.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with fontconfig) \
		$(use_enable jack)
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs

	mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
	rm -r "${ED}"/usr/share/mime || die
	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
