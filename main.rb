require_relative "passenger_train"
require_relative "cargo_train"
require_relative "station"
require_relative "route"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"
require_relative "modules"


@trains   = {}
@stations = {}
@routes   = {}

def prompt(msg)
  puts msg 
  print "=> "
  gets.chomp 
end


def create_train
  item = 0
  begin
    # number = prompt("Введите номер поезда по типу (айя-12345)")
    number = "ыыы-12345"
    # type = prompt("Укажите цифру типа поезда (1 - пассажирский, 2 - грузовой)")
    type = "1"

    train = case type
    when "1" then PassengerTrain.new(number)
    when "2" then CargoTrain.new(number)
    end

    @trains[number] = train
    puts "Поезд создан! #{train}"
  rescue StandardError => e
    puts e.message
    item += 1
    retry if item < 3
    abort "Превышено количество попыток ввода "
  end
end


def create_station
  name = prompt("Введите название станции по типу (ыыы)")
  station = Station.new(name)
  @stations[name] = station
end

def create_route
  name = prompt("Введите название маршрута")
  route = Route.new(name)
  @routes[name] = route
end

def add_station
  route_name = prompt("Введите название маршрут")
  station_name = prompt("Введите название станции по типу (ыыы)")
  route   = @routes[route_name]
  station = @stations[station_name]
  route.add_station(station)
end

def delete_station
  route_name = prompt("Введите название маршрут")
  station_name = prompt("Введите название станции по типу (ыыы)")
  route   = @routes[route_name]
  station = @stations[station_name]
  route.delete_station(station)
end

 # Номер вагона можно назначать автоматически
@n = 0
def number_block
  number = proc { @n += 1 }
  num = number.call.to_s
  return '%08d' % num
end

def add_wagon
  # train_name   = prompt("Введите название поезда")
  train_name = "ыыы-12345"
  train = @trains[train_name]
  # number_wagon = prompt("Введите номер вагона")
  number_wagon = number_block
  type_wagon   = prompt("Введите тип вагон - (1 - pessenger, 2 - cargo)")
  
  wagon = if type_wagon == "1"
    seats_wagon = prompt("Введите колличество мест пустого вагона")
    print "#{number_wagon}: #{seats_wagon}: #{train}"
    PassengerWagon.new(number_wagon, seats_wagon)
  elsif type_wagon == "2"
    volume_wagon = prompt("Введите Обьём пустого вагона")
    CargoWagon.new(number_wagon, volume_wagon)
  end
  puts "wagon = #{wagon}"
  train.add_wagon(wagon)
end

def delete_wagon
  train_name   = prompt("Введите название поезда")
  number_wagon = prompt("Введите номер вагона")
  train = @trains[train_name]
  train.delete_wagon(number_wagon)
end

def assign_route
  route_name = prompt("Введите название маршрут")
  train_name = prompt("Введите название поезда")
  train   = @trains[train_name]
  route   = @routes[route_name]
  train.add_route(route)
end

def go_forward
  train_name   = prompt("Введите название поезда")
  train   = @trains[train_name]
  train.go_next_station
end

def go_back
  train_name   = prompt("Введите название поезда")
  train   = @trains[train_name]
  train.go_previous_station
end

def list_station
  puts @stations.keys
end

# 12. Посмотреть список поездов на станции
def show_trains
  station_name = prompt("Введите название станции по типу (мск-ыыы)")
  station = @stations[station_name]
  station.list_train_station
end

# 13. Выводить список вагонов у поезда
def list_wagons
  @trains.each { |k, v| puts " #{k}: #{v.type}"}
  name = prompt("Введите название поезда")
  train = @trains[name]

  train.list_wagons_train
  # puts "№: #{train.number}. тип: #{train.type}. кол-во вагонов: #{train.wagons.size}"
end

# 14. Занять место в пассажирском вагоне
def buy_ticket_seats
   @trains.each { |k, v| puts " #{k}: #{v.type}"}
  name = prompt("Введите название поезда :passenger")

  if @trains[name].type == :passenger  # :cargo
    train = @trains[name] 
    train.list_wagons_train
    puts "#{train.wagons[1].type}"
    puts "#{train.wagons[0].buy_seats}"
    puts "#{train.wagons[0].seat_sold}"
    puts "1123"
    puts "#{train.wagons}"
  else
    abort 'Введён не правельный тип вагона'
  end
end

loop do
  input = prompt(
    "1.  Зарегистрировать поезд\n" \
    "2.  Зарегистрировать станцию\n" \
    "3.  Создать маршрут\n" \
    "---\n" \
    "4.  Добавить станцию в маршрут\n" \
    "5.  Убрать станцию из маршрута\n" \
    "---\n" \
    "6.  Прицепить вагон\n" \
    "7.  Отцепить вагон\n" \
    "---\n" \
    "8.  Назначить маршрут поезду\n" \
    "9.  Отправить поезд вперёд по маршруту\n" \
    "10. Отправить поезд назад по маршруту\n" \
    "---\n" \
    "11. Посмотреть список станций\n" \
    "12. Посмотреть список поездов на станции\n" \
    "---\n" \
    "13. Вывести список вагонов у поезда\n"\
    "14. Занять место в пассажирском вагоне\n"\
    "15. За грузить грузовой вагон\n"\
    "---\n" \
    "17. Закрыть программу" 
  )
  case input
  when "1"
    create_train
  when "2"
    create_station
    puts @stations
  when "3"
    create_route
    puts @routes
  when "4"
    add_station
  when "5"
    delete_station
  when "6"
    add_wagon
  when "7"
    delete_wagon
  when  "8"
    assign_route
  when "9"
    go_forward
  when "10"
    go_back
  when "11"
    list_station
  when "12"
    show_trains
  when "13"
    list_wagons
  when "14"
    buy_ticket_seats
  when "17"
    break
  else
    puts "Пока в разработке"
  end
end
