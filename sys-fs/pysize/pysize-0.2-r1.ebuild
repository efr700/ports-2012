# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/pysize/pysize-0.2-r1.ebuild,v 1.1 2013/12/04 09:17:46 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A graphical and console tool for exploring the size of directories"
HOMEPAGE="http://guichaz.free.fr/pysize/"
SRC_URI="http://guichaz.free.fr/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="gtk ncurses"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	gtk? ( dev-python/pygtk:2 )
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/psyco-${PV}-automagic.patch
	"${FILESDIR}"/${PV}-setuptools-automagic.patch
	)

python_prepare_all() {
	if ! use gtk; then
		sed \
			-e '/^from pysize.ui.gtk/d' \
		    -e "s~'gtk': ui_gtk.run,~~g" \
		    -e 's:ui_gtk.run,::g' \
		    -i pysize/main.py || die "Failed to remove gtk support"
		rm -rf pysize/ui/gtk || die "Failed to remove gtk support"
	fi

	if ! use ncurses; then
		sed \
			-e '/^from pysize.ui.curses/d' \
		    -e "s~'curses': ui_curses.run,~~g" \
		    -e 's:ui_curses.run,::g' \
		    -i pysize/main.py || die "Failed to remove ncurses support"
		rm -rf pysize/ui/curses || die "Failed to remove ncurses support"
	fi

	sed \
		-e '/for ui_run in/s:ui_ascii.run:ui_ascii.run, ui_ascii.run:g' \
		-i pysize/main.py || die

	distutils-r1_python_prepare_all
}
