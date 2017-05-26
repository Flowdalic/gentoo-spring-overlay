# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

ESVN_REPO_URI="http://qtlobby.googlecode.com/svn/trunk/"

inherit games subversion eutils cmake-utils

DESCRIPTION="Qt-Lobby"
HOMEPAGE="http://code.google.com/p/qtlobby/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/qt-gui
	x11-libs/qt-core
	x11-libs/qt-script
	x11-libs/qt-xmlpatterns
	x11-libs/qscintilla
"

DEPEND="${RDEPEND}
"

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs} -DCMAKE_INSTALL_PREFIX="$GAMES_PREFIX""
	
	subversion_wc_info
	export SVN_REV="$ESVN_WC_REVISION (Gentoo,$ARCH)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
	#should better use ${GAMES_BINDIR} (without the /bin)
	#emake INSTALL_ROOT="${D}/usr" install
	#dogamesbin ${D}/usr/bin/qtlobby
	#rm ${D}/usr/bin/qtlobby
	dodir /usr/share/games/icons/hicolor/scalable/apps/
	mv ${WORKDIR}/${PF}/icons/heart.svg ${D}/usr/share/games/icons/hicolor/scalable/apps/heart.svg
}
