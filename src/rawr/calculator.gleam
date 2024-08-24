import gleam/float
import gleam/int
import gleam/io
import gleam/result
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
  io.debug(age)
  use weight <- result.try(float.parse(weight))
  io.debug(weight)
  use meals <- result.try(int.parse(meals))
  io.debug(meals)

  Ok(Calculator(age, weight, meals))
}
