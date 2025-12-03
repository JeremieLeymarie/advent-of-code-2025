import day_01/part_01
import gleam/int
import gleam/list
import gleam/result

import simplifile

fn are_same_sign(a: Int, b: Int) {
  a * b > 0
}

fn compute_rotations(instructions: List(Int)) -> Int {
  list.fold(instructions, #(0, 50), fn(acc, instruction) {
    let #(result, current) = acc
    let new_current = current + instruction
    let rotations =
      int.absolute_value(new_current)
      / 100
      + case are_same_sign(current, new_current) {
        False if current != 0 -> 1
        True if new_current == 0 -> 1
        _ -> 0
      }

    #(result + rotations, new_current % 100)
  }).0
}

pub fn main() {
  let filename = "./src/day_01/input.txt"
  let assert Ok(instructions) =
    simplifile.read(from: filename) |> result.map(part_01.parse)

  echo compute_rotations(instructions)
}
