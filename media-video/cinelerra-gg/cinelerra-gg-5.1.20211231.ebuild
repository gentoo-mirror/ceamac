# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="The most advanced non-linear video editor and compositor"
HOMEPAGE="http://www.cinelerra-gg.org/"
SRC_URI="https://cinelerra-gg.org/download/pkgs/src/cin_${PV}.src.tgz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug dvb ieee1394 lv2 oss shuttle usb v4l"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	media-libs/dav1d:=
	media-libs/flac
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/ilmbase:=
	media-libs/jbigkit:=
	media-libs/libaom:=
	media-libs/libdv
	>=media-libs/libogg-1.2
	media-libs/libpng:0=
	media-libs/libsndfile
	>=media-libs/libtheora-1.1
	>=media-libs/libvorbis-1.3
	media-libs/libvpx:=
	media-libs/libwebp:=
	>=media-libs/openexr-1.5:=
	media-libs/opus
	media-libs/tiff
	media-sound/pulseaudio
	sci-libs/fftw:3.0=
	sys-libs/zlib
	sys-process/numactl
	x11-libs/libva:=
	x11-libs/libvdpau
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXv
	virtual/glu
	virtual/jpeg:0
	virtual/opengl
	virtual/libusb:1
	alsa? ( media-libs/alsa-lib )
	ieee1394? (
		media-libs/libiec61883:=
		>=sys-libs/libavc1394-0.5.0:=
		>=sys-libs/libraw1394-1.2.0:=
	)
	lv2? (
		dev-libs/atk
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
	)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-lang/yasm
	virtual/pkgconfig"
BDEPEND=""

S="${WORKDIR}/cinelerra-5.1"

src_prepare() {
	default
	eautoreconf

	cp "${FILESDIR}"/openexr-2.4.1.patch1 ./thirdparty/src/ || die
}

src_configure() {
	# this doesn't really work
	append-ldflags -Wl,-z,noexecstack #212959

	local myconf
	use debug && myconf='--enable-x-error-output'

	econf \
		--enable-ffmpeg \
		$(use_with oss) \
		$(use_with alsa) \
		--without-esound \
		$(use_with ieee1394 firewire) \
		--with-gl \
		--with-xft \
		--with-dv \
		$(use_with dvb) \
		$(use_with v4l video4linux2) \
		$(use_with usb shuttle_usb) \
		$(use_with shuttle) \
		$(use_with lv2) \
		--with-openexr \
		--with-plugin-dir="${EPREFIX}/usr/$(get_libdir)/${PN}" \
		${myconf}
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	readarray -d '' HTML_DOCS < <(find doc/ \( -name \*.png -o -name \*.html -o -name \*.texi -o -name \*.swd \) -print0)
	einstalldocs

	rm -rf "${ED}"/usr/include || die
	find "${ED}" -name '*.la' -type f -delete || die
}
