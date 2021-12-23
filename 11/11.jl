#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля,
#на котором могут находиться также внутренние прямоугольные перегородки 
#(все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

#РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту,
#а две - ту же долготу, что и Робот, стоят маркеры.

function glavnaia(r::Robot)
    num=0
    act=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(act,moves!(r,West))
        push!(act,moves!(r,Sud))
        num+=2
    end
    x=0
    y=0
    for i in 1:num
        if isodd(i)==true
            y+=act[i]
        else
            x+=act[i]
        end
    end
    side=Nord
    for _ in 1:2
        x=mkord(r,side,x)
        side=next(side)
        y=mkord(r,side,y)
        side=next(side)
    end
    while (num>0)==true
        side=isodd(num) ? Ost : Nord
        msteps(r,side,act[num])
        num-=1
    end
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function mkord(r::Robot, side::HorizonSide, num_steps::Int)
    msteps(r,side,num_steps)
    putmarker!(r)
    num_steps=moves!(r,side)
    return num_steps
end

function msteps(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))