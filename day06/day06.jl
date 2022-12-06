# day06 of AOC 2022
# cd("./day06")
cd("../day06")
include("../aoc.jl")


input_loc = "day06_input.txt"
# input_loc = "day06_test.txt"
data = import_strings(input_loc)
length(data[1])

string = data[1]

# part 1
# To fix the communication system, you need to add a subroutine to 
# the device that detects a start-of-packet marker in the datastream. 
# In the protocol being used by the Elves, the start of a packet is 
# indicated by a sequence of four characters that are all different.

function find_sop(input)
  sop_location = 0
  for i in 1:(length(input)-3)
    buffer = input[i:i+3]
    if length(unique(buffer)) == 4
      sop_location = i+3
      return sop_location
    end
  end
end

println("The solution to part 1 is: ", find_sop(string))


# part 2
# Your device's communication system is correctly detecting packets,
# but still isn't working. It looks like it also needs to look for 
# messages. A start-of-message marker is just like a start-of-packet 
# marker, except it consists of 14 distinct characters rather than 4.

function find_som(input)
  som_location = 0
  for i in 1:(length(input)-13)
    buffer = input[i:i+13]
    if length(unique(buffer)) == 14
      som_location = i+13
      return som_location
    end
  end
end

println("The solution to part 2 is: ", find_som(string))