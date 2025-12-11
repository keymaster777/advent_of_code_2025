MACHINES = $*[0].scan(/(\w+): (.+)/).to_h
POI = ["svr", "dac", "fft", "out"] # Points of interest
VISITED = {}
def find_paths_recursive(input_machine, target)
  key = [input_machine, target]
  return VISITED[key] if VISITED.key?(key)
  return VISITED[key] = 1 if input_machine == target
  output_machines = MACHINES[input_machine].split

  VISITED[key] = output_machines.sum do |output_machine|
    next 0 if (POI-[input_machine, target]).include?(output_machine)
    find_paths_recursive(output_machine, target)
  end
end

fft_dac_solution = [["svr","fft"], ["fft","dac"], ["dac","out"]].map{find_paths_recursive(_1,_2)}.inject(:*)
dac_fft_solution = [["svr","dac"], ["dac","fft"], ["fft","out"]].map{find_paths_recursive(_1,_2)}.inject(:*)

[fft_dac_solution, dac_fft_solution].max