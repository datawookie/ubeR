# SERVERID ------------------------------------------------------------------------------------------------------------

uber_set_serverid <- function(serverid) {
  if (nchar(serverid) != 40) stop("Server ID should be 40 characters long.")
  assign("serverid", serverid, envir = auth_cache)
}

uber_get_serverid <- function() {
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

# It might be worthwhile considering saving a default token as is done for rdrop2 package.

#' Authenticate with the Uber API
#'
#' This function wraps the process of OAuth2.0 authentication with the Uber API. This must be done before further interactions can take place.
#'
#' If \code{cache = TRUE} then the authentication token will be stored in a \code{.httr-oauth} file.
#'
#' @param client_key    The client key provided by Uber.
#' @param client_secret The client secreat provided by Uber.
#' @param cache         Whether or not to cache authentication token.
#' @seealso \code{\link[httr]{oauth_app}}.
#' @examples
#' \dontrun{
#' # The key/secret combination below is not valid.
#' uber_oauth("ReTZRlEGNnzkitsn-A23MiXbnMNzdQf8",
#'            "NpWYGY8W7cv63tfM2neciVpjZOAF_wx1GHRG94A2")
#' }
#' @import httr
#' @import httpuv
#' @export
uber_oauth <- function(client_key, client_secret, cache = TRUE) {
  endpoint <- httr::oauth_endpoint(
    authorize = "https://login.uber.com/oauth/v2/authorize",
    access    = "https://login.uber.com/oauth/v2/token"
  )

  # Sys.setenv("HTTR_SERVER_PORT" = "1410/")
  #
  scope = c("profile", "history", "places", "request")
  token <- httr::oauth2.0_token(endpoint,
                                httr::oauth_app("uber", key = client_key, secret = client_secret),
                                scope = scope, cache = cache)

  assign("oauth_token", token, envir = auth_cache)
}

has_oauth_token <- function() {
  exists("oauth_token", envir = auth_cache)
}

get_oauth_token <- function() {
  if (!has_oauth_token()) {
    stop("This session doesn't yet have OAuth2.0 authentication.")
  }

  return(get("oauth_token", envir = auth_cache))
}
