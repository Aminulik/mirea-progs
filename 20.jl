function countPartition!(r::Robot)
    backpath = BackPath(r, (Sud, West))
    print(counterPartition!(r))
    BackPath(r, (Sud, West))
    back!(r, backpath)
end

function BackPath(robot, sides::NTuple{2,HorizonSide}=(Sud, Ost))
    local path=[]
    while !isborder(robot, sides[1]) || !isborder(robot, sides[2])
        for s in sides 
            push!(path, movesAndCounting!(robot, s))
        end
    end
    new(reverse(map(side -> reversSide(side), sides)), reverse(path))
end
function reversSide(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(deepcopy(side))+2)%4)
end

function counterPartition!(r::Robot, side_to_move::HorizonSide = Ost)
    counter = 0
    while !isborder(r, nextSideConterclockwise(side_to_move))
        while tryToMove!(r, side_to_move)
            if isborder(r, nextSideConterclockwise(side_to_move))
                movesAlong!(r, side_to_move, nextSideConterclockwise(side_to_move))
                counter+=1
            end
        end
        while tryToMove!(r, reversSide(side_to_move)) end
        move!(r, nextSideConterclockwise(side_to_move))
    end
    return counter
end

function back!(robot, backpath)
    i=1
    for n in backpath.path
        moves!(robot, backpath.sides[i], n)
        i = i%2 + 1
    end
end
function movesAndCounting!(r, side::HorizonSide)::Integer
    count = 0
    while !isborder(r, side)
        move!(r, side)
        count+=1
    end
    return count
end