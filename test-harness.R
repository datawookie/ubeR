library(dplyr)
library(ubeR)

# UBER_SERVERID = "q4AesUOxJ5rWru8jdTwnemjX2GeUcpCaGvzEqtjo"
# UBER_CLIENTID = "ReTYRlEGNnzkhtsn-A78MiXbnGOzdQf8"
# UBER_CLIENTSECRET = "MpWYGY8W7bv62tfM2neciUpjZOAF_wx0JHRG94A2"

UBER_SERVERID = "RSkdFVabimhe0z90MQuXMcbzurlDUH7IA8n6rNT6"
UBER_CLIENTID = "OjHS0DlHE8HnureO9XYsVQFgvIfWI7UX"
UBER_CLIENTSECRET = "OlD1E07ig34-qiBDWYQGsx_5QA4uoCrXiUxHx5IN"

# set_serverid(Sys.getenv("UBER_SERVERID"))
set_serverid(UBER_SERVERID)
get_serverid()

# r1 = products(latitude = -33.925278, longitude = 18.423889)
# r2 = products(product_id = "91901472-f30d-4614-8ba7-9fcc937cebf5")

# estimate_price(start_latitude = -33.8997839, start_longitude = 18.4067785,
#                end_latitude = -33.9272685, end_longitude = 18.455374,
#                seat_count = 2)

# estimate_time(start_latitude = -33.8997839, start_longitude = 18.4067785)

# REQUIRE OAUTH -------------------------------------------------------------------------------------------------------

uber_oauth(UBER_CLIENTID, UBER_CLIENTSECRET)

uber_places_put("home", "685 Market St, San Francisco, CA 94103, USA")
uber_places_get()
uber_places_put("home", "115 St Andrews Dr, Durban North, 4051, South Africa")
uber_places_get()

uber_me()

uber_history()

uber_payment_methods()

uber_requests_estimate(start_latitude = 37.761492, start_longitude = -122.423941,
                       end_latitude = 37.775393, end_longitude = -122.417546)

uber_requests(start_address = "37 Beach Road, Mouille Point, Cape Town",
              end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town, 8001")

uber_requests_current()
uber_requests_current_delete()
uber_requests_current()
