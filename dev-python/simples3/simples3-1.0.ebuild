# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simples3/simples3-1.0.ebuild,v 1.3 2013/09/05 18:46:55 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="A fairly simple, decently quick python interface to Amazon's S3 storage service"
HOMEPAGE="http://sendapatch.se/projects/simples3/ http://pypi.python.org/pypi/simples3/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

DOCS=( changes.rst README TODO )

python_prepare_all() {
	sed -i -e "s/setuptools/distutils.core/" setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
