# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be committed to cvs, the details on that line will be automatically
# generated to contain the correct data.

# The EAPI variable tells the ebuild format in use.
# Defaults to 0 if not specified. The current PMS draft contains details on
# a proposed EAPI=0 definition but is not finalized yet.
# Eclasses will test for this variable if they need to use EAPI > 0 features.
# Ebuilds should not define EAPI > 0 unless they absolutely need to use
# features added in that version.
#EAPI=0

# inherit lists eclasses to inherit functions from. Almost all ebuilds should
# inherit eutils, as a large amount of important functionality has been
# moved there. For example, the epatch call mentioned below wont work
# without the following line:
inherit eutils
# A well-used example of an eclass function that needs eutils is epatch. If
# your source needs patches applied, it's suggested to put your patch in the
# 'files' directory and use:
#
#   epatch "${FILESDIR}"/patch-name-here
#
# eclasses tend to list descriptions of how to use their functions properly.
# take a look at /usr/portage/eclasses/ for more examples.

# Short one-line description of this package.
DESCRIPTION="This is a sample skeleton ebuild file"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://foo.bar.com/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="ftp://foo.bar.com/${P}.tar.gz"

# License of the package.  This must match the name of file(s) in
# /usr/portage/licenses/.  For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE=""

# The SLOT variable is used to tell Portage if it's OK to keep multiple
# versions of the same package installed at the same time.  For example,
# if we have a libfoo-1.2.2 and libfoo-1.3.2 (which is not compatible
# with 1.2.2), it would be optimal to instruct Portage to not remove
# libfoo-1.2.2 if we decide to upgrade to libfoo-1.3.2.  To do this,
# we specify SLOT="1.2" in libfoo-1.2.2 and SLOT="1.3" in libfoo-1.3.2.
# emerge clean understands SLOTs, and will keep the most recent version
# of each SLOT and remove everything else.
# Note that normal applications should use SLOT="0" if possible, since
# there should only be exactly one version installed at a time.
# DO NOT USE SLOT=""! This tells Portage to disable SLOTs for this package.
SLOT="0"

# Using KEYWORDS, we can record masking information *inside* an ebuild
# instead of relying on an external package.mask file.  Right now, you should
# set the KEYWORDS variable for every ebuild so that it contains the names of
# all the architectures with which the ebuild works.  All of the official
# architectures can be found in the keywords.desc file which is in
# /usr/portage/profiles/.  Usually you should just set this to "~x86".  The ~
# in front of the architecture indicates that the package is new and should be
# considered unstable until testing proves its stability.  So, if you've
# confirmed that your ebuild works on x86 and ppc, you'd specify:
# KEYWORDS="~x86 ~ppc"
# Once packages go stable, the ~ prefix is removed.
# For binary packages, use -* and then list the archs the bin package
# exists for.  If the package was for an x86 binary package, then
# KEYWORDS would be set like this: KEYWORDS="-* x86"
# DO NOT USE KEYWORDS="*".  This is deprecated and only for backward
# compatibility reasons.
KEYWORDS="~x86"

# Comprehensive list of any and all USE flags leveraged in the ebuild,
# with the exception of any ARCH specific flags, i.e. "ppc", "sparc",
# "x86" and "alpha".  This is a required variable.  If the ebuild doesn't
# use any USE flags, set to "".
IUSE="gnome X"

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"

# Build-time dependencies, such as
#    ssl? ( >=dev-libs/openssl-0.9.6b )
#    >=dev-lang/perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
#DEPEND=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND="${DEPEND}"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
#S="${WORKDIR}/${P}"


# The following src_compile function is implemented as default by portage, so
# you only need to call it, if you need a different behaviour.
#src_compile() {
	# Most open-source packages use GNU autoconf for configuration.
	# The default, quickest (and preferred) way of running configure is:
	#econf
	#
	# You could use something similar to the following lines to
	# configure your package before compilation.  The "|| die" portion
	# at the end will stop the build process if the command fails.
	# You should use this at the end of critical commands in the build
	# process.  (Hint: Most commands are critical, that is, the build
	# process should abort if they aren't successful.)
	#./configure \
	#	--host=${CHOST} \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man || die "./configure failed"
	# Note the use of --infodir and --mandir, above. This is to make
	# this package FHS 2.2-compliant.  For more information, see
	#   http://www.pathname.com/fhs/

	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, because some makefiles have bugs
	# related to parallelism, in these cases, use emake -j1 to limit
	# make to a single process.  The -j1 is a visual clue to others
	# that the makefiles have bugs that have been worked around.

	#emake || die "emake failed"
#}

src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	emake DESTDIR="${D}" install || die "emake install failed"

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die "emake install failed"
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die "einstall failed"
}
