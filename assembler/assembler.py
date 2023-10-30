from parser import Parser
from lib import File, MIF_HEADER, MIF_FOOTER, TEST
from os import path
from shutil import copy


def build_mif(asm_file, mif_file):
    with open(asm_file, 'r') as asm:
        with open(mif_file, 'w') as mif:
            mif.write(MIF_HEADER)
            asm_content = asm.readlines()

            parser = Parser(asm_content)
            mif_lines = parser.parse()

            mif.writelines(mif_lines)
            mif.write('\n' + MIF_FOOTER)

if __name__ == '__main__':
    if TEST:
        build_mif(File.TEST_ASM, File.TEST_MIF)

    else:
        build_mif(File.ASM, File.MIF)