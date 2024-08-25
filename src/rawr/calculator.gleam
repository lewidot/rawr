import gleam/float
import gleam/int
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
fn daily_amounts(calculator: Calculator) -> #(Float, Float) {
  let weight_g = calculator.weight *. 10.0
  let percentages = age.percentages(calculator.age)

  #(
    int.to_float(percentages.0) *. weight_g,
    int.to_float(percentages.1) *. weight_g,
  )
}

/// Calculate the amount per meal.
pub fn calculate(calculator: Calculator) -> #(Int, Int) {
  // cast meals from int to float
  let meals = int.to_float(calculator.meals)

  // calculate daily amounts
  let daily = daily_amounts(calculator)

  // calculate the meal amounts and round to an int
  let lower = float.round(daily.0 /. meals)
  let upper = float.round(daily.1 /. meals)

  #(lower, upper)
}
