getEndpoint <- function(cmd, version = 1) {
  paste("https://api.uber.com/v", version, '/', cmd, sep='')
}

buildArguments <- function(latitude = NULL, longitude = NULL) {
  sapply(names(formals()), function(arg) {
    get(arg)
  }, simplify = FALSE)
}

callAPI = function(cmd, params = NULL, method = "GET") {
  url = getEndpoint(cmd)

  if (method == "POST") {
    stop("POST not yet implemented.")
  } else {
    if (is.null(params)) {
      query = NULL
    } else {
      query = lapply(params, function(x) URLencode(as.character(x)))
    }
    return(GET(url, query = query))
  }
}
