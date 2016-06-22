getEndpoint <- function(cmd, version = 1) {
  paste("https://api.uber.com/v", version, '/', cmd, sep='')
}

buildArguments <- function(latitude = NULL, longitude = NULL, start_latitude = NULL, start_longitude = NULL,
                           end_latitude = NULL, end_longitude = NULL, seat_count = NULL) {
  sapply(names(formals()), function(arg) {
    get(arg)
  }, simplify = FALSE)
}

callAPI = function(cmd, params = NULL, method = "GET") {
  url = getEndpoint(cmd)

  params = params[!sapply(params, is.null)]

  if (method == "POST") {
    stop("POST not yet implemented.")
  } else {
    if (is.null(params)) {
      query = NULL
    } else {
      query = lapply(params, function(x) URLencode(as.character(x)))
    }
    return(content(GET(url, query = query)))
  }
}
