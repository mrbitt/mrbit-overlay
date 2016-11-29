# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spring/spring-1.1.3.ebuild,v 1.2 2014/09/09 06:46:21 graaff Exp $

EAPI=5
USE_RUBY="ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="COPYING README.md"

RUBY_FAKEGEM_TASK_TEST="test:unit"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit multilib ruby-fakegem 

DESCRIPTION="2D game development library for the Ruby and C++ programming languages"
HOMEPAGE="https://github.com/jlnr/gosu"

LICENSE="MIT"
SLOT="1.1"
KEYWORDS="amd64"

IUSE=""

ruby_add_rdepend ">=dev-ruby/rubygems-2.1.0"
#ruby_add_bdepend "test? ( dev-ruby/bundler dev-ruby/activesupport virtual/ruby-minitest )"

CDEPEND="
	media-libs/openal
	media-libs/freeglut
	x11-libs/libXinerama
	media-libs/libsndfile
	media-libs/freeimage
	media-libs/sdl2-ttf"
DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}"

#all_ruby_prepare() {
#	sed -i -e '/files/d' ${PN}.gemspec || die
#}

each_ruby_configure() {
	${RUBY} -Cext/gosu extconf.rb || die
}

each_ruby_compile() {
	emake -C ext/gosu V=1
    cp ext/*/*$(get_modname) lib/ || die
}
