# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lib_users/lib_users-0.6-r1.ebuild,v 1.5 2013/12/24 12:50:08 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit python-r1

DESCRIPTION="Checks /proc for libraries being mapped but marked as deleted"
HOMEPAGE="http://schwarzvogel.de/software-misc.shtml"
SRC_URI="http://schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc x86 ~amd64-linux ~x86-linux"
IUSE="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND="${PYTHON_DEPS}"

src_test() {
	python_foreach_impl nosetests --verbosity=2
}

src_install() {
	python_foreach_impl python_newscript lib_users.py lib_users
	dodoc README TODO
}
