from os import path
from shutil import copy

from lib import File, MIF_HEADER, MIF_FOOTER, TEST, PROJECT_PATH
from parser import Parser


def build_mif(asm_file, mif_file):
    with open(asm_file, 'r') as asm:
        with open(mif_file, 'w') as mif:
            mif.write(MIF_HEADER)
            asm_content = asm.readlines()

            parser = Parser(asm_content)
            mif_lines = parser.parse()

            mif.writelines(mif_lines)
            mif.write(f'[{parser.adjusted_line_counter + 1}..{511}]:\t000000000000000;\n')
            mif.write(MIF_FOOTER)


if __name__ == '__main__':
    if TEST:
        build_mif(File.TEST_ASM.value, File.TEST_MIF.value)
        copy(File.TEST_MIF.value, path.join('../test/', File.MIF.value))

    else:
        build_mif(File.ASM.value, File.MIF.value)
        copy(File.MIF.value, path.join(PROJECT_PATH, File.MIF.value))
