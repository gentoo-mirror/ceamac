# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#Ebuild based on the booboo overlay version

EAPI=7

inherit autotools eutils multilib flag-o-matic

# Original TODO from bgo-overlay
# Todo: enable OpenGL (currently not compiling)
#       enable OpenCl, needs check whether OpenCL is actually usable

DESCRIPTION="Film-Quality Vector Animation (core engine)"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="imagemagick ffmpeg dv openexr truetype jpeg fontconfig"

DEPEND="
	~dev-cpp/ETL-${PV}
	>=dev-cpp/glibmm-2.4:2
	dev-libs/boost
	sys-libs/zlib
	dev-libs/libsigc++:2
	dev-cpp/libxmlpp:2.6
	media-libs/libpng
	media-libs/mlt
	x11-libs/pango
	x11-libs/cairo
	sci-libs/fftw:3.0
	ffmpeg? ( media-video/ffmpeg )
	openexr? ( media-libs/openexr )
	truetype? ( media-libs/freetype )
	fontconfig? ( media-libs/fontconfig )
	jpeg? ( virtual/jpeg )
	"
RDEPEND="${DEPEND}
	dv? ( media-libs/libdv )
	imagemagick? ( media-gfx/imagemagick )
	"

src_prepare() {
	eapply_user

	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with ffmpeg) \
		$(use_with fontconfig) \
		$(use_with imagemagick) \
		$(use_with dv libdv) \
		$(use_with openexr ) \
		$(use_with truetype freetype) \
		$(use_with jpeg)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS COPYING NEWS README TODO

	echo "LDPATH=\"/usr/lib64/synfig/modules\"" > "${T}/99synfig"
	doenvd "${T}/99synfig"
}
