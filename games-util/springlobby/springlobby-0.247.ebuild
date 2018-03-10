# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit cmake-utils eutils flag-o-matic

DESCRIPTION="lobby client for spring rts engine"
HOMEPAGE="http://springlobby.info"
SRC_URI="http://www.springlobby.info/tarballs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
IUSE="+sound debug libnotify gstreamer"

RDEPEND="
	>=dev-libs/boost-1.35
	>=x11-libs/wxGTK-2.9
	net-misc/curl
	libnotify? (    x11-libs/libnotify )
	sound? (
			media-libs/openal
			media-libs/libvorbis
			media-libs/flac
			media-sound/mpg123
			media-libs/alure
	)
	gstreamer? (    media-libs/gstreamer )
"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0
"

src_unpack() {
	unpack $A
	cd "$S"
}

src_configure() {
	mycmakeargs=(
		-DOPTION_SOUND=$(usex sound)
		-DGSTREAMER=$(usex gstreamer)
		-DAUX_VERSION="(Gentoo,$ARCH)"
		-DCMAKE_INSTALL_PREFIX=/usr/games/
	)

	cmake-utils_src_configure
}

src_compile () {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	# bad
	dodir /usr/share/games/icons/hicolor/scalable/apps/
	mv "${D}/usr/games/share/icons/hicolor/scalable/apps/springlobby.svg" "${D}/usr/share/games/icons/hicolor/scalable/apps/springlobby.svg"
	rm "${D}/usr/share/games/pixmaps/" -fr
	dodir /usr/share/games/applications/
	mv "${D}/usr/games/share/applications/springlobby.desktop" "${D}/usr/share/games/applications/springlobby.desktop"
	rm "${D}/usr/games/share/applications/" -fr
	dodir /etc/env.d/
	echo 'XDG_DATA_DIRS="/usr/share/games"' >> "${D}/etc/env.d/99games"
}
