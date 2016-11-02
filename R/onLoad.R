.onLoad <- function(libname, pkgname) {
  rjava::.jpackage(pkgname, lib.loc = libname)
}
