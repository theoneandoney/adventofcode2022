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

import Pkg
Pkg.activate(".", io = devnull)


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

processinput(data) = data

function import_strings(input_loc)
    # import the input as a vector of strings
    open(input_loc) do f
        input = readlines(f)
    end
end

# function import_df(input_loc)
#     # import the input as a dataframe
#     df = CSV.read(input_loc, delim = " ", header = false, DataFrame)
# end
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



