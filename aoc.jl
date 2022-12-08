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