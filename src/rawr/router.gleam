import gleam/http
import nakai
import nakai/html
import rawr/view
import rawr/web
import wisp

/// HTTP request handler.
pub fn handle_request(req: wisp.Request) -> wisp.Response {
  // Apply the middleware stack for this request/response.
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> root_handler(req)
    ["calculate"] -> calculate_handler(req)

    _ -> wisp.not_found()
  }
}

/// Request handler for "/".
fn root_handler(req: wisp.Request) -> wisp.Response {
  use <- wisp.require_method(req, http.Get)

  view.app()
  |> nakai.to_string_builder()
  |> wisp.html_response(200)
}

/// Request handler for "/calculate".
fn calculate_handler(req: wisp.Request) -> wisp.Response {
  use <- wisp.require_method(req, http.Post)

  html.p_text([], "Is HTMX working?!")
  |> nakai.to_string_builder()
  |> wisp.html_response(200)
}
