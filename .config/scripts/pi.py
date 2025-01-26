from decimal import Decimal, getcontext

def calculate_pi():
    getcontext().prec = 20000  # Set precision for calculations

    pi = Decimal(0)
    for k in range(20000):
        pi += (Decimal(1) / 16 ** k) * (
            Decimal(4) / (8 * k + 1) - Decimal(2) / (8 * k + 4) - Decimal(1) / (8 * k + 5) - Decimal(1) / (8 * k + 6)
        )

        temp_pi = str(pi * Decimal(10 ** 20000))
        digit = int(temp_pi.split('.')[1][k])
        print(digit, end='', flush=True)

    return pi

if __name__ == "__main__":
    print("Pi calculated so far: 3.", end="")
    pi = calculate_pi()

    print("\nFinal Pi generated up to 20,000 decimal places:")
    print(pi)

