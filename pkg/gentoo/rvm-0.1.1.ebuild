# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="RVM facilitates easy installation and management of multiple Ruby environments and sets of gems"
HOMEPAGE="http://rvm.beginrescueend.com/"

# This should be the first 7 characters of the tagged version's commit.
VERSION_SHORT_SHA1="9bcfd07"

SRC_URI="http://github.com/wayneeseguin/rvm/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/wayneeseguin-rvm-${VERSION_SHORT_SHA1}"
RVM_DIR="/opt/rvm"

src_install() {
	export rvm_path="${D}${RVM_DIR}"
	export rvm_symlink_path="${D}/usr/bin"
	./install || die "Installation failed."

	echo "rvm_path=${RVM_DIR}" > "${T}"/rvmrc
	insinto /etc
	doins "${T}"/rvmrc || die "Failed to install /etc/rvmrc."
	elog "A default /etc/rvmrc has been installed.  Feel free to modify it."
	elog

	echo 'unset RUBY_VERSION' > "${T}"/system
	echo 'unset GEM_HOME' >> "${T}"/system
	echo 'unset GEM_PATH' >> "${T}"/system
	echo 'unset MY_RUBY_HOME' >> "${T}"/system
	insinto ${RVM_DIR}/config
	doins "${T}"/system || die "Failed to install ${RVM_DIR}/config/system."
	elog "You may also wish to review ${RVM_DIR}/config/system ."
	elog

	elog "To use rvm as the root user, add the following line at the end of root's shell's"
	elog "loading files (.bashrc and then .bash_profile for bash; or .zshrc for zsh), after"
	elog "all path/variable settings:"
	elog
	elog "     if [[ -s $RVM_DIR/scripts/rvm ]] ; then source $RVM_DIR/scripts/rvm ; fi"

}
