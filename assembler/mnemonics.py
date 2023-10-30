from lib import Length


def mnemonic_binary(mne_val: int) -> str:
    return bin(mne_val)[2:].zfill(Length.MNEMONIC)


MNEMONICS = {
    'NOP': {
        'value': mnemonic_binary(0),
        'solo': True
    },
    'LDA': {
        'value': mnemonic_binary(1),
        'solo': False
    },
    'ADD': {
        'value': mnemonic_binary(2),
        'solo': False
    },
    'SUB': {
        'value': mnemonic_binary(3),
        'solo': False
    },
    'LDI': {
        'value': mnemonic_binary(4),
        'solo': False
    },
    'STA': {
        'value': mnemonic_binary(5),
        'solo': False
    },
    'JMP': {
        'value': mnemonic_binary(6),
        'solo': False
    },
    'JEQ': {
        'value': mnemonic_binary(7),
        'solo': False
    },
    'CEQ': {
        'value': mnemonic_binary(8),
        'solo': False
    },
    'JSR': {
        'value': mnemonic_binary(9),
        'solo': False
    },
    'RET': {
        'value': mnemonic_binary(10),
        'solo': True
    },
    'AND': {
        'value': mnemonic_binary(11),
        'solo': False
    },
}
