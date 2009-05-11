# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qdbm/qdbm-1.8.77.ebuild,v 1.8 2009/03/30 18:48:49 armin76 Exp $

inherit eutils java-pkg-opt-2 multilib

IUSE="debug java perl ruby zlib"

DESCRIPTION="Quick Database Manager"
HOMEPAGE="http://qdbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
SLOT="0"

RDEPEND="java? ( >=virtual/jre-1.4 )
	perl? ( dev-lang/perl )
	ruby? ( virtual/ruby )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.4 )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	sed -i "/^JAVACFLAGS/s:$: ${JAVACFLAGS}:" java/Makefile.in

	epatch "${FILESDIR}"/${P}-runpath.diff
	epatch "${FILESDIR}"/${PN}-perl-runpath-vendor.diff

}

src_compile() {

	econf \
		$(use_enable debug) \
		$(use_enable zlib) \
		--enable-pthread \
		--enable-iconv \
		|| die
	emake mac || die

	local u

	for u in java perl ruby; do
		if ! use ${u}; then
			continue
		fi

		cd ${u}
		econf || die
		emake || die
		cd -
	done

}

src_test() {

	emake -j1 check-mac || die

	local u

	for u in java perl ruby; do
		if ! use ${u}; then
			continue
		fi

		cd ${u}
		emake -j1 check || die
		cd -
	done

}

src_install() {

	emake DESTDIR="${D}" install-mac || die

	dodoc ChangeLog NEWS README THANKS
	dohtml *.html

	rm -rf "${ED}"/usr/share/${PN}

	local u mydatadir=/usr/share/doc/${P}/html

	for u in java perl ruby; do
		if ! use ${u}; then
			continue
		fi

		cd ${u}
		emake DESTDIR="${D}" MYDATADIR=${mydatadir}/${u} install || die

		case ${u} in
			java)
				java-pkg_dojar "${ED}"/usr/$(get_libdir)/*.jar
				rm -f "${ED}"/usr/$(get_libdir)/*.jar
				;;
			perl)
				rm "${ED}"/$(perl -V:installarchlib | cut -d\' -f2)/*.pod
				;;
		esac
		cd -
	done

	rm -f "${ED}"/usr/bin/*test

}
