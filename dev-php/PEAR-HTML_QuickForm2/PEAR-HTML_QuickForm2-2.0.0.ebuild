# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_QuickForm2/PEAR-HTML_QuickForm2-2.0.0.ebuild,v 1.1 2013/11/14 22:00:32 mabi Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="The PEAR::HTML_QuickForm package provides methods for creating, validating, processing HTML forms."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/php-5.2.0"
RDEPEND="${DEPEND}
	>=dev-php/PEAR-HTML_Common2-2.0.0"
