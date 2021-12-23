#Подсчитать число прямоугольных перегородок (отрезков нет)

function ugol(r,side1,side2) #функция ведет робота в угол side1 side2
    while !isborder(r,side1) || !isborder(r,side2)
        if !isborder(r,side1)
            move!(r,side1)
        else
            move!(r,side2)
        end
    end
end

function back(r, side)#функция возвращает робота в начало строки в side
    c = 1
    while c != 0
        if !isborder(r, side)
            move!(r, side)
        else
            c = obhod(r,side)
            if c == 0
                break
            end
        end
    end
end

function reverse(side)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+2, 4))
        end
    end
end

function next_side(side)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+3,4))
        end
    end
end

function obhod(r,side)#функция обходит перегородки чтобы идти по прямой
    k = 0
    while (isborder(r,side) && !isborder(r,next_side(side)))
        move!(r,next_side(side))
        k += 1
    end
    if isborder(r,next_side(side))&&isborder(r,side)
        for i in 1:k
            move!(r,reverse(next_side(side)))
        end
        return 0
    end
    if !isborder(r,side)
        move!(r,side)
    end
    if k != 0
        while isborder(r,reverse(next_side(side)))
            move!(r,side)
        end
        for i in 1:k
            move!(r,reverse(next_side(side)))
        end
    end
    return 1
end

function num_pr(r)
    ugol(r, West, Sud)
    n = 0 
    flag = 1
    while !isborder(r, Nord)
        c = 1
        while c != 0
            if !isborder(r, Ost)
                move!(r, Ost)
                if(flag == 0 && isborder(r, Nord))
                    flag = 1
                    n += 1
                elseif(flag == 1 && !isborder(r, Nord))
                    flag = 0
                end
            else
                c = obhod(r,Ost)
                if c == 0
                    break
                end
            end
        end
        move!(r, Nord)
        back(r,West)
    end
print(n)
end