#!/bin/sh
#
# Bootstrap the autoconf system.
#

if [ x$1 = x ]; then		# No parameters
  echo "Bootstrapping the autoconf system..."
  echo "  These autotools programs should be installed for this script to work:"
  echo "    aclocal, libtoolize, autoheader, automake, autoconf"
  echo "(Messages below about copying and installing files are normal.)"
elif [ x$1 = xclean ]; then 	# clean - take out the trash
  echo "Cleaning up the autoconf mess..."
  rm -rf autom4te.cache config BSDmakefile 
  exit 0;
else				# help text
  echo "usage: $0 [clean]"
  echo -n "  Use this script to bootstrap the autoconf build system prior to "
  echo "running the "
  echo "  ./configure script."
  exit 1;
fi

# try to keep everything nice and tidy in ./config
if ! [ -d "config" ]; then
  mkdir config
fi

# bootstrapping
echo "(1/4) Running aclocal..." && aclocal -I config \
  && echo "(2/4) Running autoheader..." && autoheader \
  && echo "(3/4) Running automake..." && automake --add-missing --copy --foreign \
  && echo "(4/4) Running autoconf..." && autoconf \
  && echo "" \
  && echo "You are now ready to run \"./configure\"."
