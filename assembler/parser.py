from lib import Length, Symbol, NumericSymbol, AlphaNumericSymbol
from mnemonics import MNEMONICS
from registers import REGS


class Parser:
    def __init__(self, lines: list[str]):
        self.lines = lines
        self.line_counter = 0
        self.count_empty_lines = 0
        self.count_label_lines = 0
        self.count_comment_lines = 0
        self.adjusted_line_counter = 0
        self.labels = {}

        self.__remove_empty_lines()
        self.__get_all_labels()

    def __remove_empty_lines(self):
        for line in self.lines:
            if not line.strip() or line.startswith(';'):
                self.lines.remove(line)

    def __get_all_labels(self):
        line_counter = 0
        empty_lines = 0
        label_lines = 0
        comment_lines = 0

        for line in self.lines:
            adjusted_counter = line_counter - empty_lines - comment_lines - label_lines
            line_counter += 1

            if not line.strip():
                empty_lines += 1
                continue

            if line.strip().startswith(';'):
                comment_lines += 1
                continue

            if ':' in line:
                label = line.split(':')[0].strip()
                self.labels[label] = adjusted_counter
                label_lines += 1

    @staticmethod
    def __convert_to_binary(value: str, length: int) -> str:
        return bin(int(value))[2:].zfill(length)

    @staticmethod
    def __split_line(line: str) -> tuple[str, str]:
        instruction = line.strip()

        if ';' in line:
            instruction = line.strip().split(';')[0]
            instruction = instruction.strip()

        comment = '-- ' + instruction

        return instruction, comment

    @staticmethod
    def __parse_mnemonic(line: str) -> str:
        mnemonic = line.split(' ')[0].strip()
        mnemonic_value = MNEMONICS[mnemonic]['value']
        solo = MNEMONICS[mnemonic]['solo']
        register = MNEMONICS[mnemonic]['reg']
        mnemonic_register = mnemonic_value + register

        if solo:
            return mnemonic_register.ljust(Length.INSTRUCTION, '0')

        if '@' in line:
            return mnemonic_register.ljust(Length.MNEMONIC + Length.REGISTERS, '0')

        return mnemonic_register.ljust(Length.MNEMONIC + Length.REGISTERS, '0')

    def __parse_symbol(self, line: str, symbol: Symbol, length: int = Length.INSTRUCTION, source: dict = None) -> str:
        value = line.split(symbol.symbol)[1].strip()

        if symbol.is_alpha_numeric():
            if value not in source:
                raise NameError(f'{value} is not declared')

            value = source[value]

        return self.__convert_to_binary(value, length)

    def __parse_address(self, line: str) -> str:
        return self.__parse_symbol(line, Symbol(NumericSymbol.ADDRESS), Length.IMMEDIATE)

    def __parse_integer(self, line: str) -> str:
        return self.__parse_symbol(line, Symbol(NumericSymbol.INTEGER), Length.IMMEDIATE)

    def __parse_label(self, line: str) -> str:
        return self.__parse_symbol(line, Symbol(AlphaNumericSymbol.LABEL), Length.IMMEDIATE, self.labels)

    def __parse_register(self, line: str) -> str:
        result = ''

        for register in line.split(','):
            register = register.strip()

            if register.startswith('%'):
                register = register[1:].strip()

                if register not in REGS:
                    raise NameError(f'{register} is not a valid register')

                result += self.__convert_to_binary(REGS[register], Length.REGISTERS)

        return result

    def __is_invalid_line(self, line: str) -> bool:
        if not line.strip():
            self.count_empty_lines += 1
            return True

        if line.strip().startswith(';'):
            self.count_comment_lines += 1
            return True

        if ':' in line:
            self.count_label_lines += 1
            return True

        return False

    def __update_adjusted_line_counter(self):
        self.adjusted_line_counter = self.line_counter
        self.adjusted_line_counter -= self.count_empty_lines
        self.adjusted_line_counter -= self.count_comment_lines
        self.adjusted_line_counter -= self.count_label_lines

    def __parse_instruction(self, line: str) -> str:
        mnemonic = self.__parse_mnemonic(line)
        instruction = mnemonic

        if len(instruction) == Length.INSTRUCTION:
            return instruction

        if '@' in line:
            instruction += self.__parse_address(line)

        elif '$' in line:
            instruction += self.__parse_integer(line)

        elif '.' in line:
            instruction += self.__parse_label(line)

        elif '%' in line:
            instruction += self.__parse_register(line)

        else:
            raise SyntaxError(f'Invalid instruction {line}')

        return instruction

    def __parse_line(self, line: str) -> bin or str or None:
        self.__update_adjusted_line_counter()

        self.line_counter += 1

        if not self.__is_invalid_line(line):
            instruction, comment = self.__split_line(line)
            instruction = self.__parse_instruction(instruction)
            mif_line = f'{self.adjusted_line_counter}:\t{instruction};\t{comment}\n'

            return mif_line


    def parse(self):
        mif_lines = []

        for line in self.lines:
            mif_line = self.__parse_line(line.strip())
            if mif_line:
                mif_lines.append(mif_line)

        return mif_lines
