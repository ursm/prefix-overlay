# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nkf/nkf-2.0.7-r1.ebuild,v 1.1 2008/12/08 14:58:29 matsuu Exp $

inherit toolchain-funcs eutils perl-module distutils

DESCRIPTION="Network Kanji code conversion Filter with UTF-8/16 support"
HOMEPAGE="http://sourceforge.jp/projects/nkf/"
SRC_URI="mirror://sourceforge.jp//nkf/44486/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64-linux ~ia64-linux ~x86-linux ~x86-macos ~x64-macos"
IUSE="perl linguas_ja"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${P}.tar.gz

	cd "${S}"

	sed -i -e '/-o nkf/s:$(CFLAGS):$(CFLAGS) $(LDFLAGS):' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" nkf || die
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_compile
	fi
}

src_test() {
	emake test || die
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_test
	fi
}

src_install() {
	dobin nkf || die
	doman nkf.1
	if use linguas_ja; then
		./nkf -e nkf.1j > nkf.1
		doman -i18n=ja nkf.1
	fi
	dodoc nkf.doc
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_install
	fi
}
