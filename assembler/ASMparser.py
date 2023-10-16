from mnemonics import mnemonics

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

def get_asm_instruction(line: str):
    return line.split(';', 1)[0].strip()

def convert_9_bits_char(line: str, char: str):
    line = line.split(char)

    line[0] = bin(int(line[0]))[2:].zfill(4)
    line[1] = bin(int(line[1]))[2:].zfill(9)

    result = ''.join(line)
    return result

def translate_to_binary(line: str):
    mnemonic_hex_join_instru = add_mnemonic_hex_to_instruction(line)
    asm_instruction = get_asm_instruction(mnemonic_hex_join_instru)

    if '@' in asm_instruction:
        return convert_9_bits_char(asm_instruction, '@')

    elif '$' in asm_instruction:
        return convert_9_bits_char(asm_instruction, '$')

def format_bin_line(line: str):
    translation_dict = str.maketrans({ 't': '', 'm': '', 'p': '', '(': '', ')': '', '=': '', 'x': '', '"': '' })

    line = line.split('--', 1)
    line[0] = line[0].translate(translation_dict)
    line[1] = line[1].replace(';', '')
    line = '--'.join(line)
    line = line.strip() + '\n'
    return line