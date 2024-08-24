import nakai/attr
import nakai/html.{type Node}

/// Main application HTML view.
pub fn app(children: List(Node)) -> Node {
  html.Html([attr.lang("en")], [
    html.Head([
      html.link([attr.rel("preconnect"), attr.href("https://rsms.me/")]),
      html.link([
        attr.rel("stylesheet"),
        attr.href("https://rsms.me/inter/inter.css"),
      ]),
      html.link([attr.rel("stylesheet"), attr.href("/static/style.css")]),
      html.meta([
        attr.name("viewport"),
        attr.content("width=device-width, initial-scale=1.0"),
      ]),
      html.title("Rawr!"),
    ]),
    html.Body([], [
      html.h1_text([attr.class("text-4xl")], "This is the heading!"),
      calculator_form(),
      ..children
    ]),
  ])
}

/// HTML component for the calculator form.
pub fn calculator_form() -> Node {
  html.form([], [html.select([], [html.option_text([], "test option")])])
}
