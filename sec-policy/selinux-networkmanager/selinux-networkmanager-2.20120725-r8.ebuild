# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-networkmanager/selinux-networkmanager-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:05:20 swift Exp $
EAPI="4"

IUSE=""
MODS="networkmanager"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for networkmanager"

KEYWORDS="amd64 x86"
