# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="console fourcc changer"
HOMEPAGE="https://github.com/mypapit/cfourcc"
SRC_URI="https://github.com/mypapit/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	sed -i 's/CFLAGS=/CFLAGS+=/
	s/$(CFLAGS)/$(CFLAGS) $(LDFLAGS)/
	s/strip/#strip/' Makefile || die
}

src_install() {
	mkdir "${D}/bin"
	emake install PREFIX="${D}" || die "install failed"
	dodoc AUTHORS BUGS ChangeLog codeclist.txt README README.md TIPS TODO
}
