# day08 of AOC 2022
# cd("./day08")
cd("../day08")
include("../aoc.jl")

input_loc = "day08_input.txt"
# input_loc = "day08_test.txt"
data = import_strings(input_loc)


tree_heights = transpose(parse.(Int, reduce(hcat, collect.(readlines(input_loc)))))

function visible_up(col)
  for i in 1:size(col)[1]-1
    if col[i] >= col[end]
      return false
    end
  end
  return true
end

function visible_down(col)
  for i in size(col)[1]:-1:2
    if col[i] >= col[1]
      return false
    end
  end
  return true
end

function visible_left(row)
  for i in 1:size(row)[1]-1
    if row[i] >= row[end]
      return false
    end
  end
  return true
end

function visible_right(row)
  for i in size(row)[1]:-1:2
    if row[i] >= row[1]
      return false
    end
  end
  return true
end


function trees_visible(tree_heights)
  visible_df = DataFrame(zeros(Int8, size(tree_heights)[1], size(tree_heights)[2]), :auto)
  visible_df[!,1] .= 1
  visible_df[!,end] .= 1
  visible_df[1,:] .= 1
  visible_df[end,:] .= 1
  for i in 2:size(visible_df)[1]-1
    for j in 2:size(visible_df)[2]-1
      if visible_up(tree_heights[i,1:j]) || visible_down(tree_heights[i,j:end]) || visible_left(tree_heights[1:i,j]) || visible_right(tree_heights[i:end,j])
        visible_df[i,j] = 1
      end
    end
  end
  sum(sum(eachcol(visible_df)))
end


pt1 = trees_visible(tree_heights)
println("The solution to part 1 is: ", pt1)

# part 2
# elves want to see alot of trees
# measure viewing distance from each tree

function view_up(col)
  cnt = 0
  if size(col)[1] == 1
    return cnt
  end
  for i in size(col)[1]-1:-1:1
    if col[i] >= col[end]
      cnt += 1
      return cnt
    else
      cnt += 1
    end
  end
  cnt
end

function view_down(col)
  cnt = 0
  if size(col)[1] == 1
    return cnt
  end
  for i in 2:size(col)[1]
    if col[i] >= col[1]
      cnt += 1
      return cnt
    else
      cnt += 1
    end
  end
  cnt
end

function view_left(row)
  cnt = 0
  if size(row)[1] == 1
    return cnt
  end
  for i in size(row)[1]-1:-1:1
    if row[i] >= row[end]
      cnt += 1
      return cnt
    else
      cnt += 1
    end
  end
  cnt
end

function view_right(row)
  cnt = 0
  if size(row)[1] == 1
    return cnt
  end
  for i in 2:size(row)[1]
    if row[i] >= row[1]
      cnt += 1
      return cnt
    else
      cnt += 1
    end
  end
  cnt
end


function find_scenic_score(tree_heights)
  scenic_score_df = DataFrame(zeros(Int, size(tree_heights)[1], size(tree_heights)[2]), :auto)
  for i in 1:size(tree_heights)[1]
    for j in 1:size(tree_heights)[2]
      scenic_score_df[i,j] = view_up(tree_heights[i,1:j]) * view_down(tree_heights[i,j:end]) * view_left(tree_heights[1:i,j]) * view_right(tree_heights[i:end,j])
    end
  end
  scenic_score_df
end


function find_max(scenic_score_df)
  maxes = []
  for i in 1:size(scenic_score_df)[1]
    push!(maxes, findmax(scenic_score_df[i,:])[1])
  end
  findmax(maxes)[1]
end

scenic_score_df = find_scenic_score(tree_heights)
pt2 = find_max(scenic_score_df)
println("The solution to part 2 is: ", pt2)
