import gleeunit
import gleeunit/should
import rawr/router
import wisp/testing

pub fn main() {
  gleeunit.main()
}

pub fn root_test() {
  let response = router.handle_request(testing.get("/", []))

  response.status
  |> should.equal(200)

  response.headers
  |> should.equal([#("content-type", "text/html; charset=utf-8")])
}
