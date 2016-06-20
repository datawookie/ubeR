library(ubeR)

context("authorise")

test_that("set serverid", {
  serverid = Sys.getenv("UBER_SERVERID")
  expect_equal(set_serverid(serverid), serverid)
})

test_that("get serverid", {
  serverid = Sys.getenv("UBER_SERVERID")
  expect_equal(get_serverid(), serverid)
})
