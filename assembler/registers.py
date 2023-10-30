from lib import Length


def register_binary(reg: int) -> str:
    return bin(reg)[2:].zfill(Length.REGISTERS)


REGS = {
    'r0': register_binary(0),
    'r1': register_binary(1),
    'r2': register_binary(2),
    'r3': register_binary(3),
}
