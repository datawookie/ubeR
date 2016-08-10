source("R/cache.R")
source("R/authorise.R")
source("R/httr.R")
source("R/utils.R")
source("R/api.R")

library(dplyr)

# You'll need to set up these environment variables first.
#
UBER_SERVERID = Sys.getenv("UBER_SERVERID")
UBER_CLIENTID = Sys.getenv("UBER_CLIENTID")
UBER_CLIENTSECRET = Sys.getenv("UBER_CLIENTSECRET")

# uber_set_serverid(UBER_SERVERID)
# uber_get_serverid()

# REQUIRE OAUTH -------------------------------------------------------------------------------------------------------

uber_oauth(UBER_CLIENTID, UBER_CLIENTSECRET, TRUE)

uber_me()

uber_history()

uber_products(latitude = -33.925278, longitude = 18.423889)
uber_products(product_id = "91901472-f30d-4614-8ba7-9fcc937cebf5")

uber_places_get()
uber_places_get("home")
uber_places_get("work")
#
# uber_places_put("home", "685 Market St, San Francisco, CA 94103, USA")
# uber_places_get()
# uber_places_put("home", "115 St Andrews Dr, Durban North, 4051, South Africa")
# uber_places_get()

uber_payment_methods()

uber_requests_estimate(start_latitude = 37.761492, start_longitude = -122.423941,
                       end_latitude = 37.775393, end_longitude = -122.417546)

uber_requests(start_address = "37 Beach Road, Mouille Point, Cape Town",
              end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town, 8001")

uber_requests_current()
uber_requests_current_delete()
uber_requests_current()

uber_estimate_price(start_latitude = 37.761492, start_longitude = -122.423941,
               end_latitude = 37.775393, end_longitude = -122.417546)

uber_estimate_time(start_latitude = 37.761492, start_longitude = -122.423941)
