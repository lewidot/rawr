import gleam/float
import gleam/int
import gleam/result

pub opaque type Calculator {
  Calculator(age: String, weight: Float, meals: Int)
}

pub fn new(
  age: String,
  weight: String,
  meals: String,
) -> Result(Calculator, Nil) {
  use weight <- result.try(float.parse(weight))
  use meals <- result.try(int.parse(meals))

  Ok(Calculator(age, weight, meals))
}
