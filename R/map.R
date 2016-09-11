#' Create a route map for a trip
#'
#' A map, centered at the mean of the start and end locations, is accessed via
#' \code{\link[ggmap]{get_map}} and a suitable driving route between these
#' points is constructed using \code{\link[googleway]{google_directions}} then
#' added to the map.
#'
#' @param start_latitude Initial latitude.
#' @param start_longitude Initial longitude.
#' @param end_latitude Final latitude.
#' @param end_longitude Final longitude.
#' @param start_address Initial address.
#' @param end_address Final address.
#' @param key Google Maps API key (optional).
#' @param zoom Map zoom, an integer from 3 (continent) to 21 (building).
#' @return A \code{ggplot2} graphics object.
#' @examples
#' \dontrun{
#' route_map(start_address = "37 Beach Road, Mouille Point, Cape Town",
#'           end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town")
#' }
#' @export
route_map <- function(start_latitude = NULL, start_longitude = NULL,
                      end_latitude = NULL, end_longitude = NULL,
                      start_address = NULL, end_address = NULL,
                      key = "", zoom = 14) {
  params = parseParameters(environment())

  directions <- googleway::google_directions(origin      = c(params$start_latitude, params$start_longitude),
                                             destination = c(params$end_latitude, params$end_longitude),
                                             key = key)
  df <- googleway::decode_pl(directions$routes$overview_polyline$points)

  mean_map <- ggmap::get_map(location = c(mean(df$lon), mean(df$lat)), zoom = zoom, maptype = "roadmap")
  ggmap::ggmap(mean_map) +
      ggplot2::geom_path(data = df, ggplot2::aes_string(x = "lon", y = "lat"), col = "steelblue", lwd = 2) +
      ggthemes::theme_map()
}
