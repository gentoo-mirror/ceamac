# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Viewer for IP cameras ONVIF"
HOMEPAGE="https://gitlab.com/caspermeijn/onvifviewer/"
COMMITHASH=c0ac7f6bb62333dedf1fb59c0d7c9351dfc1e0b1
SRC_URI="https://gitlab.com/caspermeijn/onvifviewer/-/archive/${COMMITHASH}/${PN}-${COMMITHASH}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="kde-frameworks/extra-cmake-modules:5
	kde-frameworks/kirigami:5
	>=net-libs/kdsoap-1.8.50
	net-libs/kdsoap-ws-discovery-client
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
	dev-qt/qtnetwork:5
	dev-qt/qtdeclarative:5
	dev-qt/qtsvg:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kauth:5
	kde-frameworks/kconfig:5
	kde-frameworks/kcodecs:5
	kde-frameworks/ki18n:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kxmlgui:5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMITHASH}"

pkg_postinst()
{
	xdg_desktop_database_update
}

pkg_postrm()
{
	xdg_desktop_database_update
}
