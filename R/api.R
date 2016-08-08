# PRODUCTS ------------------------------------------------------------------------------------------------------------

#' Products available
#'
#' Returns information about the Uber products offered at a given location.
#'
#' @param latitude   Latitude of location.
#' @param longitude  Longitude of location.
#' @param product_id Unique identifier representing a specific product.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-products}.
#' @examples
#' \dontrun{
#' uber_products(latitude = -33.925278, longitude = 18.423889)
#' uber_products(product_id = "91901472-f30d-4614-8ba7-9fcc937cebf5")
#' }
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

#' Price estimate
#'
#' Returns an estimated price range for each product offered at a given location
#'
#' @param start_latitude  Initial latitude.
#' @param start_longitude Initial longitude.
#' @param end_latitude    Final latitude.
#' @param end_longitude   Final longitude.
#' @param seat_count      Number of passengers.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-estimates-price}
#' @examples
#' \dontrun{
#' uber_estimate_price(start_latitude = 37.761492, start_longitude = -122.423941,
#'                     end_latitude = 37.775393, end_longitude = -122.417546)
#' }
#' @export
uber_estimate_price <- function(start_latitude, start_longitude, end_latitude, end_longitude, seat_count = NULL) {
  estimates = callAPI("estimates/price", 1, method = "GET", params = parseParameters(environment()))
  #
  estimates$prices
}

#' Time estimate
#'
#' Returns ETAs for all products currently available at a given location. The ETA for each product is expressed in seconds.
#'
#' @param start_latitude  Initial latitude.
#' @param start_longitude Initial longitude.
#' @param product_id      Unique identifier representing a specific product.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-estimates-time}
#' @examples
#' \dontrun{
#' uber_estimate_time(start_latitude = 37.761492, start_longitude = -122.423941)
#' }
#' @export
uber_estimate_time <- function(start_latitude, start_longitude, product_id = NULL) {
  estimates = callAPI("estimates/time", 1, method = "GET", params = parseParameters(environment()))
  #
  estimates$times
}

# HISTORY -------------------------------------------------------------------------------------------------------------

#' History
#'
#' Returns data about a user's activity on Uber.
#'
#' Requires an OAuth 2.0 token with the history or history_lite scope.
#'
#' @param limit  Number of items to retrieve.
#' @param offset Offset the returned results.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v12-history}
#' @examples
#' \dontrun{
#' uber_history()
#' }
#' @export
uber_history <- function(limit = 5, offset = 0) {
  if (limit <= 0) {
    stop("Value specified for limit must be positive.")
  }
  data <- callAPI("history", 1.2,  method = "GET", params = parseParameters(environment()))

  if (length(data$history) == 0){
    history.df.final = NULL
  } else {
    history.df <- data$history
    history.df.flat <- cbind(history.df %>% select(-start_city), history.df$start_city)
    history.df.final <- history.df.flat %>% mutate(request_time = as.POSIXct(request_time, origin = "1970-01-01"),
                                                   start_time = as.POSIXct(start_time, origin = "1970-01-01"),
                                                   end_time = as.POSIXct(end_time, origin = "1970-01-01"))
  }

  list(history = history.df.final, limit = data$limit, offset = data$offset)
}

# ME ------------------------------------------------------------------------------------------------------------------

#' User information
#'
#' Returns information about the Uber user.
#'
#' Requires an OAuth 2.0 token with the profile scope.
#'
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-me}
#' @examples
#' \dontrun{
#' uber_me()
#' }
#' @export
uber_me <- function() {
  callAPI("me", 1)
}

# REQUESTS ------------------------------------------------------------------------------------------------------------

#' Request a ride
#'
#' Request a ride on the behalf of the authenticated user.
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @param start_latitude  Initial latitude.
#' @param start_longitude Initial longitude.
#' @param end_latitude    Final latitude.
#' @param end_longitude   Final longitude.
#' @param start_address   Initial address.
#' @param end_address     Final address.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-requests}
#' @examples
#' \dontrun{
#' uber_requests(start_address = "37 Beach Road, Mouille Point, Cape Town",
#'               end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town")
#' }
#' @export
uber_requests <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL, start_address = NULL, end_address = NULL) {
  callAPI("requests", 1, method = "POST", params = parseParameters(environment()))
}

#' Request estimate
#'
#' Allows a ride to be estimated given the desired product, start, and end locations. If the end location is not provided, only the pickup ETA and details of surge pricing information are provided. If the pickup ETA is null, there are no cars available, but an estimate may still be given to the user.
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @param start_latitude  Initial latitude.
#' @param start_longitude Initial longitude.
#' @param end_latitude    Final latitude.
#' @param end_longitude   Final longitude.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-requests-estimate}
#' @examples
#' \dontrun{
#' uber_requests_estimate(start_latitude = 37.761492, start_longitude = -122.423941,
#'                        end_latitude = 37.775393, end_longitude = -122.417546)
#' }
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

#' Current request
#'
#' Retrieve details of the currently active request.
#'
#' Requires an OAuth 2.0 token with the all_trips or request scope.
#'
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-requests-current}
#' @examples
#' \dontrun{
#' uber_requests_current()
#' }
#' @export
uber_requests_current <- function() {
  callAPI("requests/current", 1)
}

#' Delete current request
#'
#' Delete the currently active request.
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-requests-current-delete}
#' @examples
#' \dontrun{
#' uber_requests_current_delete()
#' }
#' @export
uber_requests_current_delete <- function() {
  callAPI("requests/current", 1, method = "DELETE")
}

# PLACES --------------------------------------------------------------------------------------------------------------

# It's possible that a home location will need to be set via the Uber application before this will work.

#' Get place address
#'
#' Retrieve home and work addresses from an Uber user's profile.
#'
#' Requires an OAuth 2.0 token with the places scope.
#'
#' @param place_id Either "home" or "work".
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-places-get}
#' @examples
#' \dontrun{
#' uber_places_get()
#' uber_places_get("home")
#' uber_places_get("work")
#' }
#' @export
uber_places_get <- function(place_id = c("home", "work")) {
  place_id = place_id[1]
  callAPI(paste("places", place_id, sep = "/"), 1, method = "GET", params = NULL)
}

#' Set place address
#'
#' Update home and work addresses for an Uber user's profile.
#'
#' Requires an OAuth 2.0 token with the places scope.
#'
#' @param place_id Either "home" or "work".
#' @param address  Address to be assigned.
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-places-put}
#' @examples
#' \dontrun{
#' uber_places_put("home", "115 St Andrews Dr, Durban North, 4051, South Africa")
#' }
#' @export
uber_places_put <- function(place_id = c("home", "work"), address) {
  place_id = place_id[1]
  callAPI(paste("places", place_id, sep = "/"), 1, method = "PUT", params = list(address = address))
}

# PAYMENT -------------------------------------------------------------------------------------------------------------

#' Payment methods
#'
#' Retrieve a list of the user's available payment methods.
#'
#' Requires an OAuth 2.0 token with the request scope.
#'
#' @references
#' \url{https://developer.uber.com/docs/rides/api/v1-payment-methods}
#' @export
uber_payment_methods <- function() {
  callAPI("payment-methods", 1)
}
