#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться 
#также внутренние прямоугольные перегородки
#(все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)
#РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры

function glavnaia(r::Robot)  
    num=0
    actions=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(actions,moves!(r,West)) 
        push!(actions,moves!(r,Sud))
        num+=2
    end
    side=Nord
    for _ in 1:4
        moves!(r,side)
        putmarker!(r)
        side=next(side)
    end
    while (num>0)==true
        side=isodd(num) ? Ost : Nord #trueOst if mod 2 != 0
        for _ in 1:actions[num]
            move!(r,side)
        end
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
next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))