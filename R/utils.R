check.latitude <- function(latitude) {
  latitude = as.numeric(latitude)
  if (!is.na(latitude) && (latitude > 90 || latitude < -90)) {
    stop('Latitude must be in range [90.0,-90.0].')
  } else return(latitude)
}

check.longitude <- function(longitude) {
  longitude = as.numeric(longitude)
  if (!is.na(longitude) && (longitude > 180 || longitude < -180)) {
    stop('Longitude must be in range [180,-180].')
  } else return(longitude)
}

getEndpoint <- function(cmd, version = 1) {
  paste("https://api.uber.com/v", version, '/', cmd, sep='')
}
