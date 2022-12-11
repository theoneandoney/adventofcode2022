# day09 of AOC 2022
cd("./day09")
# cd("../day09")
include("../aoc.jl")

# input_loc = "day09_input.txt"
input_loc = "day09_test.txt"

data = import_strings(input_loc)

struct Motion
  direction::Char
  distance::Int
end

struct Coord
  x::Int
  y::Int
end

function parse_motion(str)
  return Motion(str[1], parse(Int, str[2:end]))
end

function get_motions(data)
  motions = []
  for i in 1:length(data)
    push!(motions, parse_motion(data[i]))
  end
  return motions
end

function tail_relative_to_head(tail, head)
  return Coord(tail.x - head.x, tail.y - head.y)
end

function tail_left(tail, head)
  if tail_relative_to_head(tail, head).x == -1
    return true
  else
    return false
  end
end

function tail_down(tail, head)
  if tail_relative_to_head(tail, head).y == -1
    return true
  else
    return false
  end
end

function tail_within_one(tail, head)
  @match tail_relative_to_head(tail, head) begin
    Coord(1,0) => true
    Coord(0,1) => true
    Coord(-1,0) => true
    Coord(0,-1) => true
    Coord(0, 0) => true
    _ => false
  end
end

function update_tail_history(tail, tail_history)
  push!(tail_history, tail)
end

function move_right(head, tail, distance, tail_history)
  println(tail_left)
  for i in 1:distance
    if tail_left(tail, head) == false  || tail.x == head.x
      head = Coord(head.x + 1, head.y)
      tail = tail
      update_tail_history(tail, tail_history)
    else
      head = Coord(head.x + 1, head.y)
      tail = Coord(tail.x + 1, head.y) # head.y accounts for potential diagonal movement
      update_tail_history(tail, tail_history)
    end
  end
  return head, tail
end

function move_left(head, tail, distance, tail_history)
  for i in 1:distance
    if tail_left(tail, head) == true || tail.x == head.x
      head = Coord(head.x - 1, head.y)
      tail = tail
      update_tail_history(tail, tail_history)
    else
      head = Coord(head.x - 1, head.y)
      tail = Coord(tail.x - 1, head.y) # head.y accounts for potential diagonal movement
      update_tail_history(tail, tail_history)
    end
  end
  return head, tail
end

function move_up(head, tail, distance, tail_history)
  for i in 1:distance
    if tail_down(tail, head) == false || tail.y == head.y
      head = Coord(head.x, head.y + 1)
      tail = tail
      update_tail_history(tail, tail_history)
    else
      head = Coord(head.x, head.y + 1)
      tail = Coord(head.x, tail.y + 1) # head.x accounts for potential diagonal movement
      update_tail_history(tail, tail_history)
    end
  end
  return head, tail
end

function move_down(head, tail, distance, tail_history)
  for i in 1:distance
    if tail_down(tail, head) == true || tail.y == head.y
      head = Coord(head.x, head.y - 1)
      tail = tail
      update_tail_history(tail, tail_history)
    else
      head = Coord(head.x, head.y - 1)
      tail = Coord(head.x, tail.y - 1) # head.x accounts for potential diagonal movement
      update_tail_history(tail, tail_history)
    end
  end
  return head, tail
end

function move(head, tail, motion, tail_history)
  @match motion begin
    Motion('U', distance) => move_up(head, tail, distance, tail_history)
    Motion('D', distance) => move_down(head, tail, distance, tail_history)
    Motion('L', distance) => move_left(head, tail, distance, tail_history)
    Motion('R', distance) => move_right(head, tail, distance, tail_history)
  end
end

# part 1
motions = get_motions(data)
head = Coord(0,0)
tail = Coord(0,0)
tail_history = []
update_tail_history(tail, tail_history)

for m in 1:length(motions)
  head, tail = move(head, tail, motions[m], tail_history)
end


solution1 = length(unique(tail_history))
println("The solution to part 1 is: $solution1")


