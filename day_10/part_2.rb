parsed_input = ARGV[0].scan(/(\[[^\]]+\])((?:\s+\([^)]+\))+)\s+(\{[^\}]+\})/)
instructions = []

parsed_input.each do |i|
  final_counter =  i[2][1..-2].split(",").map(&:to_i)
  buttons_base_10 = i[1].scan(/\(([^)]*)\)/).map{_1.first.split(",").map(&:to_i)}
  buttons_binary = []

  buttons_base_10.each do |buttton|
    binary_string = ''
    final_counter.size.times{|i| binary_string << (buttton.include?(i) ? "1" : "0")}
    buttons_binary << binary_string.to_i(2)
  end

  instructions << { :final_counter => final_counter, :buttons => buttons_binary }
end

def minimum_button_presses_recursive(instruction, current_counts)
  solved_state = instruction[:final_counter]
  instruction[:buttons].each do |bit_val|
    bit_changes = current_counts.dup
    solved_state.size.times do |j|
      bit_changes[j] += (bit_val >> (solved_state.size - 1 - j)) & 1
      if bit_changes == solved_state
        return bit_val
      elsif bit_changes.sum <= solved_state.sum
        return minimum_button_presses_recursive(instruction, bit_changes)
      end
    end
  end
  false
end

def minimum_button_presses(instruction)
  solved_state = instruction[:final_counter]
  buttons = instruction[:buttons]
  n = solved_state.size

  initial = Array.new(n, 0)
  combinations = [[initial, 0]]
  seen = { initial.join(",") => true }

  until combinations.empty?
    state, presses = combinations.shift
    return presses if state == solved_state

    buttons.each do |btn|
      new_state = state.each_with_index.map { |v, i| v + ((btn >> (n-1-i)) & 1) }
      next if new_state.zip(solved_state).any? { |a, b| a > b }
      key = new_state.join(",")
      next if seen[key]
      seen[key] = true
      combinations << [new_state, presses + 1]
    end
  end
  nil # No solution found
end


def minimum_button_presses_newY(instruction)
  solved_state = instruction[:final_counter]
  buttons = instruction[:buttons]
  n = solved_state.size

  initial = Array.new(n, 0)
  combinations = [[initial, 0]]
  seen = Set.new([initial.join(",")])

  states_explored = 0
  log_interval = 10000  # Log every 10k states

  until combinations.empty?
    state, presses = combinations.shift
    states_explored += 1

    # Log progress periodically
    if states_explored % log_interval == 0
      distance = state.zip(solved_state).map { |a, b| b - a }.sum
      puts "  Explored: #{states_explored} | Queue: #{combinations.size} | Depth: #{presses} | Distance: #{distance} | Current: #{state.inspect}"
    end

    return presses if state == solved_state

    buttons.each do |btn|
      new_state = state.each_with_index.map { |v, i| v + ((btn >> (n-1-i)) & 1) }
      next if new_state.zip(solved_state).any? { |a, b| a > b }
      key = new_state.join(",")
      next if seen.include?(key)
      seen.add(key)
      combinations << [new_state, presses + 1]
    end
  end
  nil # No solution found
end
def minimum_button_presses_new(instruction)
  solved_state = instruction[:final_counter]
  buttons = instruction[:buttons]
  n = solved_state.size

  initial = Array.new(n, 0)
  combinations = [[initial, 0]]
  seen = Set.new([initial.join(",")])

  until combinations.empty?
    state, presses = combinations.shift
    return presses if state == solved_state

    buttons.each do |btn|
      new_state = state.each_with_index.map { |v, i| v + ((btn >> (n-1-i)) & 1) }
      next if new_state.zip(solved_state).any? { |a, b| a > b }
      key = new_state.join(",")
      next if seen.include?(key)
      seen.add(key)
      combinations << [new_state, presses + 1]
    end
  end
  nil # No solution found
end

def minimum_button_presses_optimized(instruction)
  solved_state = instruction[:final_counter]
  buttons = instruction[:buttons]
  n = solved_state.size
  target_sum = solved_state.sum

  initial = Array.new(n, 0)
  combinations = [[initial, 0]]
  seen = Set.new([initial.join(",")])

  until combinations.empty?
    state, presses = combinations.shift
    return presses if state == solved_state

    buttons.each do |btn|
      new_state = state.each_with_index.map { |v, i| v + ((btn >> (n-1-i)) & 1) }
      next if new_state.zip(solved_state).any? { |a, b| a > b }
      next if new_state.sum > target_sum  # Prune if sum exceeds target
      key = new_state.join(",")
      next if seen.include?(key)
      seen.add(key)
      combinations << [new_state, presses + 1]
    end
  end
  nil # No solution found
end


def minimum_button_presses_greedy(instruction)
  solved_state = instruction[:final_counter]
  buttons = instruction[:buttons]
  n = solved_state.size

  initial = Array.new(n, 0)
  # Use a priority queue: [priority, state, presses]
  # Priority = distance to goal (lower is better)
  combinations = [[0, initial, 0]]
  seen = Set.new([initial.join(",")])

  states_explored = 0
  log_interval = 10000  # Log every 10k states

  until combinations.empty?
    # Sort by priority (distance to goal) - greedy approach
    combinations.sort_by! { |priority, _, _| priority }
    priority, state, presses = combinations.shift
    states_explored += 1

    # Log progress periodically
    if states_explored % log_interval == 0
      distance = state.zip(solved_state).map { |a, b| b - a }.sum
      puts "  Explored: #{states_explored} | Queue: #{combinations.size} | Depth: #{presses} | Distance: #{distance} | Current: #{state.inspect}"
    end

    return presses if state == solved_state

    buttons.each do |btn|
      new_state = state.each_with_index.map { |v, i| v + ((btn >> (n-1-i)) & 1) }
      next if new_state.zip(solved_state).any? { |a, b| a > b }
      key = new_state.join(",")
      next if seen.include?(key)
      seen.add(key)

      # Calculate priority: distance to goal (sum of remaining increments needed)
      new_priority = new_state.zip(solved_state).map { |a, b| b - a }.sum
      combinations << [new_priority, new_state, presses + 1]
    end
  end
  nil # No solution found
end

sum = 0
instructions.each do |instruction|
  puts "Solving #{instruction}"
  result = minimum_button_presses_optimized(instruction)
  puts "Solved: #{result}"
  sum += result
end

sum
