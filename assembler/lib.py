from enum import Enum, IntEnum

TEST = True

PROJECT_PATH = '../src/'

MIF_HEADER = '''DEPTH = 512;
WIDTH = 15;
ADDRESS_RADIX = HEX;
DATA_RADIX = BIN;

content begin
'''

MIF_FOOTER = 'end;'


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


class NumericSymbol(Enum):
    ADDRESS = '@'
    INTEGER = '$'


class AlphaNumericSymbol(Enum):
    REGISTER = '%'
    LABEL = '.'


class Symbol:
    def __init__(self, symbol: NumericSymbol | AlphaNumericSymbol):
        self.symbol: NumericSymbol | AlphaNumericSymbol = symbol

    def is_alpha_numeric(self):
        return self.symbol in AlphaNumericSymbol.__members__.values()
