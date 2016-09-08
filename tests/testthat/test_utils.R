context("geocode")

test_that("raise error on fail to geocode", {
  expect_error(geocode("The Old Biscuit Mill"), "Unable to find location 'The Old Biscuit Mill'.")
})
