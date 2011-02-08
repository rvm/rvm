# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

# This should be the first 7 characters of the tagged version's commit.
VERSION_SHORT_SHA1="ac526a6"

SRC_URI="http://github.com/wayneeseguin/rvm/tarball/${PV} -> ${P}.tar.gz"
S="${WORKDIR}/wayneeseguin-rvm-${VERSION_SHORT_SHA1}"

DESCRIPTION="RVM facilitates easy installation and management of multiple Ruby environments and sets of gems"
HOMEPAGE="http://rvm.beginrescueend.com/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="mono java"

RDEPEND="net-misc/curl
	sys-devel/patch
	java? (
		dev-java/sun-jdk
		dev-java/sun-jre-bin
	)
	mono? ( dev-lang/mono )"

RVM_DIR="/opt/rvm"

src_install() {
	for v in `env | egrep '^rvm_' | cut -d '=' -f 1`; do
		unset $v
	done

	# Set variables for installation (only!)
	export rvm_prefix="${D}"
	export rvm_path="${D}${RVM_DIR}"
	export rvm_selfcontained=1

	./install || die "Installation failed."

	# Set variables for actual operation in a default rvmrc
	echo "rvm_selfcontained=1" > "${T}"/rvmrc
	echo "rvm_prefix=\"$(dirname $RVM_DIR)/\"" >> "${T}"/rvmrc
	echo "rvm_path=\"${RVM_DIR}\"" >> "${T}"/rvmrc

	insinto /etc
	doins "${T}"/rvmrc || die "Failed to install /etc/rvmrc."
	elog "A default /etc/rvmrc has been installed.  Feel free to modify it."
	elog

	elog "Before any user (including root) can use rvm, the following line must be appended"
	elog "to the end of the user's shell's loading files (.bashrc and then .bash_profile"
	elog "for bash; or .zshrc for zsh), after all path/variable settings:"
	elog
	elog "     [[ -s $RVM_DIR/scripts/rvm ]] && source $RVM_DIR/scripts/rvm"
}
