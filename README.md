https://github.com/geoffjentry/twitteR

https://developer.uber.com/docs/rides

To create an authorisation token, go to https://developer.uber.com/dashboard/.

Sample queries (substitute valid text for SERVER_TOKEN):

$ curl -H 'Authorization: Token SERVER_TOKEN' 'https://api.uber.com/v1/products?latitude=37.7759792&longitude=-122.41823'
