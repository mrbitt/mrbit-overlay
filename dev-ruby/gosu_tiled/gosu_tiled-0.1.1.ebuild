# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spring/spring-1.1.3.ebuild,v 1.2 2014/09/09 06:46:21 graaff Exp $

EAPI=5
USE_RUBY="ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CONTRIBUTING.md README.md"

RUBY_FAKEGEM_TASK_TEST="test:unit"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit multilib ruby-fakegem 

DESCRIPTION="Makes it easy to load tile maps built with Tiled editor into Gosu games"
HOMEPAGE="https://github.com/jlnr/gosu"

LICENSE="MIT"
SLOT="1.1"
KEYWORDS="amd64"

IUSE=""

ruby_add_rdepend ">=dev-ruby/rubygems-2.1.0"
ruby_add_bdepend "test? ( dev-ruby/bundler dev-ruby/guard-rspec dev-ruby/json dev-ruby/rake )"

CDEPEND="dev-ruby/gosu
		 dev-ruby/json"

DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}"

all_ruby_prepare() {
	sed -i -e '/files/d' ${PN}.gemspec || die
}


