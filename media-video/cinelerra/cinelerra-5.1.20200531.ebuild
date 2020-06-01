# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils multilib flag-o-matic

DESCRIPTION="The most advanced non-linear video editor and compositor"
HOMEPAGE="http://www.cinelerra-gg.org/"
SRC_URI="https://cinelerra-gg.org/download/pkgs/src/cin_${PV}-src.tgz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug ieee1394 oss dvb v4l shuttle usb lv2 openexr"

RDEPEND="media-libs/a52dec:=
	media-libs/faac:=
	media-libs/faad2:=
	>=media-libs/freetype-2
	media-libs/fontconfig
		media-libs/libdv:=
		>=media-libs/libogg-1.2:=
		media-libs/libpng:0=
		media-libs/libsndfile:=
		>=media-libs/libtheora-1.1:=
		>=media-libs/libvorbis-1.3:=
		>=media-libs/openexr-1.5:=
		media-libs/tiff:0=
		media-libs/x264:=
		media-sound/lame:=
		>=media-video/mjpegtools-2
		>=sci-libs/fftw-3
		x11-libs/libX11:=
		x11-libs/libXext:=
		x11-libs/libXft:=
		x11-libs/libXv:=
		x11-libs/libXvMC:=
		x11-libs/libXxf86vm:=
		x11-libs/libva:=
		virtual/ffmpeg
		media-video/ffmpeg:0[postproc(-)]
	virtual/jpeg:0
	alsa? ( media-libs/alsa-lib:= )
		ieee1394? (
	media-libs/libiec61883:=
	>=sys-libs/libraw1394-1.2.0:=
	>=sys-libs/libavc1394-0.5.0:=
	)
	virtual/glu
	virtual/opengl
	openexr? ( media-libs/openexr:= )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"
BDEPEND=""

S="${WORKDIR}/cinelerra-5.1"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cppflags -D__STDC_CONSTANT_MACROS #321945
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
		$(use_with openexr) \
		--with-plugin-dir=/usr/$(get_libdir)/${PN} \
		${myconf}
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dohtml -a png,html,texi,sdw -r doc/*

	rm -rf "${D}"/usr/include

	find "${D}" -name '*.la' -type f -delete || die
}
