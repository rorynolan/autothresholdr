

## Test environments

* local OS X install, R 3.5.1
* ubuntu 14.04 (on travis-ci), R 3.5.1
* Windows Server 2012 (on appveyor), R 3.5.1
* win-builder (devel and release)


## R CMD check results

* 0 ERRORs | 0 WARNINGs | 0 NOTEs


## Reverse Dependencies

* There are 2 reverse dependencies: `detrendr` and `nandb`. `nandb` is already broken, but this update to `autothresholdr` does not make it any worse. A fix to `nandb` for its problem will arrive in the next week.
