# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/jaxodraw/jaxodraw-2.0.1.ebuild,v 1.1 2010/04/02 18:13:40 nelchael Exp $

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-trax"

inherit java-pkg-2 java-ant-2 versionator eutils

MY_PV=$(replace_version_separator 2 -)

DESCRIPTION="Java program for drawing Feynman diagrams"
HOMEPAGE="http://jaxodraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}_src.tar.gz
	http://downloads.sourceforge.net/jaxodraw/axodraw4j_2008_11_19.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex"

DEPEND=">=virtual/jdk-1.4
	latex? ( dev-texlive/texlive-pstricks )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/JaxoDraw-${MY_PV}"

src_install() {
	java-pkg_newjar build/${PN}-${MY_PV}.jar ${PN}.jar

	doicon etc/OS/Linux/*.png
	domenu etc/OS/Linux/${PN}.desktop

	use source && java-pkg_dosrc src/main/java/net

	dodoc src/doc/BUGS src/doc/CHANGELOG src/doc/README src/doc/TODO || die
	use doc && java-pkg_dojavadoc build/javadoc

	java-pkg_dolauncher "${PN}"

	if use latex; then
		dodir /usr/share/texmf/tex/latex/misc/
		insinto /usr/share/texmf/tex/latex/misc/
		doins "${S}/../axodraw4j.sty"
	fi
}

tex_regen() {
	if use latex; then
		einfo "Regenerating TeX database..."
		/usr/bin/mktexlsr /usr/share/texmf /var/spool/texmf > /dev/null
		eend $?
	fi
}

pkg_postinst() {
	tex_regen
}

pkg_postrm() {
	tex_regen
}
