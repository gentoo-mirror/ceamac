# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools xdg

MY_PV=${PV//./}

DESCRIPTION="The most advanced non-linear video editor and compositor"
HOMEPAGE="https://www.cinelerra-gg.org/"
SRC_URI="https://cinelerra-gg.org/download/pkgs/src/cin_5.1.${MY_PV}-src.tgz"
S="${WORKDIR}/cinelerra-5.1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug dvb ieee1394 lv2 oss shuttle usb v4l"
RESTRICT="mirror"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	dev-libs/imath:3=
	media-libs/libjpeg-turbo:=
	media-libs/dav1d:=
	media-libs/flac:=
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/jbigkit:=
	media-libs/libaom:=
	media-libs/libdv
	>=media-libs/libogg-1.2
	media-libs/libpng:0=
	media-libs/libpulse
	media-libs/libsndfile
	>=media-libs/libtheora-1.1
	>=media-libs/libvorbis-1.3
	media-libs/libva:=
	media-libs/libvpx:=
	media-libs/libwebp:=
	media-libs/openexr:=
	media-libs/opus
	media-libs/tiff:=
	sci-libs/fftw:3.0=
	sys-libs/zlib
	sys-process/numactl
	x11-libs/libvdpau
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXv
	virtual/glu
	virtual/opengl
	virtual/libusb:1
	alsa? ( media-libs/alsa-lib )
	ieee1394? (
		media-libs/libiec61883:=
		>=sys-libs/libavc1394-0.5.0:=
		>=sys-libs/libraw1394-1.2.0:=
	)
	lv2? (
		app-accessibility/at-spi2-core:2
		dev-libs/glib:2
		dev-libs/serd
		dev-libs/sord
		media-libs/harfbuzz:=
		media-libs/lilv
		media-libs/sratom
		media-libs/suil
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:2
		x11-libs/pango
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/xz-utils
	dev-lang/yasm
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-ffmpeg
		--without-esound
		--with-gl
		--with-xft
		--with-dv
		--with-openexr

		$(use_with oss)
		$(use_with alsa)
		$(use_with ieee1394 firewire)
		$(use_with dvb)
		$(use_with v4l video4linux2)
		$(use_with usb shuttle_usb)
		$(use_with shuttle)
		$(use_with lv2)

		--with-plugin-dir="${EPREFIX}/usr/$(get_libdir)/${PN}"
	)
	use debug && myconf+=( '--enable-x-error-output' )

	econf "${myconf[@]}"
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	dodoc README
	docinto html
	dodoc -r doc/*.png doc/*.html doc/*.texi doc/*.pdf
}
