#' ubeR: A package for interacting with the Uber API.
#'
#' The ubeR package provides wrapper functions for endpoints in the Uber API.
#'
#' @section Authentication: The \code{uber_oauth()} function accepts a client
#'   identifier and a client secret key. It orchestrates authentication with the
#'   Uber API.
#'
#' @section Products: The \code{uber_products()} function provides information
#'   about the nearest Uber rides to a specified location.
#'
#' @section Estimates: Estimates for the cost and duration of the cheapest ride
#'   between two locations can be requested using
#'   \code{uber_requests_estimate()}. Cost and duration estimates for a
#'   selection of rides types can be requested with \code{uber_estimate_price()}
#'   and \code{uber_estimate_time()}.
#'
#' @section Requests: A ride between two locations can be requested using
#'   \code{uber_requests()}. This ride can subsequently be queried and cancelled
#'   with \code{uber_requests_current()} and
#'   \code{uber_requests_current_delete()}.
#'
#' @docType package
#' @name ubeR
#' @aliases uber
NULL
