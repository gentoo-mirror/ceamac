# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Small utility to control a few parameters on Ryzen"
HOMEPAGE="https://github.com/qrwteyrutiyoup/ryzen-stabilizator"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="90a2f7adc94baa484cbf2590455fb1f4a25126d8"
EGO_VENDOR=(
	"github.com/BurntSushi/toml 3012a1dbe2e4bd1391d42b32f0577cb7bbc7f005"
	"github.com/klauspost/cpuid 5a626f7029c910cc8329dae5405ee4f65034bce5"
)

inherit golang-vcs-snapshot

SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

src_compile() {
	GOPATH="${S}" \
		go install -v -work -x ${EGO_BUILD_FLAGS} \
		"${EGO_PN}" || die
}

src_install() {
	(
		mkdir -p "etc/modules-load.d"
		echo msr > "etc/modules-load.d/ryzen-stabilizator.conf"
		insinto /etc/modules-load.d
		doins etc/modules-load.d/ryzen-stabilizator.conf
	)

	(
		insinto /etc/ryzen-stabilizator
		sed 's/^[^#]/#/' "${S}/src/${EGO_PN}/contrib/settings.toml.sample" > settings.toml
		doins settings.toml
	)

	(
		insinto /lib/systemd/system
		doins "${S}/src/${EGO_PN}/contrib/systemd/"{ryzen-stabilizator@boot.service,ryzen-stabilizator@resume.service,ryzen-stabilizator.service,ryzen-stabilizator.target}
	)

	doinitd "${FILESDIR}/ryzen-stabilizator"

	dodoc "${S}/src/${EGO_PN}/README.md"
	dobin "${S}/bin/ryzen-stabilizator"
}
