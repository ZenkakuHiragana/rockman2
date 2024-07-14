
from os.path import abspath, dirname, join
def convert(byte):
    if (byte & 0x3F) >= 0x18:
        return (byte & 0x3F) - 0x08
    elif (byte & 0x3F) < 0x10:
        table = [
            0x00, 0x02, 0x03, 0x04, 0x05, 0x01, 0x07, 0x08,
            0x06, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
        ]
        return table[byte & 0x3F]
    else:
        return 0x00

path = 'crashman.bin'
start_offset = 0x200
end_offset = 0x5FF
with open(join(dirname(abspath(__file__)), path), 'r+b') as f:
    f.seek(start_offset)
    data = f.read(end_offset - start_offset + 1)
    processed = bytearray(convert(byte) for byte in data)
    f.seek(start_offset)
    f.write(processed)
