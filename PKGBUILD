# Maintainer: André Laszlo <andre@laszlo.nu>
# Contributor: whacath <koaxialkabel@gmail.com>

# Follow the development of this package on GitHub:
# https://github.com/andrelaszlo/nexuspersonal-archlinux

pkgname=nexuspersonal
pkgver=4.19.0.11351
pkgrel=2
pkgdesc="BankID software for Linux"
url="http://www.bankid.com"
license=('custom')
arch=('i686')
source=('http://install.bankid.com/Repository/BISP-4.19.0.11351.tar.gz')
md5sums=('1074dd24b06366455129a769a34516b2')
depends=('libsm' 'gtk2' 'bash' 'zlib' 'libidn' 'libpng12')
install='nexuspersonal.install'

build() {
    cd $startdir/src/BISP-$pkgver

    PKG_DIR="../../pkg"
    INSTALL_DIR="$PKG_DIR/usr/local/lib"
    REAL_INSTALL_DIR="/usr/local/lib"

	mkdir -p $INSTALL_DIR/personal/{config,icons}
    mkdir -p $PKG_DIR/usr/local/bin
    mkdir -p $PKG_DIR/usr/lib/mozilla/plugins
    mkdir -p $PKG_DIR/usr/share/applications

	for l in da_DK fi_FI nn_NO sv_SE; do
		mkdir -p $INSTALL_DIR/personal/lang/$l
		cp ../lang/$l/personal.mo $INSTALL_DIR/personal/lang/$l/
		chmod 644 $INSTALL_DIR/personal/lang/$l/personal.mo
	done

    cp  libai.so\
        libP11.so\
        libplugins.so\
        libtokenapi.so\
        libCardSiemens.so\
        libCardSetec.so\
        libCardPrisma.so\
		libCardEdb.so\
		libCardGTOClsc.so\
        personal.bin\
        personal.sh\
        persadm\
        persadm.sh\
		BankID_Security_Application_Help_EN_US.htm\
		BankID_Security_Application_Help_da_DK.htm\
		BankID_Security_Application_Help_fi_FI.htm\
		BankID_Security_Application_Help_no_NO.htm\
		BankID_Security_Application_Help_SV_SE.htm\
		BankIDUbuntu_ReadMe_EN_US.txt\
		BankIDUbuntu_ReadMe_da_DK.txt\
		BankIDUbuntu_ReadMe_fi_FI.txt\
		BankIDUbuntu_ReadMe_no_NO.txt\
		BankIDUbuntu_ReadMe_SV_SE.txt\
        Release.txt\
        libBranding.so\
        $INSTALL_DIR/personal

    cp Personal.cfg $INSTALL_DIR/personal/config
    cp nexus_logo_32x32.png $INSTALL_DIR/personal/icons 
    cp personal.desktop $PKG_DIR/usr/share/applications

    ln -s $REAL_INSTALL_DIR/personal/libai.so $INSTALL_DIR/libai.so
    ln -s $REAL_INSTALL_DIR/personal/libtokenapi.so $INSTALL_DIR/libtokenapi.so
    ln -s $REAL_INSTALL_DIR/personal/personal.sh $PKG_DIR/usr/local/bin/personal
    ln -s $REAL_INSTALL_DIR/personal/persadm.sh $PKG_DIR/usr/local/bin/persadm
    ln -s $REAL_INSTALL_DIR/personal/libplugins.so $PKG_DIR/usr/lib/mozilla/plugins/libplugins.so

}