# part 2
# need to keep track of 10 knots
motions = get_motions(data)
head = Coord(0,0)
knot1 = Coord(0,0)
knot2 = Coord(0,0)
knot3 = Coord(0,0)
knot4 = Coord(0,0)
knot5 = Coord(0,0)
knot6 = Coord(0,0)
knot7 = Coord(0,0)
knot8 = Coord(0,0)
knot9 = Coord(0,0)
knot1_history = []
knot2_history = []
knot3_history = []
knot4_history = []
knot5_history = []
knot6_history = []
knot7_history = []
knot8_history = []
knot9_history = []





update_tail_history(knot1, knot1_history)
update_tail_history(knot2, knot2_history)
update_tail_history(knot3, knot3_history)
update_tail_history(knot4, knot4_history)
update_tail_history(knot5, knot5_history)
update_tail_history(knot6, knot6_history)
update_tail_history(knot7, knot7_history)
update_tail_history(knot8, knot8_history)
update_tail_history(knot9, knot9_history)

for m in 1:length(motions)
  knot1_last = knot1
  head, knot1 = move(head, knot1, motions[m], knot1_history)
  if knot1 != knot1_last
    knot2_last = knot2
    temp1, knot2 = move(knot1_last, knot2, motions[m], knot2_history)
    if knot2 != knot2_last
      knot3_last = knot3
      temp2, knot3 = move(knot2_last, knot3, motions[m], knot3_history)
      if knot3 != knot3_last
        knot4_last = knot4
        temp3, knot4 = move(knot3_last, knot4, motions[m], knot4_history)
        if knot4 != knot4_last
          knot5_last = knot5
          temp4, knot5 = move(knot4_last, knot5, motions[m], knot5_history)
          if knot5 != knot5_last
            knot6_last = knot6
            temp5, knot6 = move(knot5_last, knot6, motions[m], knot6_history)
            if knot6 != knot6_last
              knot7_last = knot7
              temp6, knot7 = move(knot6_last, knot7, motions[m], knot7_history)
              if knot7 != knot7_last
                knot8_last = knot8
                temp7, knot8 = move(knot7_last, knot8, motions[m], knot8_history)
                if knot8 != knot8_last
                  knot9_last = knot9
                  temp8, knot9 = move(knot8_last, knot9, motions[m], knot9_history)
                end
              end
            end
          end
        end
      end
    end
  end
end



solution2 = length(unique(knot9_history))
println("The solution to part 2 is: $solution2")




# struct Command
#   direction::Char
#   steps::Int
# end

# MOVES = Dict(
#   'U' => (0, 1),
#   'D' => (0, -1),
#   'L' => (-1, 0),
#   'R' => (1, 0),
# )

# @resumable function get_commands()::Command
#   for line in readlines("input.txt")
#       direction = line[1]
#       commands = parse(Int, strip(line[2:end]))

#       @yield Command(direction, commands)
#   end
# end

# function solution(rope_length::Int)::Int
#   body = [[0, 0] for _ in 1:rope_length]
#   visited = Set{Tuple{Int, Int}}()
#   push!(visited, (0, 0))

#   for command in get_commands()
#       for _ in 1:command.steps
#           body[1][1] += MOVES[command.direction][1]
#           body[1][2] += MOVES[command.direction][2]

#           for i in 2:length(body)
#               cx, cy = body[i - 1][1] - body[i][1], body[i - 1][2] - body[i][2]
#               if max(abs(cx), abs(cy)) > 1
#                   body[i][1] += cx > 0 ? 1 : cx < 0 ? -1 : 0 
#                   body[i][2] += cy > 0 ? 1 : cy < 0 ? -1 : 0
#               end
#           end

#           push!(visited, (body[end][1], body[end][2]))
#       end
#   end

#   return length(visited)
# end

# println("Solution part 1: ", solution(2))
# println("Solution part 2: ", solution(10))