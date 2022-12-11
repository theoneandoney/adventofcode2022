# functions for use during AOC 2022
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
using DelimitedFiles
# using Coordinates


function import_strings(input_loc)
    # import the input as a vector of strings
    open(input_loc) do f
        input = readlines(f)
    end
end

function import_df(input_loc)
    # import the input as a dataframe
    df = CSV.read(input_loc, delim = " ", header = false, DataFrame)
end











module AOC

export Puzzle, processinput, printresults

struct Puzzle
    day
    name
    inputfilename
    solve
    answer
end

import Pkg
Pkg.activate(".", io = devnull)

processinput(data) = data

Puzzle(day, name, solve, answer) = Puzzle(day, name, "input.txt", solve, answer)

function solve(puzzle::Puzzle)
    input = rawinput(puzzle)
    answer = puzzle.solve(input)
    if puzzle.answer === nothing
        "Het vermoedelijke antwoord van puzzel dag $(puzzle.day) - $(puzzle.name) is: $(answer)"
    elseif answer == puzzle.answer
        green("Het antwoord van puzzel dag $(puzzle.day) - $(puzzle.name) is: $(answer)")
    else
        red("Het antwoord van puzzel dag $(puzzle.day) -  $(puzzle.name) is: $(answer), maar moet zijn: $(puzzle.answer)")
    end
end

function getresults(puzzles::Array)
    map(p -> solve(p), puzzles)
end

function printresults(puzzles::Array)
    println(join(getresults(puzzles), "\n"))
end

function rawinput(puzzle::Puzzle)
    filename = "day$(lpad(puzzle.day, 2, "0"))/$(puzzle.inputfilename)" 
    !isfile(filename) && return ""

    open(filename) do io
        processinput(read(io, String))
    end
end

function colorize(str, colorcode)
    "\e[$(colorcode)m$(str)\e[0m"
end

function red(str)
    colorize(str, 31)
end

function green(str)
    colorize(str, 32)
end

end