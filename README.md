![](https://cdn.rawgit.com/DataWookie/ubeR/master/uber-logo.svg)

[![Build Status](https://travis-ci.org/DataWookie/ubeR.svg?branch=master)](https://travis-ci.org/DataWookie/ubeR)
[![GitHub version](https://badge.fury.io/gh/DataWookie%2FubeR.svg)](https://badge.fury.io/gh/DataWookie%2FubeR)
[![codecov.io](https://codecov.io/github/DataWookie/ubeR/coverage.svg?branch=master)](https://codecov.io/github/DataWookie/ubeR?branch=master)

# Installation

You should first install the development version of the `httr` package.
```
devtools::install_github("hadley/httr")
```
Then go ahead and install the ubeR package.
```
devtools::install_github("DataWookie/ubeR")
```

# Uber Application Setup

1. Go to https://developer.uber.com/dashboard/create.
2. Select Rides API and fill out the Name and Description details.
3. Press Create.
4. In Authorisations tab:
    - Set Redirect URL to http://localhost:1410/
    - Insert a Privary Policy URL.
    - Check the required scopes under General Scopes.
    - Press Save.

To create an authorisation token, go to https://developer.uber.com/dashboard/.

## Uber Endpoints

Details of the various endpoints offered by the Uber API can be found [here](https://developer.uber.com/docs/rides).

These endpoints have already been implemented:

    GET /v1/products
    GET /v1/products/{product_id}
    GET /v1/estimates/price
    GET /v1/estimates/time
    GET /v1.2/history
    GET /v1.1/history
    POST /v1/requests
    GET /v1/requests/current
    DELETE /v1/requests/current
    GET /v1/payment-methods
    GET /v1/places/{place_id}
    PUT /v1/places/{place_id}

The following endpoints still need to be managed:

    PATCH /v1/requests/current
    GET /v1/requests/{request_id}
    PATCH /v1/requests/{request_id}
    DELETE /v1/requests/{request_id}
    GET /v1/requests/{request_id}/map
    GET /v1/requests/{request_id}/receipt
    POST /v1/reminders
    GET /v1/reminders/{reminder_id}
    PATCH /v1/reminders/{reminder_id}
    DELETE /v1/reminders/{reminder_id


## Usage

Here's an example of taking the ubeR package through its paces. First load the package.

    library(ubeR)

Next get the ID and secret used for authenticating with Uber. Below these are retrieved from the environment.

    UBER_CLIENTID = Sys.getenv("UBER_CLIENTID")
    UBER_CLIENTSECRET = Sys.getenv("UBER_CLIENTSECRET")
    
Authenticate.

    uber_oauth(UBER_CLIENTID, UBER_CLIENTSECRET, FALSE)

Retrieve information on the user and his methods of payment.

    uber_me()
    uber_payment_methods()

Retrieve the predefined locations for the authenticated account.

    uber_places_get()
    uber_places_get("home")
    uber_places_get("work")

Retrieve history of recent rides as a `data.frame`.

    uber_history()

Find the cars in the vicinity of a specific location or focus on a particular car.

    uber_products(latitude = -33.925278, longitude = 18.423889)
    uber_products(product_id = "91901472-f30d-4614-8ba7-9fcc937cebf5")

General estimate for a trip between two locations.

    uber_requests_estimate(start_latitude = -33.899656, start_longitude = 18.407663,
                           end_latitude = -33.927443, end_longitude = 18.457557)

Price estimate for a trip specified by either latitude and longitude or address.

    uber_estimate_price(start_latitude = -33.899656, start_longitude = 18.407663,
                        end_latitude = -33.927443, end_longitude = 18.457557)
    uber_estimate_price(start_address = "37 Beach Road, Mouille Point, Cape Town",
                        end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town, 8001")

Time estimate for a trip specified by either latitude and longitude or address.

    uber_estimate_time(start_latitude = -33.899656, start_longitude = 18.407663)
    uber_estimate_time(start_address = "37 Beach Road, Mouille Point, Cape Town")

Request a ride. The package is currently wired to the sandbox server, so this will not result in a real ride. We'll shortly point the code at the real server.

    uber_requests(start_address = "37 Beach Road, Mouille Point, Cape Town",
                  end_address = "100 St Georges Mall, Cape Town City Centre, Cape Town, 8001")

Get information on current request and delete it.

    uber_requests_current()
    uber_requests_current_delete()
