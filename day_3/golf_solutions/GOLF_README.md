## Day 3 Golf Solutions
- part 1 size: 80 bytes
- part 2 size: 105 bytes
- combined solution size: 123 bytes (If combined allowed)

### Notes
- Input file name changed to 'i' to save space
- Running either solution from the command line outputs the answer if ran via irb
- Rough drafts dir shows refinement process
- If evaluating "$(cat i)" as I pass it in as a param is not allowed, add 2 bytes to any solution byte size to account for subbing $*[0] with 'cat i'
```ruby
irb part_1_golf.rb "$(cat i)" # Expected output: 17383
irb part_2_golf.rb "$(cat i)" # Expected output: 172601598658203

# If combined soliution is allowed
irb part_1_and_2_combined_golf.rb "$(cat i)" # Expected output: [17383, 172601598658203]
```