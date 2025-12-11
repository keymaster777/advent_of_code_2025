MACHINES = ARGV[0].lines.map{_1.chomp.split(": ")}.map{[_1[0], _1[1].split]}.to_h

def find_paths_recursive(input_machine, path = [])
  current_path = path + [input_machine]
  output_machines = MACHINES[input_machine]

  return [current_path + output_machines] if output_machines == ["out"]
  [].tap do |all_paths|
    output_machines.each do |output_machine|
      all_paths.concat(find_paths_recursive(output_machine, current_path))
    end
  end
end

find_paths_recursive("you").size
