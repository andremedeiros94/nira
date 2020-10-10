library(devtools) 
library(roxygen2)
load_all()
document()
check_man()
document()
check()
build()

