#' https://developer.uber.com/docs/rides/api/v1-me
#'
#' Requires an OAuth 2.0 token with the profile scope.
#'
#' @export
uber_me <- function() {
  callAPI("me", 1)
}
