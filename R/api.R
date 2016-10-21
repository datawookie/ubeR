# PRODUCTS ------------------------------------------------------------------------------------------------------------

#' Products available
#'
#' Returns information about the Uber products offered at a given location.
#'
#' @param latitude   Latitude of location.
#' @param longitude  Longitude of location.
#' @param product_id Unique identifier representing a specific product.
#' @references
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-products-get}
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-products-product_id-get}
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
#' @param start_address   Initial address.
#' @param end_address     Final address.
#' @param seat_count      Number of passengers.
#' @references
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-estimates-price-get}
#' @examples
#' \dontrun{
#' uber_estimate_price(start_latitude = 37.761492, start_longitude = -122.423941,
#'                     end_latitude = 37.775393, end_longitude = -122.417546)
#' }
#' @export
uber_estimate_price <- function(start_latitude = NULL, start_longitude = NULL, end_latitude = NULL, end_longitude = NULL,
                                start_address = NULL, end_address = NULL, seat_count = NULL) {
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
#' @param start_address   Initial address.
#' @param product_id      Unique identifier representing a specific product.
#' @references
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-estimates-time-get}
#' @examples
#' \dontrun{
#' uber_estimate_time(start_latitude = 37.761492, start_longitude = -122.423941)
#' }
#' @export
uber_estimate_time <- function(start_latitude = NULL, start_longitude = NULL, start_address = NULL, product_id = NULL) {
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v12-history-get}
#' @examples
#' \dontrun{
#' uber_history()
#' }
#' @import dplyr
#' @importFrom stats setNames
#' @export
uber_history <- function(limit = 5, offset = 0) {
  if(limit <= 0) {
    stop("You must specify a positive value for limit.")
  } else {
    data <- callAPI("history", 1.2,  method = "GET", params = parseParameters(environment()))
  }

  if (length(data$history) == 0){
    history.df = NULL
  } else {
    times <- c("request_time", "start_time", "end_time")
    history.df <- select_(data$history, .dots = c("-start_city")) %>%
      cbind(data$history$start_city) %>%
      mutate_(.dots = setNames(paste0('as.POSIXct(',times,', origin = "1970-01-01")'), times))
  }
  history.df
}

# ME ------------------------------------------------------------------------------------------------------------------

#' User information
#'
#' Returns information about the Uber user.
#'
#' Requires an OAuth 2.0 token with the profile scope.
#'
#' @references
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-me-get}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-requests-post}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-requests-estimate-post}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-requests-current-get}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-requests-current-delete}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-places-place_id-get}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-places-place_id-put}
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
#' \url{https://developer.uber.com/docs/ride-requests/references/api/v1-payment-methods-get}
#' @export
uber_payment_methods <- function() {
  callAPI("payment-methods", 1)
}
