import nakai/attr
import nakai/html.{type Node}

/// Base HTML layout.
pub fn base(children: List(Node)) -> Node {
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
    html.Body([attr.class("bg-white h-screen")], children),
  ])
}

/// Main application HTML view.
pub fn app() -> Node {
  base([
    html.div(
      [
        attr.class(
          "py-8 px-4 mx-auto max-w-screen-xl text-center lg:py-16 lg:px-12",
        ),
      ],
      [
        html.h1_text(
          [
            attr.class(
              "text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl",
            ),
          ],
          "Raw Food Calculator",
        ),
      ],
    ),
    calculator_form(),
  ])
}

/// HTML component for the calculator form.
pub fn calculator_form() -> Node {
  html.form([attr.class("max-w-sm mx-auto")], [age_select()])
}

/// Age select box HTML component.
fn age_select() -> Node {
  html.div([attr.class("mb-5")], [
    html.label(
      [
        attr.for("age"),
        attr.class("block mb-2 text-sm font-medium text-gray-900"),
      ],
      [html.Text("Your dogs age")],
    ),
    html.select(
      [
        attr.name("age"),
        attr.id("age"),
        attr.required("true"),
        attr.class(
          "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-red-300 focus:border-red-500 block w-full p-2.5",
        ),
      ],
      [
        html.option([], [html.Text("0 to 4 months")]),
        html.option([], [html.Text("5 to 6 months")]),
        html.option([], [html.Text("7 to 9 months")]),
        html.option([], [html.Text("10 to 11 months")]),
        html.option([attr.selected()], [html.Text("12 months +")]),
      ],
    ),
  ])
}
