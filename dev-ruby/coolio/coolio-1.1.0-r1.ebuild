# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coolio/coolio-1.1.0-r1.ebuild,v 1.1 2012/03/14 18:40:06 matsuu Exp $

EAPI="4"
# iobuffer: -jruby -rbx
USE_RUBY="ruby18 ruby19 ree18"
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"
RUBY_FAKEGEM_NAME="cool.io"

inherit ruby-fakegem

MY_P="${RUBY_FAKEGEM_NAME}-${PV}"
DESCRIPTION="A high performance event framework for Ruby which uses the libev C library"
HOMEPAGE="http://coolio.github.com/"
SRC_URI="http://rubygems.org/downloads/${MY_P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libev"
RDEPEND="${DEPEND}"

ruby_add_rdepend ">=dev-ruby/iobuffer-1"

all_ruby_prepare() {
	epatch "${FILESDIR}/${P}-libev.patch" || die
	rm -r Gemfile* ext/libev ext/cool.io/libev.c || die
}

each_ruby_compile() {
	${RUBY} -S rake compile || die
}