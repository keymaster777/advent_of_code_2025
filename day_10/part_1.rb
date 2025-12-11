parsed_input = ARGV[0].scan(/(\[[^\]]+\])((?:\s+\([^)]+\))+)\s+(\{[^\}]+\})/)
instructions = []

parsed_input.each do |i|
  final_state =  i[0][1..-2].gsub(".", "0").gsub("#", "1")
  buttons_base_10 = i[1].scan(/\(([^)]*)\)/).map{_1.first.split(",").map(&:to_i)}
  buttons_binary = []

  buttons_base_10.each do |buttton|
    binary_string = ''
    final_state.size.times{|i| binary_string << (buttton.include?(i) ? "1" : "0")}
    buttons_binary << binary_string.to_i(2)
  end

  instructions << { :final_state => final_state.to_i(2), :buttons => buttons_binary }
end

#p instructions
def minimum_button_presses(instruction)
  solved_state = instruction[:final_state]
  buttons = instruction[:buttons]

  i=1;loop do
    combinations = buttons.combination(i).to_a
    shortest = combinations.find{_1.reduce(:^) == solved_state}
    return shortest if shortest
    i += 1
  end
end

instructions.sum{|instruction| minimum_button_presses(instruction).size}