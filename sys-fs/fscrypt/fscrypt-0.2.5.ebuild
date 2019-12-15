# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Native filesystem encryption tool"
HOMEPAGE="https://github.com/google/fscrypt"

LICENSE="Apache-2.0 MIT BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="sys-libs/pam:=
	dev-libs/protobuf:="

EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="6821d90d7c449b63d602c272d5ffa19243a7c517"
S=${WORKDIR}/${PN}-${EGIT_COMMIT}

EGO_VENDOR=(
	"github.com/cpuguy83/go-md2man eda4fa589184806b8720ea3b9146491209877a10"
	"github.com/golang/protobuf ed6926b37a637426117ccab59282c3839528a700"
	"github.com/pkg/errors 7f95ac13edff643b8ce5398b6ccab125f8a20c1a"
	"github.com/urfave/cli 42b931bfe711efbe8f30750ffa66af4a21171fe6"
	"golang.org/x/crypto e9b2fee46413994441b28dfca259d911d963dfed github.com/golang/crypto"
	"golang.org/x/sys ac6580df4449443a05718fd7858c1f91ad5f8d20 github.com/golang/sys"
)

inherit go-module

SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

# I don't understand how this is supposed to work
# It downloads from github at compile time, should not do that
# works only with FEATURES="-network-sandbox"
src_compile() {
	(
		unset GOFLAGS
		GOPATH=${WORKDIR}/go
		cd "${S}" && go build --ldflags '-s -w -X "main.version=v0.2.5" -extldflags ""' -v -o bin/fscrypt ./cmd/fscrypt
	)
}

src_install() {
	dodoc "${S}/README.md"
	dobin "${S}/bin/fscrypt"
}
