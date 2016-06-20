# SERVERID ------------------------------------------------------------------------------------------------------------

set_serverid <- function(serverid) {
  assign("serverid", serverid, envir = auth_cache)
}

get_serverid <- function() {
  serverid = tryCatch(
    get("serverid", envir = auth_cache),
    error = function(e) {
      stop("No server ID has been set. Please call set_serverid().")
      return(NA)
    }
  )
  return(serverid)
}
