# day02 of AOC 2022
using Chain
using Combinatorics: permutations, combinations
using LinearAlgebra: dot, transpose
using Primes: factor
using StatsBase: countmap, rle
using Statistics
using Graphs
using DataFrames, DataFramesMeta
using CSV
using Match


# cd("./day02")
cd("../day02")
input_loc = "day02_input.csv"

# part 1
# create a dataframe from the input, determine winner for each round,
# find your score for each round, then sum the total score
df = CSV.read(input_loc, delim = " ", header = false, DataFrame)

@chain df begin
  rename!(:Column1 => :first)
  rename!(:Column2 => :second)
end

# A, X == Rock
# B, Y == Paper
# C, Z == Scissors
function determine_outcome(first, second)
  @match first, second begin
    "A", "X" => "draw"
    "A", "Y" => "win"
    "A", "Z" => "lose"
    "B", "X" => "lose"
    "B", "Y" => "draw"
    "B", "Z" => "win"
    "C", "X" => "win"
    "C", "Y" => "lose"
    "C", "Z" => "draw"
  end
end

# The score for a single round is the score for the shape you 
# selected (1 for Rock (x), 2 for Paper (y), and 3 for Scissors (z)) 
# plus the score for the outcome of the round (0 if you lost, 3 if the 
# round was a draw, and 6 if you won)
function determine_score(second, outcome)
  @match second, outcome begin
    "X", "win" => 1+6
    "X", "lose" => 1
    "X", "draw" => 1+3
    "Y", "win" => 2+6
    "Y", "lose" => 2
    "Y", "draw" => 2+3
    "Z", "win" => 3+6
    "Z", "lose" => 3
    "Z", "draw" => 3+3
  end
end

# add new DF columns for outcome and score
df.outcome = [determine_outcome(df.first[i], df.second[i]) for i in eachindex(df.first)]
df.score = [determine_score(df.second[i], df.outcome[i]) for i in eachindex(df.second)]

total_score = sum(df.score)
println("The total score is: ", total_score)

## part 2
# The Elf finishes helping with the tent and sneaks back over to you. 
# "Anyway, the second column says how the round needs to end: X means 
# you need to lose, Y means you need to end the round in a draw, and 
# Z means you need to win. Good luck!"
# A == Rock
# B == Paper
# C == Scissors
# X == lose
# Y == draw
# Z == win
df2 = CSV.read(input_loc, delim = " ", header = false, DataFrame)

@chain df2 begin
  rename!(:Column1 => :first)
  rename!(:Column2 => :intention)
end

function determine_move(first, intention)
  @match first, intention begin
    "A", "X" => "Scissors"
    "A", "Y" => "Rock"
    "A", "Z" => "Paper"
    "B", "X" => "Rock"
    "B", "Y" => "Paper"
    "B", "Z" => "Scissors"
    "C", "X" => "Paper"
    "C", "Y" => "Scissors"
    "C", "Z" => "Rock"
  end
end

function determine_new_score(second, outcome)
  @match second, outcome begin
    "Rock", "Z" => 1+6
    "Rock", "X" => 1
    "Rock", "Y" => 1+3
    "Paper", "Z" => 2+6
    "Paper", "X" => 2
    "Paper", "Y" => 2+3
    "Scissors", "Z" => 3+6
    "Scissors", "X" => 3
    "Scissors", "Y" => 3+3
  end
end

df2.second = [determine_move(df2.first[i], df2.intention[i]) for i in eachindex(df2.first)]
df2.score = [determine_new_score(df2.second[i], df2.intention[i]) for i in eachindex(df2.second)]

total_new_score = sum(df2.score)
println("The new total score is: ", total_new_score)