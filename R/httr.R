GET <- function(url, query = NULL) {
  httr::GET(url, query = query, httr::add_headers(Authorization = paste("Token", get_serverid())))
}
