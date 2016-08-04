#' https://developer.uber.com/docs/rides/api/v12-history
#'
#' Requires an OAuth 2.0 token with the history or history_lite scope.
#'
#' @export
uber_history <- function(limit = 5, offset = 0) {
  
  print(parseParameters(environment()))
  data <- callAPI("history", 1.2,  method = "GET", params = parseParameters(environment()))
  history.df <- data$history
  history.df <- as.data.frame(do.call(rbind, history))
  history.df <- as.data.frame(lapply(history.df, unlist))
  history.df[, 3:5] <- lapply(history.df[, 3:5], as.POSIXct, origin = "1970-01-01")
  
  final <- list(history = history.df, limit = data$limit, 
                offset = data$offset)
  return(final)
}
