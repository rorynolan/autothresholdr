# This is needed to make the package work, having the required java classes contained in the jar file in inst/java.
.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, lib.loc = libname)
}
