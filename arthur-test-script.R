source("R/cache.R")
source("R/authorise.R")
source("R/httr.R")
source("R/products.R")
source("R/estimates.R")
source("R/utils.R")
source("R/me.R")
source("R/payment.R")
source("R/requests.R")

library(dplyr)

#library(help = "httr")
#install.packages("httr")
library(httr)

#Andrew's
#  UBER_SERVERID = "q4AesUOxJ5rWru8jdTwnemjX2GeUcpCaGvzEqtjo"
#  UBER_CLIENTID = "ReTYRlEGNnzkhtsn-A78MiXbnGOzdQf8"
#  UBER_CLIENTSECRET = "MpWYGY8W7bv62tfM2neciUpjZOAF_wx0JHRG94A2"

#Arthur's
UBER_SERVERID = "EhhHWWdDt_KbpJQP7N66VpTDzqNBVbhDRoEB47iE"
UBER_CLIENTID = "vTILcoCGleTfliGQFGBWdnffB8li8kdD"
UBER_CLIENTSECRET = "bN175mXhuvabQoGp4JYJi16b9RvFKIvZXhontc0b"


#
# # set_serverid(Sys.getenv("UBER_SERVERID"))
# set_serverid(UBER_SERVERID)
# get_serverid()
#
# uber_me()
#
# r1 = products(latitude = -33.925278, longitude = 18.423889)
# r2 = products(product_id = "91901472-f30d-4614-8ba7-9fcc937cebf5")

# estimate_price(start_latitude = -33.8997839, start_longitude = 18.4067785,
#                end_latitude = -33.9272685, end_longitude = 18.455374,
#                seat_count = 2)

# estimate_time(start_latitude = -33.8997839, start_longitude = 18.4067785)

# REQUIRE OAUTH -------------------------------------------------------------------------------------------------------

uber_oauth(UBER_CLIENTID, UBER_CLIENTSECRET)

uber_me()
uber_history()
uber_places_get()

#constructor for reference
httr::content(GET("https://sandbox-api.uber.com/v1.2/history"))
httr::content(GET("https://sandbox-api.uber.com/v1/me"))
httr::content(GET("https://sandbox-api.uber.com/v1/places/home")) #reports missing places if it's not in scope

historylist <- httr::content(GET("https://sandbox-api.uber.com/v1.2/history"))
historylist$history[[1]]

#install.packages("purrr")
library("purrr")

starttimes <- unlist(map(historylist$history, "start_time")) %>% as.POSIXct(origin = "1970-01-01")
endtimes <- unlist(map(historylist$history, "end_time")) %>% as.POSIXct(origin = "1970-01-01")

plot(starttimes, col = "red")
points(endtimes, col = "blue")


lapply(historylist$history, end_time)


uber_places_get()
uber_payment_methods()

uber_requests_estimate(start_latitude = 37.761492, start_longitude = -122.423941,
                       end_latitude = 37.775393, end_longitude = -122.417546)

uber_requests(start_address = "37 Beach Road, Mouille Point, Cape Town",
              end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town, 8001")

uber_requests_current()
uber_requests_current_delete()
uber_requests_current()
