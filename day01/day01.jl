# day01 of AOC 2022
using Chain
using Combinatorics: permutations, combinations
using LinearAlgebra: dot, transpose
using Primes: factor
using StatsBase: countmap, rle
using Statistics
using Graphs
using DataFrames, DataFramesMeta


# cd("./day01")
cd("../day01")
input_loc = "day01_input.txt"

puzzleinput = open(input_loc) do f
  split(read(f, String), "\n\n")
end


# part 1
# parse the input, sum the calories for each elf, then find the max

function create_calories(puzzleinput)
  calories = []
  for i in eachindex(puzzleinput)
    temp = parse.(Int64, split(puzzleinput[i], "\n"))
    push!(calories, temp)
  end
  return calories
end

calories = create_calories(puzzleinput)


calorie_sums = map(sum, calories)
max, max_location = findmax(calorie_sums)

println("The elf carrying the most calories is #", max_location)
println("The amount of calories is: ", max)

# part 2
# find the count for the top 3 elves

# playing around with dataframes, need to learn for later
# df = DataFrame(index = collect(1:length(calorie_sums)), calories = calorie_sums)
# sort!(df, [:calories], rev = true)

sort!(calorie_sums, rev = true)
max3 = sum(calorie_sums[1:3])
println("The sum of the top three calorie counts is: ", max3)