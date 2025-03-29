# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN%*-bin}
DESCRIPTION="Jakarta XML Web Services implementation"
HOMEPAGE="https://eclipse-ee4j.github.io/metro-jax-ws/ https://github.com/eclipse-ee4j/metro-jax-ws"
SRC_URI="https://repo1.maven.org/maven2/com/sun/xml/ws/jaxws-ri/${PV}/jaxws-ri-${PV}.zip"
S="${WORKDIR}/${MY_PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-11:*"
RDEPEND=">=virtual/jre-11:*"
BDEPEND="app-arch/unzip"

src_install() {
	insinto /opt/${MY_PN}-${PV}
	doins -r lib samples

	exeinto /opt/${MY_PN}-${PV}/bin
	doexe bin/wsimport.sh bin/wsgen.sh
}
