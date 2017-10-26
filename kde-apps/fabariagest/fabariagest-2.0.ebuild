#Copyright (C) 2006-2017 Angelo e Calogero Scarnà
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=4

RESTRICT="mirror"


DESCRIPTION="Gestionale per aziende.
Un software gestionale che ti aiuta ad organizzare le attività commerciali della tua azienda. 
FabariaGest permette di gestire in modo semplice e intuitivo fatture, prezzi, schede prodotto, clienti e molto altro.
Dopo una semplice installazione, il programma è già pronto per l'utilizzo e non ha bisogno di altre operazioni. 
Grazie alla struttura del database, la ricerca degli elementi negli archivi è facile ed estremamente veloce. 
Puoi esportare tutti i documenti (clienti, fornitori, articoli, preventivi, ordini, inventari, elenchi vari..) nei principali formati d'uso (.doc, .xls, .pdf)."

HOMEPAGE="http://www.codelinsoft.it"
SRC_URI="http://www.codelinsoft.it/package/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql"

DEPEND=" 
		 dev-qt/qtwidgets
		 dev-qt/qtcore
		 dev-qt/qtgui
		 dev-qt/qtsql
		 dev-qt/qtxml
		 dev-qt/qtsvg
		 dev-qt/qtnetwork
		 dev-qt/qtmultimedia
		 dev-qt/qtwebkit 
		 dev-db/mariadb
		 dev-util/cmake
		  "
RDEPEND="${DEPEND}"

src_unpack() {
    unpack ${A}
}

src_prepare() {
	cmake -DCMAKE_INSTALL_PREFIX=/opt/fabaria_gest
}

src_compile(){
	make -j5
}

src_install(){
    dodir /usr/bin
    dodir /opt/fabaria_gest
	dodir /opt/fabaria_gest/plugin
	dodir /opt/fabaria_gest/lib
	dodir /opt/fabaria_gest/installdb
	dodir /opt/fabaria_gest/updatedb
	dodir /usr/share/applications
	cd ${WORKDIR}
	cp -r "${P}/fabaria/fabaria_gest" "${D}opt/fabaria_gest" || die
	cp -r "${P}/update/update" "${D}opt/fabaria_gest" || die
	cp -r "${P}/utility/backup_restore" "${D}opt/fabaria_gest" || die
	insinto /opt/fabaria_gest
	newins "${P}/fabaria/images/logo4.png" logo4.png
	insinto /opt/fabaria_gest/lib
	newins "${P}/analogclock/libanaclogclock_fabaria.so" libanaclogclock_fabaria.so
	newins "${P}/initdb/libinitdb_fabaria.so" libinitdb_fabaria.so
	newins "${P}/log_man/liblog_man_fabaria.so" liblog_man_fabaria.so
	newins "${P}/smtp/libsmtp_fabaria.so" libsmtp_fabaria.so
	newins "${P}/qwt/libqwt_fabaria.so" libqwt_fabaria.so
	newins "${P}/xlsx/libxlsx_fabaria.so" libxlsx_fabaria.so
	newins "${P}/qtdropbox/libqtdropbox_fabaria.so" libqtdropbox_fabaria.so
	newins "${P}/quazip/libquazip_fabaria.so" libquazip_fabaria.so
	insinto /opt/fabaria_gest/plugin
	newins "${P}/backup_restore_db/libbackup_restore_db.so" libbackup_restore_db.so
	newins "${P}/check_database/libcheck_database.so" libcheck_database.so
	newins "${P}/inventario/libinventario.so" libinventario.so
	insinto /usr/share/applications
	newins "${P}/fabaria/desktop/fabaria.desktop" fabaria.desktop
	insinto /opt/fabaria_gest/installdb
	newins "${P}/fabaria/installdb/install_db.sql" install_db.sql
	insinto /opt/fabaria_gest/updatedb
	newins "${P}/fabaria/updatedb/update_db.sql" update_db.sql
	insinto /usr/bin
	newins "${P}/fabaria/fabaria" fabaria
}

pkg_postinst() {
    chmod 777 /usr/bin/fabaria
}
