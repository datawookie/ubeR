# PRODUCTS ------------------------------------------------------------------------------------------------------------

#' https://developer.uber.com/docs/rides/api/v1-products
#' @export
uber_products <- function(latitude = NA, longitude = NA, product_id = NA) {
  if (any(is.na(c(latitude, longitude))) && is.na(product_id))
    stop("Either both latitude and longitude or product_id must be specified.")

  if (is.na(product_id)) {
    rides = callAPI("products", 1, params = parseParameters(environment()))$products
  } else {
    rides = callAPI(paste("products", product_id, sep = "/"), 1)
  }

  rides
}

# ESTIMATES -----------------------------------------------------------------------------------------------------------

#' https://developer.uber.com/docs/rides/api/v1-estimates-price
#' @export
uber_estimate_price <- function(start_latitude, start_longitude, end_latitude, end_longitude, seat_count = NULL) {
  estimates = callAPI("estimates/price", 1, method = "GET", params = parseParameters(environment()))
  #
  estimates$prices
}

#' https://developer.uber.com/docs/rides/api/v1-estimates-time
#' @export
uber_estimate_time <- function(start_latitude, start_longitude, product_id = NULL) {
  estimates = callAPI("estimates/time", 1, method = "GET", params = parseParameters(environment()))
  #
  estimates$times
}

# HISTORY -------------------------------------------------------------------------------------------------------------

#' https://developer.uber.com/docs/rides/api/v12-history
#'
#' Requires an OAuth 2.0 token with the history or history_lite scope.
#'
#' @export
uber_history <- function(limit = 5, offset = 0) {
  
  data <- callAPI("history", 1.2,  method = "GET", params = parseParameters(environment()))
  
  if(limit == 0) {
    stop("You must specify a positive number of trips to return history for.")
  } else if (length(data$history) == 0){
    stop("No history exists for this user.")
  }else{
    
    history.df <- data$history
    history.df.flat <- cbind(history.df %>% select(-start_city), history.df$start_city)
    history.df.final <- history.df.flat %>% mutate(request_time = as.POSIXct(request_time, origin = "1970-01-01"),start_time = as.POSIXct(start_time, origin = "1970-01-01"), end_time = as.POSIXct(end_time, origin = "1970-01-01"))
    
    list(history = history.df.final, limit = data$limit, offset = data$offset)
  }
}

# ME ------------------------------------------------------------------------------------------------------------------

#' https://developer.uber.com/docs/rides/api/v1-me
#'
#' Requires an OAuth 2.0 token with the profile scope.
#'
#' @export
uber_me <- function() {
  callAPI("me", 1)
}

# REQUESTS ------------------------------------------------------------------------------------------------------------

#' https://developer.uber.com/docs/rides/api/v1-requests
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @param start_latitude
#' @param start_longitude
#' @param end_latitude
#' @param end_longitude
#' @param start_address
#' @param end_address
#' @export
uber_requests <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL, start_address = NULL, end_address = NULL) {
  callAPI("requests", 1, method = "POST", params = parseParameters(environment()))
}

#' https://developer.uber.com/docs/rides/api/v1-requests-estimate
#'
#' Requires an OAuth 2.0 token with the request scope
#'
#' @export
uber_requests_estimate <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL) {
  response <- callAPI("requests/estimate", 1, method = "POST", params = parseParameters(environment()))
  #
  response$price <- with(response$price,
                         cbind(fare_breakdown, surge_multiplier, currency_code)
  )
  #
  response
}

#' https://developer.uber.com/docs/rides/api/v1-requests-current
#'
#' Requires an OAuth 2.0 token with the all_trips or request scope
#'
#' @export
uber_requests_current <- function() {
  callAPI("requests/current", 1)
}

#' https://developer.uber.com/docs/rides/api/v1-requests-current-delete
#'
#' Requires an OAuth 2.0 token with the request scope
#'
#' @export
uber_requests_current_delete <- function() {
  callAPI("requests/current", 1, method = "DELETE")
}

# PLACES --------------------------------------------------------------------------------------------------------------

#' It's possible that a home location will need to be set via the Uber application before this will work.
#'
#' https://developer.uber.com/docs/rides/api/v1-places-get
#'
#' Requires an OAuth 2.0 token with the places scope.
#'
#' @param place Either "home" or "work".
#' @export
uber_places_get <- function(place_id = c("home", "work")) {
  place_id = place_id[1]
  callAPI(paste("places", place_id, sep = "/"), 1, method = "GET", params = NULL)
}

#' https://developer.uber.com/docs/rides/api/v1-places-put
#'
#' Requires an OAuth 2.0 token with the places scope.
#'
#' @param place Either "home" or "work".
#' @export
uber_places_put <- function(place_id = c("home", "work"), address) {
  place_id = place_id[1]
  callAPI(paste("places", place_id, sep = "/"), 1, method = "PUT", params = list(address = address))
}

# PAYMENT -------------------------------------------------------------------------------------------------------------

#' https://developer.uber.com/docs/rides/api/v1-payment-methods
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @export
uber_payment_methods <- function() {
  callAPI("payment-methods", 1)
}
