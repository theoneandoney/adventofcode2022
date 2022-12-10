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

function move_right(head, tail, distance)
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

function move_left(head, tail, distance)
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

function move_up(head, tail, distance)
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

function move_down(head, tail, distance)
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



# part 1
motions = get_motions(data)
head = Coord(0,0)
tail = Coord(0,0)
tail_history = []
update_tail_history(tail, tail_history)

for m in 1:length(motions)
  head, tail = @match motions[m] begin
    Motion('U', distance) => move_up(head, tail, distance)
    Motion('D', distance) => move_down(head, tail, distance)
    Motion('L', distance) => move_left(head, tail, distance)
    Motion('R', distance) => move_right(head, tail, distance)
  end
end

solution1 = length(unique(tail_history))
println("The solution to part 1 is: $solution1")


# part 2