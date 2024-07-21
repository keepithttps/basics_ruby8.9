require_relative "modules"

class Station 
  extend  Counter::ClassMethods
  attr_reader :name, :trains
   # формат по типу " ("мск-ыыы") от 3 до 25 букв"
  NAME_FORMAT_STATION = /^[a-яА-Я]{3,25}$/i  
  # NAME_FORMAT_STATION = /^[a-яА-Я]{3,25}(\s|-)[а-яА-Я]{3,25}$/i  

  def self.all 
    @trains
  end
  
  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
  end

  def total_trais
    @trains.size
  end

  def list_train_station
    @trains.each do |tr|
      puts "Номер: #{tr.number}; тип вагона: #{tr.type}."
    end
      puts "Kол-во поездов на станций: #{self.total_trains}"
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_train_on_station(train)
    @trains << train
  end

  protected
  def validate!
    raise "Name can't be nil" if name.nil?
    raise "Name has invalid format" if name !~ NAME_FORMAT_STATION
    true 
  end

  private
  include Counter::InstanceMethods
end
