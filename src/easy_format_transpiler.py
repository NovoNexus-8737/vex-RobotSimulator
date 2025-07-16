import re
import os

INPUT_PATH = "src/input"
OUTPUT_PATH = "src/output"

def extract_lines(file_path):
    extracted = []
    with open(os.path.join(INPUT_PATH, file_path), 'r') as file:
        for line in file:
            line = line.strip()
            if line:
                extracted.append(line)
    return extracted

def quick_convert(line):
    match = re.match(r'(\w+)\((.*?)\)', line)
    if not match:
        return None

    func_name, params = match.groups()
    param_names = [p.strip().split()[-1] for p in params.split(',') if p.strip()]
    prefix_map = {
        'pid_drive_set': 'drive',
        'pid_wait': 'waitfor',
        'pid_turn_set': 'turn',
        'pid_wait_until': 'waituntil',
        'slew_drive_set': 'slew_global',
        'slew_drive_constants_set': 'slew',
        
    }
    action = prefix_map.get(func_name, func_name)
    return ','.join([action] + param_names)

os.makedirs(OUTPUT_PATH, exist_ok=True)

all_converted = []

for filename in os.listdir(INPUT_PATH):
    lines = extract_lines(filename)
    for line in lines:
        if '.' in line:
            line = line.split('.', 1)[1]
        result = quick_convert(line)
        if result:
            all_converted.append(result)

    with open(os.path.join(OUTPUT_PATH, filename.split(".")[0]+".txt"), 'w') as out_file:
        out_file.write('\n'.join(all_converted))

