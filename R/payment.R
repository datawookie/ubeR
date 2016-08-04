#' https://developer.uber.com/docs/rides/api/v1-payment-methods
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @export
uber_payment_methods <- function() {
  newlist <- callAPI("payment-methods", 1)
  payment <- newlist$payment_methods
  payment <- lapply(payment, nullToNA)
  df <- as.data.frame(do.call(rbind, payment))
  df <- as.data.frame(lapply(df, unlist))
  return(df)
}
