# day03 of AOC 2022
include("../aoc.jl")


cd("./day03")
# cd("../day03")
# input_loc = "day03_test.txt"
input_loc = "day03_input.txt"

df = import_df(input_loc)

# data = import_strings(input_loc)
rename!(df, "Column1" => "input")


# part 1
# A given rucksack always has the same number of items in 
# each of its two compartments, so the first half of the 
# characters represent items in the first compartment, while 
# the second half of the characters represent items in 
# the second compartment.

# To help prioritize item rearrangement, every item type can 
# be converted to a priority:
#  - Lowercase item types a through z have priorities 1 through 26.
#  - Uppercase item types A through Z have priorities 27 through 52.

# Find the item type that appears in both compartments of each 
# rucksack. What is the sum of the priorities of those item types?

# split each rucksack in half
df[!, :comp1] = map(x -> x[1:div(length(x), 2)], df.input)
df[!, :comp2] = map(x -> x[div(length(x), 2)+1:end], df.input)

# find the intersection of each rucksack

function find_intersect(comp1, comp2)
    intersect(comp1, comp2)# |> string
end

df[!, :intersect] = map(find_intersect, df.comp1, df.comp2) |> collect

function find_priority(intersect)
  # find the priority of each item in the intersection
  priority = map(x -> findfirst(x, join('a':'z') * join('A':'Z')), collect(intersect))
  # priority = findfirst(intersect, join('a':'z') * join('A':'Z'))
end

df.priority = map(find_priority, df.intersect)
part1 = sum(df.priority)
println("The sum of the priorities is: ", part1)


# part 2
# need to split rucksacks into groups of three and search for intersect,
# priority count is the same

# Every set of three lines in your list corresponds to a single group, 
# but each group can have a different badge item type.

data = import_strings(input_loc)
df2 = DataFrame(first = data[(1:3:end)], second = data[(2:3:end)], third = data[(3:3:end)])

function find_badge(first, second, third)
    intersect(first, second, third)
end

df2[!, :badge] = map(find_badge, df2.first, df2.second, df2.third) |> collect
df2.priority = map(find_priority, df2.badge)

part2 = sum(df2.priority)
println("The sum of the priorities for part 2 is: ", part2)