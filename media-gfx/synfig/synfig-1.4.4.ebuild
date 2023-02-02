# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Film-Quality Vector Animation (core engine)"
HOMEPAGE="https://www.synfig.org/"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dv fontconfig jpeg opencl openexr"

DEPEND="
	~dev-cpp/ETL-${PV}
	>=dev-cpp/glibmm-2.4:2
	dev-cpp/libxmlpp:2.6
	dev-libs/glib:2
	dev-libs/libltdl
	dev-libs/libsigc++:2
	media-gfx/imagemagick:=[cxx]
	media-libs/libmng:=
	media-libs/libpng:=
	media-libs/mlt:=
	media-video/ffmpeg:=
	sci-libs/fftw:3.0=
	sys-libs/zlib:=
	x11-libs/cairo
	fontconfig? (
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/pango
	)
	jpeg? ( media-libs/libjpeg-turbo:= )
	openexr? ( media-libs/openexr:0= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/intltool-0.35.0
	sys-devel/libtool
	opencl? ( virtual/opencl )
"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		--with-imagemagick \
		--with-ffmpeg \
		$(use_with fontconfig) \
		$(use_with dv libdv) \
		$(use_with openexr ) \
		$(use_with fontconfig freetype) \
		$(use_with jpeg) \
		$(use_with opencl)
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die

	newenvd - 95synfig <<- EOF
	LDPATH="${EPREFIX}/usr/$(get_libdir)/synfig/modules"
	EOF
}
