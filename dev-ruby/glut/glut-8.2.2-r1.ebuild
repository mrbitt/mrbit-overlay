# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22 ruby23"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc MIT-LICENSE"

inherit multilib ruby-fakegem 

DESCRIPTION="Glut bindings for ruby. Used with the opengl gem.
"
HOMEPAGE="https://github.com/archSeer/glut"
LICENSE="MIT"

SRC_URI="https://github.com/archSeer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

ruby_add_rdepend "dev-ruby/rake
                 >=dev-ruby/hoe-3.14
                 >=dev-ruby/mini_portile2-2.1 
                 >=dev-ruby/rake-compiler-0.9.1
                 >=dev-ruby/rake-compiler-dock-0.5.0 
                 >=dev-ruby/rdoc-4.0"

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

USE_RUBY="ruby20 ruby21 ruby22" ruby_add_bdepend "test? ( dev-util/cucumber )"

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

each_ruby_configure() {
	${RUBY} -Cext/glut extconf.rb || die
}

each_ruby_compile() {
	emake -C ext/glut V=1
    cp ext/*/*$(get_modname) lib/glut || die
}
