# Log
# Abigail My Tran
# December 3rd, 2016

require './LogItem'
require 'date'
class Log < Hash

  private

  #Log is a hash with:
  #  key: date
  #  value: Array of LogItems(name,times) in that day.
  #                  
  def initialize()
    @log = Hash.new
    f = File.open("DietLog.txt")
    f.each do |line|
      line.chomp!
      if line != ' '
        array = line.split(',')
        date_array = array[0].split('/')
        year = date_array[2].to_i
        day = date_array[1].to_i
        month = date_array[0].to_i
        food_date = Date.new(year, month, day)

        food_name = array[1]

        if (@log.size() == 0 || !@log.has_key?(food_date))
          contain = Array.new
          contain.push( LogItem.new( food_name, 1 ) )
          @log.store(food_date, contain)
        else
          added = "no"
          food_array_at_current_day = @log[food_date]
          for i in 0..(food_array_at_current_day.size-1)
            if (food_array_at_current_day[i].name == food_name)
              new_food_occur = @log[food_date][i].occur + 1
              @log[food_date].delete_at(i)
              @log[food_date].push( LogItem.new( food_name, new_food_occur ) )
              added = "yes"
              break
            end
          end
          if (added == "no")
            @log[food_date].push( LogItem.new( food_name, 1 ) )
          end
        end
      end
    end        
  end
  public
  attr_reader :log

###
# LOG FOOD
###
  def add( food_date = Date.new(), food_name = String.new() )
    if (log.size() == 0 || !log.has_key?(food_date))
      contain = Array.new
      contain.push( LogItem.new( food_name, 1 ) )
      log.store(food_date, contain)
    else
      added = "no"
      food_array_at_current_day = log[food_date]
      for i in 0..(food_array_at_current_day.size-1)
        if (food_array_at_current_day[i].name == food_name)
          new_food_occur = @log[food_date][i].occur + 1
          log[food_date].delete_at(i)
          log[food_date].push( LogItem.new( food_name, new_food_occur ) )
          added = "yes"
          break
        end
      end
      if (added == "no")
        log[food_date].push( LogItem.new( food_name, 1 ) )
      end
    end
  end

###
# SHOW ALL
###
  def show_all()
    if log.size == 0
      puts "The food log is empty"
    else
      dates = log.keys.sort
      print_string = ''
      dates.each do |day|
        log[day].each do |item|
          name = item.name
          time = item.occur
          print_string.insert(0, "  #{name}  (#{time})\n")
        end
      print_string.insert(0, "#{day}: \n")
      end
      puts(print_string)
    end
  end


###
# SHOW
##
  def show(food_date)  
    if (!log.has_key? food_date)
      puts("No data for this day")
    else 
      print_string = "#{food_date}: \n"
      log[food_date].each do |item|
        name = item.name
        time = item.occur
        print_string.insert(-1, "  #{name}  (#{time})\n")
      end
      puts(print_string)
    end
  end

###
# TO LOG
###
  def to_log()
    log_text = ""
    if (log.size == 0)
      return log_text
    else
      log.keys.each do |food_date|
        food_year = food_date.year
	food_month = food_date.mon
	food_day = food_date.mday
	log_date = "#{food_month}/#{food_day}/#{food_year}"
        array = log[food_date]
        array.each do |item|
          food_name = item.name
          food_occur = item.occur
          while (food_occur >0)
            log_text.insert(-1, "#{log_date},#{food_name}\n")
            food_occur -= 1
          end
        end
      end
      return log_text
    end  
  end

###
# SAVE
###

  def save(text)
    File.open("DietLog.txt", 'w') { |file| file.write(text) }
  end


###
# DELETE
###
  def delete(food_date, food_name)
    if (!log.has_key? food_date)
      puts("No data for this day")
    else
      log[food_date].each do |item|
        if (item.name == food_name)
          if (item.occur == 1)
            log[food_date].delete( item )
            break
          else
            new_occur = item.occur - 1
            log[food_date].delete( item )
            log[food_date].push( LogItem.new(food_name,new_occur) )
            break
          end
        end
      end
    end
  end
end
