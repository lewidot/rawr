import gleam/http
import gleam/io
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
      // Check if the weight has decimal places so we can cast it to a float. TODO Dynamic may work better here
      let weight = case string.contains(does: weight, contain: ".") {
        True -> weight
        False -> weight <> ".00"
      }

      case calculator.new(age, weight, meals) {
        Ok(c) -> {
          io.debug(c)
          html.div([], [
            html.p_text([], "age: " <> age),
            html.p_text([], "weight: " <> weight),
            html.p_text([], "meals: " <> meals),
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
