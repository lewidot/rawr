pub const zero_to_four = "0 to 4 months"

pub const five_to_six = "5 to 6 months"

pub const seven_to_nine = "7 to 9 months"

pub const ten_to_eleven = "10 to 11 months"

pub const greater_than_twelve = "12 months +"

pub type Age {
  ZeroToFour
  FiveToSix
  SevenToNine
  TenToEleven
  GreaterThanTwelve
}

/// Construct Age from a string.
pub fn from_string(age: String) -> Result(Age, Nil) {
  case age {
    "0 to 4 months" -> Ok(ZeroToFour)
    "5 to 6 months" -> Ok(FiveToSix)
    "7 to 9 months" -> Ok(SevenToNine)
    "10 to 11 months" -> Ok(TenToEleven)
    "12 months +" -> Ok(GreaterThanTwelve)
    _ -> Error(Nil)
  }
}

/// Tuple of percentages for a given age.
pub fn percentages(age: Age) -> #(Int, Int) {
  case age {
    ZeroToFour -> #(8, 10)
    FiveToSix -> #(6, 8)
    SevenToNine -> #(4, 6)
    TenToEleven -> #(3, 4)
    GreaterThanTwelve -> #(2, 3)
  }
}
