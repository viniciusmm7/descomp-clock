from ASMparser import *
from os import path
from shutil import copy

ASM = 'ROM.asm'
BIN = 'BIN.vhd'
MIF = 'initROM.mif'
PROJECT_PATH = '../src/'

def convert_to_VHDL():
    with open(ASM, 'r') as asm_file, open(BIN, 'w+') as bin_file:
        lines = asm_file.readlines()
        labels = find_labels(lines)

        empty_lines = 0
        label_counter = 0

        for counter, line in enumerate(lines):
            line = line.strip()

            comment = get_asm_comment(line)

            if not line:
                empty_lines += 1
                continue

            if ':' in line:
                label_counter += 1
                continue
            
            if line.startswith(';'):
                line = 'NOP ' + line

            instruction_binary = translate_to_binary(line, labels)

            vhdl_line = f'tmp({counter - empty_lines - label_counter})\t:= "{instruction_binary}";\t-- {comment}\n'
            bin_file.write(vhdl_line)

    asm_file.close()
    bin_file.close()

def convert_to_MIF():
    with open(MIF, 'r') as mif_file:
        headerMIF = mif_file.readlines()

    translation_dict = str.maketrans({ 't': '', 'm': '', 'p': '', '(': '', ')': '', '=': '', 'x': '', '"': '' })

    with open(MIF, 'w') as mif_file, open(BIN, 'r') as bin_file:

        counter = 0
        for mif_line in headerMIF:
            if counter < 6:
                mif_file.write(mif_line)
                counter += 1
                continue

        bin_lines = bin_file.readlines()
        bin_file.close()

        for bin_line in bin_lines:
            mif_line = format_bin_line(bin_line)

            mif_file.write(mif_line)

        mif_file.write(f'[{len(bin_lines)}..511]\t:\t0000000000000;\n')
        mif_file.write('END;')

    mif_file.close()

def copy_MIF_file_to_project(source_path: str, destiny_path: str):
    source_path = path.join(source_path, MIF)
    destiny_path = path.join(destiny_path, MIF)
    copy(source_path, destiny_path)

if __name__ == '__main__':
    convert_to_VHDL()
    convert_to_MIF()
    copy_MIF_file_to_project('.', PROJECT_PATH)