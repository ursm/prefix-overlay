# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix 2"

inherit python mercurial

KEYWORDS="~x86-macos"

DESCRIPTION="Branch of hg forest extension (http://hg.akoha.org/hgforest) working with hg crew repository"
HOMEPAGE="http://www.bitbucket.org/pmezard/hgforest-crew/overview/"
EHG_REPO_URI="https://bitbucket.org/pmezard/hgforest-crew/"

LICENSE=""
SLOT="0"
IUSE=""

DEPEND="dev-util/mercurial"
RDEPEND=${DEPEND}

S="${WORKDIR}/${PN}-crew"

src_install() {
	insinto "$(python_get_sitedir)/hgext"
	doins forest.py
}

src_test() {
	PYTHONPATH="." "${python}" tests/test-forest.py || die "tests failed"
}
