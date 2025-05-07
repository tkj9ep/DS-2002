import json

# Step 1: Load the JSON data
with open('adventureworks_fact_table.json', 'r') as f:
    data = json.load(f)

# Step 2: Split the data into 3 roughly equal parts
n = len(data)
split_size = n // 3

part1 = data[:split_size]
part2 = data[split_size:2*split_size]
part3 = data[2*split_size:]

# Step 3: Write each part to a new JSON file
with open('adventureworks_fact_table_01.json', 'w') as f1:
    json.dump(part1, f1, indent=4)

with open('adventureworks_fact_table_02.json', 'w') as f2:
    json.dump(part2, f2, indent=4)

with open('adventureworks_fact_table_03.json', 'w') as f3:
    json.dump(part3, f3, indent=4)

print("Split into output_part1.json, output_part2.json, output_part3.json")
