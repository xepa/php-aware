PHP_ARG_ENABLE(aware, whether to enable error monitoring support,
[  --enable-aware     Enable experimental error monitoring support])

if test "$PHP_AWARE" != "no"; then

  AC_MSG_CHECKING([for libuuid])

  for i in $PHP_DCSESSION /usr /usr/local /opt /opt/local; do
  	if test -r "$i/include/uuid/uuid.h"; then
  		PHP_AWARE_LIBUUID=$i
  		break;
  	fi
  done

  if test -z $PHP_AWARE_LIBUUID; then
  	AC_MSG_ERROR([libuuid not found])	
  fi

  AC_MSG_RESULT([$PHP_AWARE_LIBUUID])

  PHP_ADD_INCLUDE("$PHP_DCS_LIBMEMCACHED_DIR/include")
  PHP_ADD_LIBRARY_WITH_PATH(uuid, "$PHP_AWARE_LIBUUID/lib", AWARE_SHARED_LIBADD)
  PHP_SUBST(AWARE_SHARED_LIBADD)

  PHP_NEW_EXTENSION(aware, aware.c storage.c, $ext_shared)
  PHP_INSTALL_HEADERS([ext/aware], [php_aware.h php_aware_storage.h])
  
fi