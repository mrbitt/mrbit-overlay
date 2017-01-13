# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spring/spring-1.1.3.ebuild,v 1.2 2014/09/09 06:46:21 graaff Exp $

EAPI=5
USE_RUBY="ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC=""

RUBY_FAKEGEM_TASK_TEST="test:unit"
RUBY_FAKEGEM_EXTRADOC=" README LICENSE"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem eutils

DESCRIPTION="Ruby standard library mathn."
HOMEPAGE="https://github.com/rubysl/rubysl-mathn"
#SRC_URI="https://github.com/rubysl/${PN}/archive/2.0.zip -> ${P}.zip"

LICENSE="MRI"
SLOT="1.1"
KEYWORDS="amd64"

IUSE=""

ruby_add_rdepend ">=dev-ruby/rubygems-2.2.0"
ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.8 >=dev-ruby/rake-10.0 )"

CDEPEND=""

DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}"

# fix up gemspec file not to call git
all_ruby_prepare() {
	sed -i -e '/files/d' ${PN}.gemspec || die
}



