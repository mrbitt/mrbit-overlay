# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#app-shells/xiki-0.6.5.ebuild
EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

inherit ruby-fakegem

DESCRIPTION="Xiki does what shell consoles do, but lets you edit everything at
any time. It's trivial to make your own commands and menus to access other
tools. "
HOMEPAGE="http://xiki.org/"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
RUBY_FAKEGEM_GEMSPEC="xiki.gemspec"
RUBY_FAKEGEM_EXTRAINSTALL="etc README.markdown menu spec tests"
IUSE=""
SLOT="0"

ruby_add_rdepend "
    dev-ruby/ruby_parser
        dev-ruby/sourcify
        >=dev-ruby/trogdoro-el4r-1.0.7
        dev-ruby/file-tail
        dev-ruby/httparty
        dev-ruby/activesupport
        dev-ruby/method_source
        dev-ruby/net-ssh
        dev-ruby/net-scp
        dev-ruby/net-sftp
        >=dev-ruby/rspec-2.11.0
        >=dev-ruby/sexp_processor-3.2.0:0
        dev-ruby/daemons"


