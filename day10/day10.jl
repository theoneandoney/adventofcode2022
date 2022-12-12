# module Day10

# include("./../aocimproved.jl")
include("../aoc.jl")

using .AOC
# cd("./day10/")

# data_loc = "day10_test.txt"
data_loc = "day10_input.txt"
data = AOC.import_strings(data_loc)


struct Instruction
  operation::String
  value::Int
end


function process_input(data)
  output = Instruction[]
  for i in 1:length(data)
    if data[i] == "noop"
      op = "noop"
      val = "0"
    else
      op, val = split(data[i])
    end
    push!(output, Instruction(op, parse(Int, val)))
  end
  output
end



input = process_input(data)
edges = Instruction[]
for i in 1:length(input)
  if input[i].operation == "addx"
    push!(edges, input[i])
    push!(edges, Instruction("wait", 0))
    push!(edges, Instruction("wait", 0))
    push!(edges, Instruction("wait", 0))
  else
    push!(edges, input[i])
    push!(edges, Instruction("wait", 0))
  end
end

input
edges

registers = []
v = 0
x = 1
for i in 1:length(edges)
  if edges[i].operation == "addx"
    x += v
    v = edges[i].value
  elseif edges[i].operation == "noop"
    x += v
    v = edges[i].value
  end
  push!(registers, (edges[i].operation, v, x))
end

cycle20 = registers[40][3]
cycle60 = registers[120][3]
cycle100 = registers[200][3]
cycle140 = registers[280][3]
cycle180 = registers[360][3]
cycle220 = registers[440][3]

solution_pt1 = (20 * cycle20) + (60 * cycle60) + (100 * cycle100) + (140 * cycle140) + (180 * cycle180) + (220 * cycle220)