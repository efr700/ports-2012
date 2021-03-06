# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/mksh/mksh-40f.ebuild,v 1.2 2012/09/22 20:04:21 ottxor Exp $

EAPI=4

inherit eutils toolchain-funcs unpacker

DESCRIPTION="MirBSD KSH Shell"
HOMEPAGE="http://mirbsd.de/mksh"
ARC4_VERSION="1.14"
SRC_URI="http://www.mirbsd.org/MirOS/dist/mir/mksh/${PN}-R${PV}.cpio.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND="app-arch/cpio"
RDEPEND=""
S="${WORKDIR}/${PN}"

src_prepare(){
	epatch "${FILESDIR}/${P}-etc-configurable.patch"
}

src_compile() {
	tc-export CC
	export CPPFLAGS="${CPPFLAGS} -DMKSH_DEFAULT_PROFILEDIR=\\\"${EPREFIX}/etc\\\""
	# we can't assume lto existing/enabled, so we add a fallback
	sh Build.sh -r -c lto || sh Rebuild.sh || die
}

src_install() {
	exeinto /bin
	doexe mksh
	doman mksh.1
	dodoc dot.mkshrc
}

src_test() {
	./test.sh || die
}
