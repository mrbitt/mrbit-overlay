#
# spec file for package SelekTOR
#
# Copyright (c) 2015 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#

Name:           SelekTOR
Summary:        Java based GUI frontend for Tor
Version:        3.13.56
Release:        1.1
Url:            http://www.dazzleships.net/selektor-for-linux/
Source0:        selektor-%{version}.tar.gz
Patch0:         selektor-startscript.patch
Patch1:         selektor-desktopfiles.patch
License:        GPL-2.0
Group:          Productivity/Networking/Security
Requires:       java >= 1.7
Requires:       tor
BuildRequires:  java-devel >= 1.7
BuildRequires:  proguard
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      x86_64

%description
SelekTOR for Linux is an open source Java based GUI frontend for Tor
running in client mode, it acts as a Tor launcher and exit node chooser
for browsers that support system proxying using PAC files, it is licensed
under the GPL2.

%prep

%setup -q -n selektor-%{version}
%patch0
%patch1
sed -i -e 's|/usr/lib/jvm/default-java|%{_libdir}/jvm/java|g' SelekTOR.pro
sed -i '18i -ignorewarnings' SelekTOR.pro

%build
./build-jar

%install
install -D -m644 SelekTOR.jar  %{buildroot}%{_javadir}/SelekTOR/SelekTOR.jar
pushd packaging
install -D -m755 selektor  %{buildroot}%{_bindir}/selektor
popd
pushd packaging/applications
install -D -m644 selektor-autostart.desktop  %{buildroot}%{_datadir}/applications/selektor-autostart.desktop
install -D -m644 selektor-proxy-reset.desktop  %{buildroot}%{_datadir}/applications/selektor-proxy-reset.desktop
install -D -m644 selektor.desktop  %{buildroot}%{_datadir}/applications/selektor.desktop
popd
pushd packaging/icons
install -D -m644 selektor-app.png  %{buildroot}%{_datadir}/pixmaps/selektor-app.png
install -D -m644 selektor-tray.png  %{buildroot}%{_datadir}/pixmaps/selektor-tray.png
popd
pushd packaging/doc
install -D -m644 changelog  %{buildroot}%{_docdir}/SelekTOR/changelog
install -D -m644 copyright  %{buildroot}%{_docdir}/SelekTOR/copyright
install -D -m644 help-en.html  %{buildroot}%{_docdir}/SelekTOR/help-en.html
install -D -m644 help-fr.html  %{buildroot}%{_docdir}/SelekTOR/help-fr.html
install -D -m644 help-pt-br.html  %{buildroot}%{_docdir}/SelekTOR/help-pt-br.html
popd
pushd packaging/man/man1
install -D -m644 selektor.1.gz %{buildroot}%{_mandir}/man1/selektor.1.gz
popd

%files
%defattr(-,root,root)
%{_bindir}/selektor
%{_datadir}/applications/selektor-autostart.desktop
%{_datadir}/applications/selektor-proxy-reset.desktop
%{_datadir}/applications/selektor.desktop
%{_datadir}/pixmaps/selektor-app.png
%{_datadir}/pixmaps/selektor-tray.png
%dir %{_javadir}/SelekTOR
%{_javadir}/SelekTOR/SelekTOR.jar
%dir %{_docdir}/SelekTOR
%{_docdir}/SelekTOR/changelog
%{_docdir}/SelekTOR/copyright
%{_docdir}/SelekTOR/help-en.html
%{_docdir}/SelekTOR/help-fr.html
%{_docdir}/SelekTOR/help-pt-br.html
%{_mandir}/man1/selektor.1.gz

%changelog
* Tue Dec 15 2015 joerg.lorenzen@ki.tng.de
- Initial package, version 3.13.53
