from dataclasses import dataclass
from hsluv import hsluv_to_hex


@dataclass
class HSLuv:
    h: int
    s: int
    l: int

    def with_h(self, h):
        return HSLuv(h, self.s, self.l)

    def with_s(self, s):
        return HSLuv(self.h, s, self.l)

    def with_l(self, l):
        return HSLuv(self.h, self.s, l)

    def add_h(self, h):
        return HSLuv(self.h + h, self.s, self.l)

    def add_s(self, s):
        return HSLuv(self.h, self.s + s, self.l)

    def add_l(self, l):
        return HSLuv(self.h, self.s, self.l + l)

    def hex(self) -> str:
        return hsluv_to_hex((self.h, self.s, self.l))


magic = HSLuv(295, 100, 50)
black = magic.with_l(0)
blackmesa = HSLuv(30, 97, 66)

cloud = HSLuv(180, 11, 90)
emphasis = magic.with_h(3)
pink = magic.with_h(350)
mint = HSLuv(140, 100, 85)

# the major color types are:
# magic for functions
# blackmesa for types and variables (maybe i gotta separate them into orange and yellow
# logic for control flow, bools and probably maffs

func = blackmesa
type = magic

data = type.add_h(-10)
logic = type.with_h(265)

meta = func.add_s(-30)

# todo: green sucks, cyan sucks
# normal
normal = {
    "black": black,
    "red": emphasis,
    "green": HSLuv(140, 72, 77),
    "yellow": blackmesa,
    "blue": logic,
    "magenta": magic,
    "cyan": magic.with_h(215),
    "white": magic.with_l(100),
}

print("[colors.normal]")
for name, color in normal.items():
    print(f'{name} = "{color.hex()}"')

print("[colors.bright]")
for name, color in normal.items():
    print(f'{name} = "{color.add_l(15).hex()}"')

print("[colors.dim]")
for name, color in normal.items():
    print(f'{name} = "{color.add_l(-15).hex()}"')
