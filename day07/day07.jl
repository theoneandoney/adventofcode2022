# day07 of AOC 2022
cd("../day07")
# cd("./day07")
include("../aoc.jl")


# input_loc = "day07_input.txt"
input_loc = "day07_test.txt"

data = import_strings(input_loc)



# part 1
# Need to build a map of the filesystem given the input, determine 
# the total size of each directory, then sum the total size of all
# directories greater than 100,000
struct File
  name::String
  size::Int
  parent::String
end

struct Directory
  name::String
  size::Int
  subdirs::Array{String, 1}
  files::Array{String, 1}
  parent::String
end




test = data[2]


dirs = [Directory("/", 0, [], [])]

current_dir = dirs[1]
# current_loc = 1

if test[1] == '$'
  # new command
  cmd = test[3:end]
  if cmd[1:3] == "cd "
    # change directory
    dir = cmd[4:end]
    if dir == ".."
      # go up one directory
      current_loc = current_dir.parent
      current_dir = dirs[current_loc]
    else
      # go down one directory
      for i in 1:length(current_dir.subdirs)
        if current_dir.subdirs[i].name == dir
          current_loc = i
          current_dir = current_dir.subdirs[i]
          break
        end
      end
    end
  # elseif cmd[1:3] == "ls "

  end

else
  # still printing
  

end

dir
cmd





function parse_line(line)
end

line = data[3]


if line[1:3] == "dir"
  # new directory
  dir = line[5:end]
  # add to current directory
  push!(current_dir.subdirs, Directory(dir, 0, [], []))
  # add to list of directories
  push!(dirs, Directory(dir, 0, [], []))
else
  # new file
  size, name = split(line, " ")
  # add to current directory
  push!(current_dir.files, File(name, parse(Int, size), []))
end