#' https://developer.uber.com/docs/rides/api/v12-history
#'
#' Requires an OAuth 2.0 token with the history or history_lite scope.
#'
#' @export
uber_history <- function() {
  callAPI("history", 1.2)
}
