#ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
#РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки

function glavnaia(r::Robot) # - главная функция  
    for side in (Nord,West,Sud,Ost) # - перебор всех возможных направлений
        putmarkers!(r,side)
        move_markers(r,inverse(side))
    end
    putmarker!(r)
end

#Cтавит маркеры до перегородки, но в исходной клетке маркера нет
putmarkers!(r::Robot,side::HorizonSide) = 
    while isborder(r,side)==false 
        move!(r,side)
        putmarker!(r)
    end

# Перемещает в заданном направлении, пока он в клетке с маркером (в итоге робот окажется в клетке без маркера)
move_markers(r::Robot,side::HorizonSide) = 
    while ismarker(r)==true 
        move!(r,side) 
    end

# Возвращает направление, противоположное заданному
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

