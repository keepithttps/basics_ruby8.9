require_relative 'wagon'
class PassengerWagon < Wagon

  def initialize(number, seats = 36)
    @type = :passenger
    @total_seats = seats.to_i
    super(number)
  end
  SEATS_WAGON = @total_seats.to_i

# метод, который "занимает места" в вагоне (по одному за раз)

  def buy_seats
    @total_seats -= 1
  end

# метод, который возвращает кол-во занятых мест в вагоне

  def seat_sold
    sold = (SEATS_WAGON - @total_seats).abs
  end

# метод, возвращающий кол-во свободных мест в вагоне.

  def available_seats
    @total_seats
  end
end
