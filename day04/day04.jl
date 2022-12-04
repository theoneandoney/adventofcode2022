# day04 of AOC 2022
include("../aoc.jl")

cd("./day04")
input_loc = "day04_input.txt"

# data = import_strings(input_loc)
df = import_df(input_loc)
rename!(df, "Column1" => "input")


# part 1 
# find total intersections between elves and sum them

transform!(df, :input => ByRow(x -> split(x, ',')) => [:elf1, :elf2])

df.elf1 = map(x -> replace(x, "-" => ":", count = 1), df.elf1)
df.elf2 = map(x -> replace(x, "-" => ":", count = 1), df.elf2)

function find_intersections(first, second)
  # parse the strings, convert to vectors
  first_1 = parse(Int, split(first, ':')[1])
  first_2 = parse(Int, split(first, ':')[2])
  second_1 = parse(Int, split(second, ':')[1])
  second_2 = parse(Int, split(second, ':')[2])
  first = Vector(first_1 : first_2)
  second = Vector(second_1 : second_2)
  first_cnt = 0
  second_cnt = 0
  # find the intersection
  first_in_second = indexin(first, second)
  second_in_first = indexin(second, first)
  # count the number of intersections
  for i in 1:length(first_in_second)
    if first_in_second[i] != nothing
      first_cnt += 1
    end
  end
  for i in 1:length(second_in_first)
    if second_in_first[i] != nothing
      second_cnt += 1
    end
  end
  first_full = false
  second_full = false
  if first_cnt == length(first_in_second)
    first_full = true
  end
  if second_cnt == length(second_in_first)
    second_full = true
  end
  match = second_full || first_full
end

df.intersects = map(find_intersections, df.elf1, df.elf2)
solution_pt1 = sum(df.intersects)
println("The solution to part 1 is: ", solution_pt1)


# part 2

# find any overlaps and sum them
function find_overlaps(first, second)
  # parse the strings, convert to vectors
  first_1 = parse(Int, split(first, ':')[1])
  first_2 = parse(Int, split(first, ':')[2])
  second_1 = parse(Int, split(second, ':')[1])
  second_2 = parse(Int, split(second, ':')[2])
  first = Vector(first_1 : first_2)
  second = Vector(second_1 : second_2)
  first_cnt = 0
  second_cnt = 0
  # find the intersection
  first_in_second = indexin(first, second)
  second_in_first = indexin(second, first)
  # count the number of intersections
  for i in 1:length(first_in_second)
    if first_in_second[i] != nothing
      first_cnt += 1
    end
  end
  for i in 1:length(second_in_first)
    if second_in_first[i] != nothing
      second_cnt += 1
    end
  end
  if first_cnt + second_cnt > 0
    true
  else
    false
  end
end

df.overlaps = map(find_overlaps, df.elf1, df.elf2)
solution_pt2 = sum(df.overlaps)
println("The solution to part 2 is: ", solution_pt2)