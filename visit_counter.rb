# Path to the file where the visit count is stored
counter_file = 'visit_count.txt'

# Check if the counter file exists, otherwise initialize it
if File.exist?(counter_file)
  count = File.read(counter_file).to_i
else
  count = 0
end

# Increment the visit count
count += 1

# Save the updated count back to the file
File.write(counter_file, count)

# Display the current number of visits
puts "Number of visits: #{count}"
