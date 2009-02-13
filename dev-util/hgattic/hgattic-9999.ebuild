# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix 2"

inherit python mercurial

KEYWORDS="~x86-macos"

DESCRIPTION="Deals with a set of patches in the folder .hg/attic. At any time you can shelve your current working copy changes there or unshelve a patch from the folder."
HOMEPAGE="http://www.bitbucket.org/Bill_Barry/hgattic/"
EHG_REPO_URI="http://www.bitbucket.org/Bill_Barry/hgattic/"

LICENSE=""
SLOT="0"
IUSE=""

DEPEND="dev-util/mercurial"
RDEPEND=${DEPEND}

S="${WORKDIR}/${PN}"

src_install() {
	insinto "$(python_get_sitedir)/hgext"
	doins -r ${S}
}
