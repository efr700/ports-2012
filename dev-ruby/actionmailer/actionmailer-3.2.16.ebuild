# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionmailer/actionmailer-3.2.16.ebuild,v 1.1 2013/12/04 08:05:48 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="actionmailer.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="http://rubyforge.org/projects/actionmailer/"
SRC_URI="http://github.com/rails/rails/archive/v${PV}.tar.gz -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RUBY_S="rails-${PV}/${PN}"

ruby_add_rdepend "~dev-ruby/actionpack-${PV}
	>=dev-ruby/mail-2.5.4:2.5"
ruby_add_bdepend "test? (
	dev-ruby/test-unit:2
	dev-ruby/mocha:0.13
)"

all_ruby_prepare() {
	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/\/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"

	# Make sure we use the test-unit gem since ruby18 does not provide
	# all the test-unit features needed.
	sed -i -e '1igem "test-unit"' test/abstract_unit.rb || die
}
