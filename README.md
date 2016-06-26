# Installation

You should install the development version of the `httr` package.
```
devtools::install_github("hadley/httr")
```

# Uber Application Setup

1. 
2. 
3. 
4. 
5. Set Redirect URL to http://localhost:1410/

## Uber Endpoints

Details of the various endpoints offered by the Uber API can be found [here](https://developer.uber.com/docs/rides).

These endpoints have already been implemented:

GET /v1/products
GET /v1/products/{product_id}
GET /v1/estimates/price
GET /v1/estimates/time

The following endpoints still need to be managed:

GET /v1.2/history
GET /v1.1/history
GET /v1/me                             [requires OAuth 2.0]
POST /v1/requests
GET /v1/requests/current
PATCH /v1/requests/current
DELETE /v1/requests/current
POST /v1/requests/estimate
GET /v1/requests/{request_id}
PATCH /v1/requests/{request_id}
DELETE /v1/requests/{request_id}
GET /v1/requests/{request_id}/map
GET /v1/requests/{request_id}/receipt
GET /v1/places/{place_id}
PUT /v1/places/{place_id}
GET /v1/payment-methods
POST /v1/reminders
GET /v1/reminders/{reminder_id}
PATCH /v1/reminders/{reminder_id}
DELETE /v1/reminders/{reminder_id

To create an authorisation token, go to https://developer.uber.com/dashboard/.

Sample queries (substitute valid text for SERVER_TOKEN):

$ curl -H 'Authorization: Token SERVER_TOKEN' 'https://api.uber.com/v1/products?latitude=37.7759792&longitude=-122.41823'
