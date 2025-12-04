import gleam/int
import gleam/list
import gleam/result
import gleam/string

import simplifile

fn are_lists_equal(a: List(String), b: List(String)) {
  list.zip(a, b)
  |> list.all(fn(el) { el.0 == el.1 })
}

pub fn parse(content: String) {
  string.split(content, on: ",")
  |> list.flat_map(fn(range) {
    let assert [start_, end_] = string.split(range, "-")
    let assert Ok(start) = int.parse(start_)
    let assert Ok(end) = int.parse(end_)
    list.range(start, end)
  })
}

fn compute(ids: List(Int)) {
  list.fold(ids, 0, fn(acc, id) {
    let chars = string.split(int.to_string(id), "")
    let len = list.length(chars)
    case len % 2 == 0 {
      True -> {
        let #(first_half, second_half) = list.split(chars, len / 2)
        case are_lists_equal(first_half, second_half) {
          True -> {
            acc + id
          }
          False -> acc
        }
      }

      False -> acc
    }
  })
}

pub fn main() {
  let filename = "./src/day_02/input.txt"
  let assert Ok(ids) = simplifile.read(from: filename) |> result.map(parse)

  echo compute(ids)
}
