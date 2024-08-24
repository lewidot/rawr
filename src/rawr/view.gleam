import nakai/attr
import nakai/html.{type Node}

/// Base HTML layout.
pub fn base(children: List(Node)) -> Node {
  html.Html([attr.lang("en")], [
    html.Head([
      html.meta([
        attr.name("viewport"),
        attr.content("width=device-width, initial-scale=1.0"),
      ]),
      html.link([attr.rel("preconnect"), attr.href("https://rsms.me/")]),
      html.link([
        attr.rel("stylesheet"),
        attr.href("https://rsms.me/inter/inter.css"),
      ]),
      html.link([attr.rel("stylesheet"), attr.href("/static/style.css")]),
      html.Script(
        [
          attr.src("https://unpkg.com/htmx.org@2.0.2"),
          attr.integrity(
            "sha384-Y7hw+L/jvKeWIRRkqWYfPcvVxHzVzn5REgzbawhxAuQGwX1XWe70vji+VSeHOThJ",
          ),
          attr.crossorigin("anonymous"),
        ],
        "",
      ),
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
    html.div([attr.class("max-w-sm mx-auto mt-10"), attr.id("results")], []),
  ])
}

/// HTML component for the calculator form.
pub fn calculator_form() -> Node {
  html.form(
    [
      attr.class("max-w-sm mx-auto"),
      attr.Attr("hx-post", "/calculate"),
      attr.Attr("hx-target", "#results"),
    ],
    [age_select(), weight_input(), meals_input(), calculate_button()],
  )
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

/// Weight input HTML component.
fn weight_input() -> Node {
  html.div([attr.class("mb-5")], [
    html.label(
      [
        attr.for("weight"),
        attr.class("block mb-2 text-sm font-medium text-gray-900"),
      ],
      [html.Text("Weight (kg)")],
    ),
    html.input([
      attr.name("weight"),
      attr.id("weight"),
      attr.type_("number"),
      attr.Attr("min", "0.01"),
      attr.Attr("max", "250"),
      attr.Attr("step", "0.01"),
      attr.placeholder("15"),
      attr.required("true"),
      attr.class(
        "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-red-300 focus:border-red-500 block w-full p-2.5",
      ),
    ]),
  ])
}

/// Meals input HTML component.
fn meals_input() -> Node {
  html.div([attr.class("mb-8")], [
    html.label(
      [
        attr.for("meals"),
        attr.class("block mb-2 text-sm font-medium text-gray-900"),
      ],
      [html.Text("Daily meals")],
    ),
    html.input([
      attr.name("meals"),
      attr.id("meals"),
      attr.type_("number"),
      attr.Attr("min", "1"),
      attr.Attr("max", "10"),
      attr.Attr("step", "1"),
      attr.placeholder("2"),
      attr.required("true"),
      attr.class(
        "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-red-300 focus:border-red-500 block w-full p-2.5",
      ),
    ]),
  ])
}

/// Calculate button HTML component.
fn calculate_button() -> Node {
  html.div([attr.class("mb-5")], [
    html.button_text(
      [
        attr.type_("submit"),
        attr.class(
          "text-white text-lg bg-gradient-to-r from-red-400 via-red-500 to-red-600 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-red-300 shadow-lg shadow-red-500/50 font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2 w-full",
        ),
      ],
      "Calculate",
    ),
  ])
}
