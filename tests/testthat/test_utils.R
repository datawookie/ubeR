context("geocode")

test_that("raise error on fail to geocode", {
  expect_error(geocode("The Old Biscuit Mill"), "Unable to find location 'The Old Biscuit Mill'.")
})

test_that("this will fail", {
  print("this will fail!")
  expect_equal(1, 0)
})
