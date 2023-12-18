import sys

def interpolate_color(color1, color2, ratio=0.5):
    if len(color1) != 6 or len(color2) != 6:
        raise ValueError("Les couleurs doivent être spécifiées en utilisant 6 caractères hexadécimaux.")

    r1, g1, b1 = int(color1[0:2], 16), int(color1[2:4], 16), int(color1[4:6], 16)
    r2, g2, b2 = int(color2[0:2], 16), int(color2[2:4], 16), int(color2[4:6], 16)

    r = int(r1 + (r2 - r1) * ratio)
    g = int(g1 + (g2 - g1) * ratio)
    b = int(b1 + (b2 - b1) * ratio)

    interpolated_color = "#{:02X}{:02X}{:02X}".format(r, g, b)

    return interpolated_color

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Utilisation : python interpolate_color.py <couleur1> <couleur2> [ratio]")
    else:
        color1 = sys.argv[1]
        color2 = sys.argv[2]
        if len(sys.argv) > 3:
            ratio = float(sys.argv[3])
        else:
            ratio = 0.5

        interpolated_color = interpolate_color(color1, color2, ratio)
        print(interpolated_color)

