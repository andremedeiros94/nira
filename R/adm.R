.onAttach <- function(lib, pkg) {
  niradm.v<- read.dcf(file = system.file("DESCRIPTION", package = pkg), fields = "Version")
  packageStartupMessage(paste(pkg, "version", niradm.v))
  packageStartupMessage("check the github repository at https://github.com/admedeiros/nira")
}
