from mnemonics import mnemonics

def get_label_address(label: str, labels: dict):
    return labels[label]

def get_asm_label(line: str):
    return line.split(':', 1)[0].strip()

def find_labels(lines: list):
    labels = dict()
    empty_lines = 0
    label_counter = 0
    for counter, line in enumerate(lines):
        line = line.strip()

        if not line:
            empty_lines += 1
            continue

        if ':' in line:
            label_counter += 1
            label = get_asm_label(line)
            labels[label] = counter + 1 - empty_lines - label_counter

    return labels

def get_asm_instruction(line: str):
    return line.split(';', 1)[0].strip()

def get_asm_comment(line: str):
    if ';' in line:
        asm_code, comment = line.split(';', 1)
        line = f'{asm_code}\t;{comment}'

    return line

def add_mnemonic_hex_to_instruction(line: str):
    line = line.strip().split(' ')

    if line[0] in mnemonics:
        line[0] = mnemonics[line[0]]
    
    result = ''.join(line)
    return result

def convert_9_bits_char(line: str, char: str, labels: dict = None):
    line = line.split(char)

    line[0] = bin(int(line[0]))[2:].zfill(4)
    if not line[1].isnumeric():
        try:
            line[1] = bin(get_label_address(line[1], labels))[2:].zfill(9)
        except:
            raise NameError(f'Label "{line[1]}" is not defined.')
    else:
        line[1] = bin(int(line[1]))[2:].zfill(9)

    result = ''.join(line)
    return result

def translate_to_binary(line: str, labels: dict = None):
    if 'RET' in line or 'AND' in line or 'NOP' in line:
        mnemonic_hex_join_instru = add_mnemonic_hex_to_instruction(line)
        asm_instruction = get_asm_instruction(mnemonic_hex_join_instru)
        return asm_instruction.ljust(13, '0')

    mnemonic_hex_join_instru = add_mnemonic_hex_to_instruction(line)
    asm_instruction = get_asm_instruction(mnemonic_hex_join_instru)

    if '@' in asm_instruction:
        return convert_9_bits_char(asm_instruction, '@')

    elif '$' in asm_instruction:
        return convert_9_bits_char(asm_instruction, '$')

    elif '.' in asm_instruction:
        return convert_9_bits_char(asm_instruction, '.', labels)
    

def format_bin_line(line: str):
    translation_dict = str.maketrans({ 't': '', 'm': '', 'p': '', '(': '', ')': '', '=': '', 'x': '', '"': '' })

    line = line.split('--', 1)
    line[0] = line[0].translate(translation_dict)
    line[1] = line[1].replace(';', '')
    line = '--'.join(line)
    line = line.strip() + '\n'
    return line