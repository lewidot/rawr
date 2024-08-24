import wisp

/// Middleware stack function.
pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  // Allow use of ?_method= query parameter to override post method
  let req = wisp.method_override(req)

  use <- wisp.serve_static(req, under: "/static", from: "priv/static")

  // Log the request and response
  use <- wisp.log_request(req)

  // Return status 500 if a request handler crashes
  use <- wisp.rescue_crashes

  // Rewrite HEAD requests to GET requests
  use req <- wisp.handle_head(req)

  // Handle the request
  handle_request(req)
}
