# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jist/jist-1.5.1.ebuild,v 1.4 2013/10/26 13:56:02 hasufell Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A ruby gem to publish a gist"
HOMEPAGE="http://github.com/ConradIrwin/jist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

ruby_add_rdepend "dev-ruby/json"
