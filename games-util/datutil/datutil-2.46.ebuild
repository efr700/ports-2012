# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/datutil/datutil-2.46.ebuild,v 1.3 2010/01/20 19:41:50 maekke Exp $

inherit toolchain-funcs

DL_PV=2.36
DESCRIPTION="Converter for dat files for Rom Managers"
HOMEPAGE="http://www.logiqx.com/Tools/DatUtil/"
SRC_URI="http://www.logiqx.com/Tools/DatUtil/dutil${PV//.}.zip
	http://www.logiqx.com/Tools/DatLib/datlib${DL_PV//.}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack dutil${PV//.}.zip
	cd "${S}"
	mkdir -p dev/datlib
	cd dev/datlib
	unpack datlib${DL_PV//.}.zip
}

src_compile() {
	# Parallel make issue, see bug #244879 (so make the dirs first)
	emake -j1 CC="$(tc-getCC)" LD="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" \
	CFLAGS="${CFLAGS} -Idev" LOGIQX=. EXT= UPX=@# dlmaketree maketree || die "emake failed"
	emake CC="$(tc-getCC)" LD="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" \
	CFLAGS="${CFLAGS} -Idev" LOGIQX=. EXT= UPX=@# || die "emake failed"
}

src_install() {
	dobin datutil || die "cannot install datutil"
	dodoc readme.txt whatsnew.txt
}
