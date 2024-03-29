#* @head /healthz
#* @get /healthz
#* @serializer unboxedJSON
function() {
 ""
}

#* @get /backup
#* @serializer contentType list(type="application/zip")
function() {

  file <- tempfile(tmpdir = "/home/user", fileext = ".zip")

  utils::zip(file, "/srv/ipt")

  on.exit(unlink(file))

  readBin(file, "raw", n = file.info(file)[["size"]])

}
