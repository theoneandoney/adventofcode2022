# day05 of AOC 2022
cd("./day05")
include("../aoc.jl")

# cd("./day05")P
input_loc = "day05_input.txt"
# input_loc = "day05_test.txt"
data = import_strings(input_loc)

struct Stack
  id::Int
  crates::Vector{String}
end

# parse data into stacks and instructions
footer_loc = findfirst(isequal(""), data)
footer_length = length(data) - findfirst(isequal(""), data)


function get_stacks(data)
  stack_data = data[1:findfirst(isequal(""), data)-1]
  stack_cnt = parse(Int, stack_data[end][end-1])

  function parse_stacks(stack_data, stack_cnt, footer_loc)
    stacks = []
    ptr = 1
    for i in 1:stack_cnt
      stack_id = i
      temp_stack = []
      for j in 1:footer_loc-2
        temp_crate = stack_data[j][ptr:ptr+2]
        if temp_crate != "   "
          push!(temp_stack, temp_crate)
        end
      end
      temp_stack = reverse(temp_stack)
      push!(stacks, Stack(stack_id, temp_stack))
      ptr = ptr+4
    end
    stacks
  end
  
  stacks = parse_stacks(stack_data, stack_cnt, footer_loc)
end


function get_instructions(data)
  instructions = CSV.read(input_loc, header = false, skipto = footer_loc, delim = " ", DataFrame)
  # instructions = reverse(instructions)
  @chain instructions begin
    rename!(:Column2 => :num_boxes)
    rename!(:Column4 => :source)
    rename!(:Column6 => :dest)
    select!(Not(:Column1))
    select!(Not(:Column3))
    select!(Not(:Column5))
  end
  instructions
end


# function to move crates from one stack to another
# in part 1 move 1 crate at a time, but in part 2 move
# all the given crates at once
function rearrange_stacks(stacks, instructions, multiple_move = false)
  for i in 1:size(instructions, 1)
    source_stack = instructions.source[i]
    dest_stack = instructions.dest[i]
    num_boxes = instructions.num_boxes[i]
    
    if multiple_move == false
      for j in 1:num_boxes
        push!(stacks[dest_stack].crates, stacks[source_stack].crates[end])
        pop!(stacks[source_stack].crates)
      end
    else
      for j in 1:num_boxes
        push!(stacks[dest_stack].crates, stacks[source_stack].crates[end-num_boxes+j:end])
        pop!(stacks[source_stack].crates, num_boxes)
      end
      
    end
  end
  stacks
end


function find_top_crates(stacks)
  top_crates = []
  for i in 1:length(stacks)
    push!(top_crates, stacks[i].crates[end])
  end
  top_crates_out = ""
  for i in 1:length(top_crates)
    top_crates_out = top_crates_out * top_crates[i][2]
  end
  println("The top crates are: ", top_crates_out)
end

stacks = get_stacks(data)
instructions = get_instructions(data)
rearrange_stacks(stacks, instructions, false)
top_crates = find_top_crates(stacks)


# part 2 solution
function rearrange_stacks2(stacks2, instructions2, multiple_move = false)
  for i in 1:size(instructions2, 1)
    source_stack = instructions2.source[i]
    dest_stack = instructions2.dest[i]
    num_boxes = instructions2.num_boxes[i]
    for j in 1:num_boxes
      push!(stacks2[dest_stack].crates, stacks2[source_stack].crates[end-num_boxes+j])
      deleteat!(stacks2[source_stack].crates,  length(stacks2[source_stack].crates)-num_boxes+j)
    end
  end
  stacks2
end

stacks2 = get_stacks(data)
instructions2 = get_instructions(data)
rearrange_stacks2(stacks2, instructions2, false)

top_crates2 = find_top_crates(stacks2)