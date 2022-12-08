testdir = dirs
testdir

push!(testdir, PathNode("test", 0, [], [], "/"))
push!(testdir, PathNode("test2", 0, [], [], "test"))


testdir[3]
testdir[testdir.name == "test"]


filter(x -> x.name == "test", testdir)

## winner winner chicken dinner
findall(x -> x.name == "test2", testdir)[1]






