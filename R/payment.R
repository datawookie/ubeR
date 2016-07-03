#' https://developer.uber.com/docs/rides/api/v1-payment-methods
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @export
uber_payment_methods <- function() {
  callAPI("payment-methods", 1)
}
