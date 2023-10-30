from lib import Length
from registers import REGS


def mnemonic_binary(mne_val: int) -> str:
    return bin(mne_val)[2:].zfill(Length.MNEMONIC)


def register_binary(reg: str) -> str:
    return bin(REGS[reg])[2:].zfill(Length.REGISTERS)


MNEMONICS = {
    'NOP': {
        'value': mnemonic_binary(0),
        'solo': True,
        'reg': register_binary('r0')
    },
    'LDA': {
        'value': mnemonic_binary(1),
        'solo': False,
        'reg': register_binary('r0')
    },
    'ADD': {
        'value': mnemonic_binary(2),
        'solo': False,
        'reg': register_binary('r0')
    },
    'SUB': {
        'value': mnemonic_binary(3),
        'solo': False,
        'reg': register_binary('r0')
    },
    'LDI': {
        'value': mnemonic_binary(4),
        'solo': False,
        'reg': register_binary('r0')
    },
    'STA': {
        'value': mnemonic_binary(5),
        'solo': False,
        'reg': register_binary('r0')
    },
    'JMP': {
        'value': mnemonic_binary(6),
        'solo': False,
        'reg': register_binary('r0')
    },
    'JEQ': {
        'value': mnemonic_binary(7),
        'solo': False,
        'reg': register_binary('r0')
    },
    'CEQ': {
        'value': mnemonic_binary(8),
        'solo': False,
        'reg': register_binary('r0')
    },
    'JSR': {
        'value': mnemonic_binary(9),
        'solo': False,
        'reg': register_binary('r0')
    },
    'RET': {
        'value': mnemonic_binary(10),
        'solo': True,
        'reg': register_binary('r0')
    },
    'AND': {
        'value': mnemonic_binary(11),
        'solo': False,
        'reg': register_binary('r0')
    },
}
