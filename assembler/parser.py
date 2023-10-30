from lib import Length
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

    def __parse_symbol(self, line: str, symbol: str, length: int = Length.INSTRUCTION, source: dict = None) -> str:
        value = line.split(',')[0].strip()
        value = value.split(symbol)[1].strip()

        if symbol == '.':
            if value not in source:
                raise NameError(f'{value} is not declared')

            value = source[value]

        return self.__convert_to_binary(value, length)

    def __parse_address(self, line: str) -> str:
        return self.__parse_symbol(line, '@', Length.IMMEDIATE)

    def __parse_integer(self, line: str) -> str:
        return self.__parse_symbol(line, '$', Length.IMMEDIATE)

    def __parse_label(self, line: str) -> str:
        return self.__parse_symbol(line, '.', Length.IMMEDIATE, self.labels)

    @staticmethod
    def __parse_mnemonic(line: str) -> str:
        mnemonic = line.split(' ', 1)[0].strip()

        if MNEMONICS[mnemonic]['solo']:
            return MNEMONICS[mnemonic]['value'].ljust(Length.INSTRUCTION, '0')

        return MNEMONICS[mnemonic]['value']

    @staticmethod
    def __parse_register(line: str) -> str:
        register = line.split(';', 1)[0].strip()
        register = ' '.join(register.split(' ')[1:])
        register_list = register.split(',')

        if len(register_list) < 2:
            return '00'

        register = register_list[1].strip()
        if not register.startswith('%'):
            raise SyntaxError(f'Invalid register syntax at: {register}')

        register = register[1:].strip().lower()
        if register not in REGS:
            raise NameError(f'{register} is not a valid register')

        return REGS[register]

    def __parse_immediate(self, line: str) -> str:
        if '@' in line:
            return self.__parse_address(line)

        elif '$' in line:
            return self.__parse_integer(line)

        elif '.' in line:
            return self.__parse_label(line)

        raise SyntaxError(f'Invalid immediate at: {line}')

    def __parse_instruction(self, line: str) -> str:
        mnemonic = self.__parse_mnemonic(line)

        if len(mnemonic) == Length.INSTRUCTION:
            return mnemonic

        register = self.__parse_register(line)
        immediate = self.__parse_immediate(line)

        return mnemonic + register + immediate

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
