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
