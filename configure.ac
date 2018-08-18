#
#
# author:  Shaun Voigt 
#
#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

#
# this defines the version number, must be static for AC_INIT
#
AC_INIT(ca, 1.0, smvoigt@users.noreply.github.com)

#
# autoconf and automake initialization
#
AC_CONFIG_AUX_DIR(config)
AC_CONFIG_MACRO_DIR(config)
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE()

# AC_PREFIX_DEFAULT is /usr/local, but not expanded yet
if test "x$prefix" = "xNONE" ; then
  prefix="/usr/local"
fi

if test "$sysconfdir" = "\${prefix}/etc" ; then
  sysconfdir="${prefix}/etc"
fi

DEFAULT_CERT_COUNTRY="AU"
DEFAULT_CERT_STATE="State"
DEFAULT_CERT_LOCALITY="Locality"
DEFAULT_CERT_ORG="Org"
DEFAULT_CERT_ORG_UNIT="Org Unit"

AC_ARG_WITH([cert_country],
	    [AS_HELP_STRING([--cert_country=country],
			    [specify default cert country ])],
	    [CERT_COUNTRY="$with_cert_country"], 
	    [CERT_COUNTRY="$DEFAULT_CERT_COUNTRY"])

AC_ARG_WITH([cert_state],
	    [AS_HELP_STRING([--cert_state=state],
			    [specify default cert state ])],
	    [CERT_STATE="$with_cert_state"], 
	    [CERT_STATE="$DEFAULT_CERT_STATE"])

AC_ARG_WITH([cert_locality],
	    [AS_HELP_STRING([--cert_locality=locality],
			    [specify default cert locality ])],
	    [CERT_LOCALITY="$with_cert_locality"], 
	    [CERT_LOCALITY="$DEFAULT_CERT_LOCALITY"])

AC_ARG_WITH([cert_org],
	    [AS_HELP_STRING([--cert_org=org],
			    [specify default cert org ])],
	    [CERT_ORG="$with_cert_org"], 
	    [CERT_ORG="$DEFAULT_CERT_ORG"])  

AC_ARG_WITH([cert_org_unit],
	    [AS_HELP_STRING([--cert_org_unit=org_unit],
			    [specify default cert org_unit ])],
	    [CERT_ORG_UNIT="$with_cert_org_unit"], 
	    [CERT_ORG_UNIT="$DEFAULT_CERT_ORG_UNIT"])      

AC_SUBST(CERT_COUNTRY)
AC_SUBST(CERT_STATE)
AC_SUBST(CERT_LOCALITY)
AC_SUBST(CERT_ORG)
AC_SUBST(CERT_ORG_UNIT)

AC_ARG_WITH([carootdir],
	    [AS_HELP_STRING([--with-carootdir=dir],
			    [specify ca root directory])],
	    [carootdir="$with_carootdir"], 
	    [carootdir="${sysconfdir}/ca"])
AC_SUBST(carootdir)

CERT_ROOT_DIR=${prefix}/etc/ca
AC_SUBST(CERT_ROOT_DIR)

# Checks for programs.
AC_PROG_INSTALL
AC_CHECK_PROG(openssl_path, openssl, yes, no,)
if test "x$openssl_path" = "xno" ; then
    AC_MSG_ERROR([Could not locate openssl.])
fi

# Output files
AC_CONFIG_FILES([Makefile
        create_new_server_cert.sh
		root/openssl.cnf
		intermediate/openssl.cnf
		],)
AC_OUTPUT

# Summary text
echo \
"------------------------------------------------------------------------
${PACKAGE_STRING} Configuration:

  openssl:                    ${openssl_path}
  Install prefix:             ${prefix}
  Cert root prefix:           ${carootdir}
  Default Cert Country:       ${CERT_COUNTRY}
  Default Cert State:         ${CERT_STATE}
  Default Cert Locality:      ${CERT_LOCALITY}
  Default Cert Org:           ${CERT_ORG}
  Default Cert Org Unit:      ${CERT_ORG_UNIT}
"
