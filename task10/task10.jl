#ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров
#РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток

function stemp(r::Robot, side::HorizonSide) #возврат значения суммы температур всех клеток в направлении
    stemp=0
    while isborder(r,side)==false
        stemp+=check_temp(r)
        move!(r,side)
    end
    stemp+=check_temp(r)
    return stemp
end

s=0
function glavnaia(r::Robot) 
    global s=0
    overal_temp=0
    side=Ost
    while isborder(r,Nord)==false
        overal_temp+=stemp(r,side)
        move!(r,Nord)
        side=inverse(side)
    end
    overal_temp+=stemp(r,side)
    average_temp=overal_temp/s
    return average_temp
end

function check_temp(r::Robot)
    global s
    if ismarker(r)==true
        s+=1
        return temperature(r)
    else
        return 0
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4)) 