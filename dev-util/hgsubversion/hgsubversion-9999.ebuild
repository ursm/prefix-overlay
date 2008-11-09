# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix 2"

inherit python mercurial

KEYWORDS="~x86-macos"

DESCRIPTION="hgsubversion is an extension for Mercurial that allows using Mercurial as a Subversion client."
HOMEPAGE="http://www.bitbucket.org/durin42/hgsubversion/overview/"
EHG_REPO_URI="https://bitbucket.org/durin42/hgsubversion/"

LICENSE=""
SLOT="0"
IUSE=""

DEPEND="dev-util/mercurial dev-util/subversion"
RDEPEND=${DEPEND}

S="${WORKDIR}/${PN}"

src_install() {
	insinto "$(python_get_sitedir)/hgext"
	doins -r ${S}
}

src_test() {
	PYTHONPATH="." "${python}" tests/run.py || die "tests failed"
}
