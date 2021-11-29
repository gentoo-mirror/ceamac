# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#Ebuild based on the booboo overlay version

EAPI=7

inherit autotools

# Original TODO from bgo-overlay
# Todo: enable OpenGL (currently not compiling)
#       enable OpenCl, needs check whether OpenCL is actually usable

DESCRIPTION="Film-Quality Vector Animation (core engine)"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dv fontconfig harfbuzz jpeg opencl openexr truetype"

REQUIRED_USE="
	fontconfig? ( truetype )
	harfbuzz? ( truetype )
	"

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
	fontconfig? ( media-libs/fontconfig )
	jpeg? ( virtual/jpeg )
	openexr? (
		media-libs/ilmbase:=
		media-libs/openexr:0=
	)
	truetype? (
		media-libs/freetype
	)
	harfbuzz? (
		dev-libs/fribidi
		media-libs/harfbuzz:=
	)
	"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/intltool-0.35.0
	sys-devel/libtool
	opencl? ( virtual/opencl )
	"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.0-fix-cflags.patch
)

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
		$(use_with truetype freetype) \
		$(use_with harfbuzz) \
		$(use_with jpeg) \
		$(use_with opencl)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README TODO

	find "${ED}" -name '*.la' -delete || die

	echo "LDPATH=\"${EPREFIX}/usr/$(get_libdir)/synfig/modules\"" > "${T}/99synfig"
	doenvd "${T}/99synfig"
}
