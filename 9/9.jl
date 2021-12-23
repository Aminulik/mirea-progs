#ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. 
#Робот - в произвольной клетке поля.
#РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.

function glavnaia(r::Robot)
    num_steps=1
    side=Nord
    while ismarker(r)==false
        for _ in 1:2
            check_mark(r,side,num_steps)
            side=next(side)
        end
        num_steps+=1
    end
end

function check_mark(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
        if ismarker(r)==true
            break
        end
    end
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4)) 