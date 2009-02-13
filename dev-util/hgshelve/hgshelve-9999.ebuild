# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="prefix 2"

inherit python mercurial

KEYWORDS="~x86-macos"

DESCRIPTION="Provides the shelve command to lets you choose which parts of the changes in a working directory you'd like to set aside temporarily."
HOMEPAGE="http://freehg.org/u/tksoh/hgshelve/"
EHG_REPO_URI="http://freehg.org/u/tksoh/hgshelve/"

LICENSE=""
SLOT="0"
IUSE=""

DEPEND="dev-util/mercurial"
RDEPEND=${DEPEND}

S="${WORKDIR}/${PN}"

src_install() {
	insinto "$(python_get_sitedir)/hgext"
	doins hgshelve.py
}
