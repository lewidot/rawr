import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import rawr/age.{type Age}

pub opaque type Calculator {
  Calculator(age: Age, weight: Float, meals: Int)
}

pub fn new(
  age: String,
  weight: String,
  meals: String,
) -> Result(Calculator, Nil) {
  use age <- result.try(age.from_string(age))

  // Check if the weight has decimal places so we can cast it to a float. TODO Dynamic may work better here
  let weight = case string.contains(does: weight, contain: ".") {
    True -> weight
    False -> weight <> ".00"
  }

  use weight <- result.try(float.parse(weight))
  use meals <- result.try(int.parse(meals))

  Ok(Calculator(age, weight, meals))
}

/// Calculate daily amounts based on the weight and the percentages.
fn daily_amounts(calculator: Calculator) -> List(Float) {
  let weight_g = calculator.weight *. 10.0

  list.map(age.percentages(calculator.age), fn(p) {
    int.to_float(p) *. weight_g
  })
}

/// Calculate the amount per meal.
pub fn calculate(calculator: Calculator) -> List(Float) {
  daily_amounts(calculator)
  |> list.map(fn(a) { a /. int.to_float(calculator.meals) })
}
