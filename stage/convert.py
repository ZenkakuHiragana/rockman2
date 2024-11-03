
from os.path import abspath, dirname, join

path = 'quickman.bin'
roomdef_seek = range(0x16, 0x1F + 1)

chip_used = set()
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
        return None

roomdef_offset = 0x3000
start_offset = 0x200
end_offset = 0x600
with open(join(dirname(abspath(__file__)), path), 'r+b') as f:
    for room in roomdef_seek:
        f.seek(roomdef_offset + room * 0x40)
        roomdef = f.read(0x40)
        for byte in roomdef:
            chip_used.add(byte)
    f.seek(start_offset)
    data = f.read(end_offset - start_offset)
    processed = list(data)
    print([hex(c) for c in chip_used])
    for i in range(0x100):
        if i in chip_used:
            for j in range(4):
                converted = convert(processed[i * 4 + j])
                if converted is not None:
                    processed[i * 4 + j] = converted

    # 土下座部屋マップチップ置換用
    # start_offset = 0x480
    # f.seek(0x480)
    # data = f.read(0x74)
    # processed = list(data)
    # for i in range(0x74):
    #     processed[i] = (processed[i] & 0x3F) + 0x40
    f.seek(start_offset)
    f.write(bytearray(processed))
