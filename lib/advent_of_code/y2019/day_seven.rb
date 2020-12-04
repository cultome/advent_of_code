require 'advent_of_code/y2019/calculator'

include Calculator

def first
  max_output = 0

  [0,1,2,3,4].permutation.each do |nums|
    out = 0

    nums.each do |phase|
      pgr_tmp = input.clone
      @input_buffer = [phase, out]

      state = execute_intcode(pgr_tmp, version: 2, read_from: :read_buffer)
      out = state[:last_output]
    end

    max_output = out if out >= max_output
  end

  max_output
end

def second
    max_output = 0

    [5,6,7,8,9].permutation.each do |n1, n2, n3, n4, n5|
      initial_state = {version: 3, read_from: :read_buffer}
      first = true

      pgr1 = input.clone
      st1 = initial_state.clone

      pgr2 = input.clone
      st2 = initial_state.clone

      pgr3 = input.clone
      st3 = initial_state.clone

      pgr4 = input.clone
      st4 = initial_state.clone

      pgr5 = input.clone
      st5 = initial_state.clone

      @input_buffer = [n1, 0]

      loop do
        st1 = execute_intcode(pgr1, **st1)
        @input_buffer.push st1[:last_output]

        @input_buffer.unshift(n2) if first
        st2 = execute_intcode(pgr2, **st2)
        @input_buffer.push st2[:last_output]

        @input_buffer.unshift(n3) if first
        st3 = execute_intcode(pgr3, **st3)
        @input_buffer.push st3[:last_output]

        @input_buffer.unshift(n4) if first
        st4 = execute_intcode(pgr4, **st4)
        @input_buffer.push st4[:last_output]

        @input_buffer.unshift(n5) if first
        st5 = execute_intcode(pgr5, **st5)
        @input_buffer.push st5[:last_output]

        first = false
        break if st5[:terminated]
      end

      max_output = @input_buffer.first if @input_buffer.first > max_output
    end

    max_output
end

def input
  @input ||= File.read('inputs/y2019/day_seven.txt').chomp.split(",").map(&:to_i)
end
