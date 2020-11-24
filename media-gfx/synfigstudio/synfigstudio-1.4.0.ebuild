# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Original ebuild By eroen <eroen-overlay@occam.eroen.eu>, 2018
# Modified by <ceamac.paragon@gmail.com>, 2020
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.

EAPI=7

inherit autotools eutils multilib flag-o-matic xdg-utils

DESCRIPTION="Vector animation studio"
HOMEPAGE="https://www.synfig.org"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2+ CC-BY-3.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-gfx/synfig
	dev-libs/libsigc++:2
	dev-cpp/gtkmm:3.0
	dev-cpp/libxmlpp:2.6
	sys-devel/gettext
	"
DEPEND="${RDEPEND}
	dev-cpp/ETL
	virtual/pkgconfig
	"

src_prepare() {
	eapply_user

	default
	eautoreconf
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
