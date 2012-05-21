# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/openclonk/openclonk-5.2.2.ebuild,v 1.2 2012/05/12 22:40:39 hasufell Exp $

EAPI=3

inherit autotools eutils flag-o-matic python games

MY_P=${PN}-release-${PV}-src

DESCRIPTION="A free multiplayer action game where you control clonks"
HOMEPAGE="http://openclonk.org/"
SRC_URI="http://hg.${PN}.org/${PN}/archive/${MY_P}.tar.gz
	http://${PN}.org/homepage/icon.png -> ${PN}.png"

LICENSE="BSD ISC CLONK-trademark LGPL-2.1 POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated doc mp3 sound"

RDEPEND="
	media-libs/libpng:0
	sys-libs/zlib
	virtual/jpeg
	!dedicated? (
		media-libs/freetype:2
		media-libs/glew
		media-libs/libsdl[X,opengl,video]
		virtual/opengl
		virtual/glu
		x11-libs/cairo
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:3
		x11-libs/libXpm
		x11-libs/libXrandr
		x11-libs/libXxf86vm
		x11-libs/libX11
		sound? ( media-libs/libsdl[audio]
			media-libs/sdl-mixer[mp3?,vorbis,wav] )
		)
	dedicated? ( sys-libs/readline:0 )"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.40
	virtual/pkgconfig
	doc? (
		=dev-lang/python-2*
		dev-libs/libxml2[python]
		sys-devel/gettext
		)
	"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# remove license files
	sed \
		-e '/dist_doc_DATA/s#planet/COPYING ##' \
		-e '/dist_doc_DATA/s#licenses/LGPL.txt ##' \
		-i Makefile.am || die

	# verbose
	sed \
		-e "/AM_SILENT_RULES/d" \
		-i configure.ac || die

	eautoreconf
}

src_configure() {
	# QA
	append-flags -fno-strict-aliasing

	egamesconf \
		$(use_enable dedicated console) \
		$(use_enable sound) \
		$(use_enable mp3) \
		$(usex dedicated "--with-gtk=no" "--with-gtk=3.0") \
		--without-openal \
		--with-automatic-update=no
}

src_compile() {
	emake || die

	if use doc ; then
		emake -C docs || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if ! use dedicated; then
		newgamesbin "${FILESDIR}"/${PN}-wrapper-script.sh ${PN} || die
		doicon "${DISTDIR}"/${PN}.png
		make_desktop_entry ${PN}
	fi
	use doc && dohtml -r docs/online/*

	prepgamesdirs
}