from enum import Enum, IntEnum

TEST = True

PROJECT_PATH = '../src/'

MIF_HEADER = '''WIDTH = 15;
DEPTH = 512;
ADDRESS_RADIX = HEX;
DATA_RADIX = BIN;

CONTENT BEGIN
'''

MIF_FOOTER = 'END;'


class File(Enum):
    ASM = 'ROM.asm'
    MIF = 'initROM.mif'
    TEST_ASM = 'test.asm'
    TEST_MIF = 'test.mif'


class Length(IntEnum):
    INSTRUCTION = 15
    MNEMONIC = 4
    IMMEDIATE = 9
    REGISTERS = 2
