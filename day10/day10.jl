# module Day10

# include("./../aocimproved.jl")
include("../aoc.jl")
cd("./day10/")

using .AOC
# cd("./day10/")

data_loc = "day10_test.txt"
# data_loc = "day10_input.txt"
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







# part 2

# Like the CPU, the CRT is tied closely to the clock circuit: the CRT 
# draws a single pixel during each cycle. Representing each pixel of 
# the screen as a #, here are the cycles during which the first and 
# last pixel in each row are drawn:

# Cycle   1 -> ######################################## <- Cycle  40
# Cycle  41 -> ######################################## <- Cycle  80
# Cycle  81 -> ######################################## <- Cycle 120
# Cycle 121 -> ######################################## <- Cycle 160
# Cycle 161 -> ######################################## <- Cycle 200
# Cycle 201 -> ######################################## <- Cycle 240


registers
sprite = []
crt_out = DataFrame(fill(".", 6, 40), :auto)

for i in 1:2:length(registers)
  cycle = i
  if registers[i][3] == cycle
    push!(sprite, "#")
  elseif registers[i][3] + 1 == cycle
    push!(sprite, "#")
  elseif registers[i][3] - 1 == cycle
    push!(sprite, "#")
  else
    push!(sprite, ".")
  end
  # println(registers[i][3], " ", i)
end

println(sprite[1:40])
println(sprite[41:80])
println(sprite[81:120])

crt_out[1, 1:40] = sprite[1:40]
crt_out[2, 1:40] = sprite[41:80]
crt_out[3, 1:40] = sprite[81:120]
crt_out[4, 1:40] = sprite[121:160]
crt_out[5, 1:40] = sprite[161:200]
crt_out[6, 1:40] = sprite[201:240]


crt_out



