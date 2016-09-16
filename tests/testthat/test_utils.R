context("Utils")

test_that("raise error on fail to geocode", {
  expect_error(geocode("The Old Biscuit Mill"), "Unable to find location 'The Old Biscuit Mill'.")
})

test_that("check.latitude() fails for invalid latitudes", {
  expect_error(check.latitude(-95))
  expect_error(check.latitude(+95))
})

test_that("check.latitude() passes for valid latitudes", {
  expect_silent(check.latitude(-90))
  expect_silent(check.latitude(+90))
})

test_that("check.longitude() fails for invalid longitude", {
  expect_error(check.longitude(-185))
  expect_error(check.longitude(+185))
})

test_that("check.longitude() passes for valid longitude", {
  expect_silent(check.longitude(-180))
  expect_silent(check.longitude(+180))
})
