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
#' @param end_longitude Final longitude
#' @param start_address Initial address.
#' @param end_address Final address.
#' @param key Google Maps API key (optional)
#'   
#' @author Jonathan Carroll, \email{rpkg@@jcarroll.com.au}
#' @return a \code{ggplot2} graphics object (the map with route)
#' @examples
#' \dontrun{
#' SFmap <- route_map(start_latitude = 37.761492, start_longitude = -122.423941, 
#'                    end_latitude = 37.788282, end_longitude = -122.406713)
#' AUmap <- route_map(start_address = "Sydney, Australia", 
#'                    end_address = "Melbourne, Australia", 
#'                    zoom = 7)
#' }
#' @export
route_map <- function(start_latitude = NULL, start_longitude = NULL, 
                      end_latitude = NULL, end_longitude = NULL,
                      start_address = NULL, end_address = NULL, 
                      key = "", zoom = 14) {
    
  params = parseParameters(environment())

  origin      <- c(params$start_latitude, params$start_longitude)
  destination <- c(params$end_latitude, params$end_longitude)
  
  gd <- google_directions(origin = origin, destination = destination, key = key)
  pl <- gd$routes$overview_polyline$points
  df <- googleway::decode_pl(pl)

  mean_map <- ggmap::get_map(location = c(mean(df$lon), mean(df$lat)), zoom = zoom, maptype = "roadmap") 
  ggmap::ggmap(mean_map) + 
      ggplot2::geom_path(data = df, aes(x = lon, y = lat), col = "steelblue", lwd = 2) + 
      ggthemes::theme_map()
  
}