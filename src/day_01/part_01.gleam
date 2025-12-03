import gleam/int
import gleam/list
import gleam/result
import gleam/string

import simplifile

pub fn parse(content: String) {
  string.split(content, on: "\n")
  |> list.map(fn(line) {
    let prefix = case string.starts_with(line, "L") {
      True -> "-"
      False -> ""
    }
    let assert Ok(value) =
      int.base_parse(prefix <> string.drop_start(from: line, up_to: 1), 10)
    value
  })
}

fn compute_rotations(instructions: List(Int)) -> Int {
  list.fold(instructions, #(0, 50), fn(acc, instruction) {
    let #(result, current) = acc
    let new_current = { current + instruction } % 100
    let new_result = case new_current == 0 {
      True -> result + 1
      False -> result
    }

    #(new_result, new_current)
  }).0
}

pub fn main() {
  let filename = "./src/day_01/input.txt"
  let assert Ok(instructions) =
    simplifile.read(from: filename) |> result.map(parse)

  echo compute_rotations(instructions)
}
