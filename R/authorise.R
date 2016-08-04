# SERVERID ------------------------------------------------------------------------------------------------------------

set_serverid <- function(serverid) {
  if (nchar(serverid) != 40) stop("Server ID should be 40 characters long.")
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

# OAUTH2 --------------------------------------------------------------------------------------------------------------

#' It might be worthwhile considering saving a default token as is done for rdrop2 package.
#'
#' @export
uber_oauth = function(client_key, client_secret) {
  endpoint <- httr::oauth_endpoint(
    authorize = "https://login.uber.com/oauth/v2/authorize",
    access    = "https://login.uber.com/oauth/v2/token"
  )
  app <- httr::oauth_app("uber", key = client_key, secret = client_secret)

  # Sys.setenv("HTTR_SERVER_PORT" = "1410/")
  #
  # scope = c("profile", "request", "history_lite", "places", "history", "ride_widgets")
  scope = c("profile", "history_lite", "places", "request")
  token <- httr::oauth2.0_token(endpoint, app, scope = scope, cache = FALSE)

  assign("oauth_token", token, envir = auth_cache)
}

has_oauth_token <- function() {
  exists("oauth_token", envir = auth_cache)
}

#' @export
get_oauth_token <- function() {
  if (!has_oauth_token()) {
    stop("This session doesn't yet have OAuth2.0 authentication.")
  }

  return(get("oauth_token", envir = auth_cache))
}
