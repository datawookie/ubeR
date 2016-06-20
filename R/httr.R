GET <- function(url, query = NULL) {
  httr::GET(url, query = query, add_headers(Authorization = paste("Token", get_serverid())))
}
