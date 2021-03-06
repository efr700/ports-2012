# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="5-progress"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.6 *-jython *-pypy-*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Python to GNU Octave bridge"
HOMEPAGE="https://github.com/blink1073/oct2py https://pypi.python.org/pypi/oct2py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
# IUSE="doc examples ipython"
IUSE="examples ipython"

RDEPEND="$(python_abi_depend dev-python/numpy)
	$(python_abi_depend sci-libs/scipy)
	sci-mathematics/octave[gnuplot]
	ipython? ( $(python_abi_depend -e "3.1" dev-python/ipython) )"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"
#	doc? ( $(python_abi_depend dev-python/sphinx) )

DOCS="AUTHORS.rst HISTORY.rst README.rst thanks.txt"

src_compile() {
	distutils_src_compile

#	if use doc; then
#		einfo "Generation of documentation"
#		PYTHONPATH="build-$(PYTHON -f --ABI)/lib" sphinx-build docs html || die "Generation of documentation failed"
#	fi
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -r "${ED}$(python_get_sitedir)/oct2py/"{ipython/tests,tests}
	}
	python_execute_function -q delete_tests

#	if use doc; then
#		dohtml -r html/
#	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r example/*
	fi
}
