#!/usr/bin/env ruby

# Myenumerablemodule
module Enumerable

  def my_each
    return to_enum unless block_given?

    # The to_a() of enumerable is an inbuilt method in Ruby that returns an array containing all the items of the enumerable.
    input_array = to_a
    input_array.length.times { |index| yield(input_array[index]) } 

    self
  end

  def my_each_with_index
    return to_enum(:each_with_index) unless block_given?

    # The to_a() of enumerable is an inbuilt method in Ruby that returns an array containing all the items of the enumerable.
    input_array = to_a
    input_array.length.times { |index| yield(input_array[index], index) } 

    self
  end

  def my_select
    return to_enum(:select) unless block_given?

    input_array = to_a
    output_array = []

    input_array.my_each do |el|
      output_array << el if yield(el)
    end

    if self.kind_of?(Hash) 
      output_array = Hash[output_array.map { |key, value| [key, value]}]
      return output_array
    end
    output_array
  end

  def my_all?(arg = nil)
    input_array = to_a

    if arg != nil
      # if we also have a block warn that we will not use it
      warn "warning: given block not used" if block_given?

      # if the arg is a Regexp
      if arg.is_a?(Regexp)
        input_array.my_each { |element| return false if !element.is_a?(String) || !element.match(arg) }
        return true
      # if the arg is class data type
      elsif arg.is_a?(Class)
        input_array.my_each { |element| return false if !element.is_a?(arg) }
        return true
      else
        input_array.my_each { |element| return false if element != arg }
        return true
      end

    # if no argument and no block given
    elsif !block_given?
      input_array.my_each { |element| return false if element == nil || element == false }
      return true
    
    else
      input_array.my_each { |element| return false unless yield(element) }
    end

    true
  end

  def my_any?(arg = nil)
    input_array = to_a

    if arg != nil
      # if we also have a block warn that we will not use it
      warn "warning: given block not used" if block_given?

      # if the arg is a Regexp
      if arg.is_a?(Regexp)
        input_array.my_each { |element| return true if element.is_a?(String) && element.match(arg) }
        return false
      # if the arg is class data type
      elsif arg.is_a?(Class)
        input_array.my_each { |element| return true if element.is_a?(arg) }
        return false
      else
        input_array.my_each { |element| return true if element == arg }
        return false
      end

    # if no argument and no block given
    elsif !block_given?
      input_array.my_each { |element| return true if element != nil && element != false }
      return false 
    else
      input_array.my_each { |element| return true if yield(element) }
    end

    false
  end

  def my_none?(arg = nil)
    input_array = to_a

    if arg != nil
      # if we also have a block warn that we will not use it
      warn "warning: given block not used" if block_given?

      # if the arg is a Regexp
      if arg.is_a?(Regexp)
        input_array.my_each { |element| return false if element.is_a?(String) && element.match(arg) }
        return true
      # if the arg is class data type
      elsif arg.is_a?(Class)
        input_array.my_each { |element| return false if element.is_a?(arg) }
        return true
      else
        input_array.my_each { |element| return false if element == arg }
        return true
      end

    # if no argument and no block given
    elsif !block_given?
      input_array.my_each { |element| return false if element != nil && element != false }
      return true 
    else
      input_array.my_each { |element| return false if yield(element) }
    end

    true
  end

  def my_count(arg = nil)
    input_array = to_a
    count = 0

    if arg != nil
      # if we also have a block warn that we will not use it
      warn "warning: given block not used" if block_given?
      input_array.my_each { |element| count += 1 if element == arg }

    # if no argument and no block given
    elsif !block_given?
      input_array.my_each { |element| count += 1 }
    else
      input_array.my_each { |element| count += 1 if yield(element) }
    end

    count
  end

  def my_map(&change_proc)
    return to_enum(:map) unless block_given?

    # The to_a() of enumerable is an inbuilt method in Ruby that returns an array containing all the items of the enumerable.
    input_array = to_a
    output_array = []

    input_array.my_each { |element| output_array << yield(element) } 

    output_array
  end

  def my_inject(*arg)
    # get the array
    array = to_a
    raise ArgumentError.new "wrong number of arguments (given #{arg.length}, expected 0..2)" if arg.length > 2
    raise LocalJumpError.new "no block given" if arg.length == 0 && !block_given?

    # 2 arguments without/with a block, we don`t mind the block
    if arg.length == 2
      raise TypeError.new "#{arg.last} is not a symbol nor a string" if !arg.last.is_a?(Symbol) || !arg.last.is_a?(String)
    
      # set the result to first argument
      result = arg.first
      method = arg.last
      # start looping the array and send the method on curent result with curent element
      array.my_each { |next_element| result = result.send(method, next_element)}

      return result
    # 1 argument (it should be a method)
    elsif arg.length == 1 && !block_given?
      raise TypeError.new "#{arg.first} is not a symbol nor a string" if !arg.first.is_a?(Symbol) && !arg.first.is_a?(String)
      # set the result to be the first item of the array
      result = array.first
      method = arg.first
      # start looping the array and yield the block/method on curent result with curent element
      array.my_each_with_index do |next_element, index|
        next if index == 0
        result = result.send(method, next_element)
      end

      return result
    # 1 argument(default value) with a block 
    elsif arg.length == 1 && block_given?
      # set the result to be the parameter
      result = arg.first
      # start looping each the array and yield the block
      array.my_each { |next_element| result = yield(result, next_element) }
      return result
    else
      result = array.first

      array.my_each_with_index do |next_element, index|
        next if index == 0
        result = yield(result, next_element)
      end

      result
    end

  end
  
end

def multiply_els(array)
  raise ArgumentError.new "Only arrays with Numeric elements accepted" unless array.my_all?(Numeric)

  array.my_inject(:*)
end

# my_map_proc = Proc.new { |c| c.first + c.last }

p [[1, 2], [3, 5]].my_map() { |c| c.first + c.last } # => true

# p [[1, 2], [3, 5]].my_inject { |c, n| c.first + n.last } # => true
# p %w[Marc Luc Jean].my_inject # => false
# p [2, 1, 6, 7, 4, 8, 10].map {|e| 3} # => false
# p %w[Marc Luc Jean].my_map('Jean') # => false
# p %w[Marc Luc Jean].my_map(/a/) # => false
# p [1, 5i, 5.67].my_count {|e| e.is_a?(Integer)} # => true
# p [2, 1, 6, 7, 4, 8, 10].my_count {|e| e.is_a?(Numeric)} # => true
# p [nil, true, 99].count(true) {|el| el}# => false
# p [nil, false].my_map {|el| el != nil}# => false
# p [nil, nil, nil].my_map {|el| el != nil}# => false
# p [].my_map {|el| el != nil}# => true

# p ["x", "y", 0].all?
# p [RegClass].all?(Class)

# p (1...10).my_all? { |el| el > 3 }
# p (1...10).all? { |el| el > 3 }

# p 9.times.my_all? { |el| el > 3 }
# p 9.times.all? { |el| el > 3 }

# p 19.downto(5).my_all? { |el| el > 4 }
# p 19.downto(5).all? { |el| el > 4 }

# test_hash = {
#   "x": 1,
#   "Y": 2,
#   "z": 3,
#   "i": 2,
# }
# p test_hash.my_all?
# p test_hash.all?
# p 3.my_all? { |el| el > 10 }
# p 3.all? { |el| el > 10 }
p "Hello world!"
# result = gets.chomp
