#ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны, 
#в которой имеется проход шириной в одну клетку.
#РЕЗУЛЬТАТ: Робот - в клетке под проходом

function glavnaia(r::Robot) 
    num_steps=1
    side=Ost
    while isborder(r,Nord)==true
        check_space(r,side,num_steps)
        side=inverse(side)
        num_steps+=1
    end
end

function check_space(r::Robot, side::HorizonSide, num_steps::Int) #двигает робота на num шагов и проверяет наличие прохода сверху
    for _ in 1:num_steps
        move!(r,side)
        if isborder(r,Nord)==false
            break
        end
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4)) # Возвращает направление, противоположное заданному