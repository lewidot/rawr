import gleam/float
import gleam/http
import gleam/io
import gleam/list
import gleam/string
import nakai
import nakai/html
import rawr/calculator
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

  use form <- wisp.require_form(req)

  io.debug(form.values)
  case form.values {
    [#("age", age), #("meals", meals), #("weight", weight)] -> {
      case calculator.new(age, weight, meals) {
        Ok(c) -> {
          io.debug(c)
          let result = calculator.calculate(c)
          let assert Ok(first) = list.first(result)
          let assert Ok(second) = list.last(result)
          html.div([], [
            html.p_text(
              [],
              "recommended amount per meal: "
                <> float.to_string(first)
                <> " - "
                <> float.to_string(second),
            ),
          ])
          |> nakai.to_string_builder()
          |> wisp.html_response(200)
        }
        Error(_) -> {
          html.p_text([], "Invalid form data")
          |> nakai.to_string_builder()
          |> wisp.html_response(200)
        }
      }
    }
    _ -> {
      html.p_text([], "That didn't work!")
      |> nakai.to_string_builder()
      |> wisp.html_response(200)
    }
  }
}
