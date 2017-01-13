# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22 ruby23"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="History.md README.md LICENSE.txt"

inherit ruby-fakegem eutils

DESCRIPTION="Easy to use and reliable cross compiler environment for building Windows and Linux binary gems"
HOMEPAGE="https://github.com/rake-compiler/rake-compiler-dock"
LICENSE="MIT"

SRC_URI="https://github.com/rake-compiler/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

ruby_add_rdepend "dev-ruby/rake
                 >=dev-ruby/bundler-1.3
                 >=dev-ruby/test-unit-3.0 "

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

USE_RUBY="ruby20 ruby21 ruby22" ruby_add_bdepend "test? ( dev-util/cucumber )"

all_ruby_prepare() {
	# Make sure the right rspec version is used in cucumber.
	sed -i -e '/files/d' ${PN}.gemspec || die
}

each_ruby_test() {
	# Skip cucumber for ruby23 (not ready yet)
	case ${RUBY} in
		*ruby20|*ruby21|*ruby22)
			ruby-ng_rspec
			ruby-ng_cucumber
			;;
		*)
			ruby-ng_rspec
			;;
	esac
}
