include("../aoc.jl")
cd("./day11/")

using .AOC
# cd("./day10/")

# data_loc = "day11_test.txt"
data_loc = "day11_input.txt"
# data = AOC.import_strings(data_loc)

function parse_input(input_loc)
  open(input_loc) do f
    split(read(f, String), "\n\n")
  end
end

data = parse_input(data_loc)


# Each monkey has several attributes:
# Starting items lists your worry level for each item the monkey is currently holding in the order they will be inspected.
# Operation shows how your worry level changes as that monkey inspects an item. 
#   (An operation like new = old * 5 means that your worry level after the monkey inspected 
#     the item is five times whatever your worry level was before inspection.)
# Test shows how the monkey uses your worry level to decide where to throw an item next.
#   If true shows what happens with an item if the Test was true.
#   If false shows what happens with an item if the Test was false.

mutable struct Monkey
  index :: Int
  items :: Array{Int, 1}
  operation :: Array{String, 1}
  # operation :: String
  test_value :: Int
  test_true :: Int
  test_false :: Int
  item_cnt :: Int
end


function parse_operation(operation)
  temp_operation = split(split(operation, " = ")[2], " ")[2:3]
  # a = temp_operation[1]
  # b = temp_operation[3]
  # operator = temp_operation[2]
end


function process_monkeys(data)
  monkeys = Monkey[]
  for i in 1:length(data)
    temp = split(data[i], "\n")
    index = i - 1
    items = parse.(Int, split(split(temp[2], ": ")[2], ", "))
    # operation = split(temp[3], ": ")[2]
    operation = parse_operation(temp[3])
    test_value = parse(Int, split(temp[4], "divisible by ")[2])
    test_true = parse(Int, split(temp[5], "monkey ")[2])
    test_false = parse(Int, split(temp[6], "monkey ")[2])
    push!(monkeys, Monkey(index, items, operation, test_value, test_true, test_false, 0))
  end  
  monkeys
end


function complete_operation(x, operation)
  out = 0
  operator = operation[1]
  if operation[2] == "old"
    a = x
  else
    a = parse(Int, operation[2])
  end
  @match operator begin
    "+" => x + a
    "*" => x * a
    "-" => x - a
  end
end

# for each round:
# monkey0 -> monkey1 -> monkey2 -> ... -> loop back to monkey0
# 
# for each turn:
# inspect item (operation) -> 
#     worry level divided by 3 and rounded downtest worry level -> 
#         test worry level ->
#            throw item to next monkey based on test

function inspect_item(x, operation, relieved = true)
  new = complete_operation(x, operation)
  if relieved
    relief = Int(floor(new/3))
  else
    relief = Int64(new)
  end
  relief
end

function test_item(x, test_value)
  if x % test_value == 0
    true
  else
    false
  end
end

function complete_round(monkeys, relieved = true)
  for m in 1:length(monkeys)
    current_monkey = monkeys[m]
    current_monkey.item_cnt += length(current_monkey.items)
    if length(current_monkey.items) > 0
      for i in 1:length(current_monkey.items)
        new_item = inspect_item(current_monkey.items[i], current_monkey.operation, relieved)
        if test_item(new_item, current_monkey.test_value)          
          new_monkey = current_monkey.test_true + 1
          push!(monkeys[new_monkey].items, new_item)
        else
          new_monkey = current_monkey.test_false + 1
          push!(monkeys[new_monkey].items, new_item)
        end
      end
      current_monkey.items = []
    end
  end
end


monkeys = process_monkeys(data)

function monkey_business(monkeys, rounds, relieved)
  for r in 1:rounds
    complete_round(monkeys, relieved)
  end
  df = DataFrame(monkey = Int[], item_cnt = Int[])
  for i in 1:length(monkeys)
    push!(df, [monkeys[i].index, monkeys[i].item_cnt])
  end
  sort!(df, :item_cnt, rev=true)
  solution = df[1, :item_cnt] * df[2, :item_cnt]
end


part1 = monkey_business(monkeys, 20, true)
println("The solution to part 1 is: $part1")


part2 = monkey_business(monkeys, 10000, false)


monkeys = process_monkeys(data)
for i in 1:20
  complete_round(monkeys, false)
end
monkeys