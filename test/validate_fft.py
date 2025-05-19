
import numpy as np
import csv
import subprocess

# Parameters
N = 8
MAX_ABS_ERROR = 1e-6
MAX_REL_ERROR = 1e-4
EPSILON = 1e-12

# Input signal (delta function)
impulse = [1.0] + [0.0] * (N - 1)
expected = np.fft.fft(impulse)

# Run Fortran binary
output = subprocess.check_output(["./ffft"], text=True).splitlines()

# Parse output
lines = [line.strip() for line in output if line.strip()]
start = lines.index("Output (FFT):") + 1
fortran_fft = []
for line in lines[start:start + N]:
    parts = line.split()
    re, im = float(parts[1]), float(parts[2])
    fortran_fft.append(complex(re, im))

# Analyze error
abs_errors = []
rel_errors = []

print("Index | Fortran FFT           | NumPy FFT             | Abs Error     | Rel Error     | Status")
print("---------------------------------------------------------------------------------------------")

for i, (f, n) in enumerate(zip(fortran_fft, expected)):
    abs_error = abs(f - n)
    rel_error = abs_error / abs(n) if abs(n) > EPSILON else 0.0

    abs_errors.append(abs_error)
    rel_errors.append(rel_error)

    status = ""
    if abs_error > MAX_ABS_ERROR or rel_error > MAX_REL_ERROR:
        status = "**FAIL**"

    print(f"{i:5d} | {f.real:9.6f} + {f.imag:9.6f}i | {n.real:9.6f} + {n.imag:9.6f}i | "
          f"{abs_error:12.6e} | {rel_error:12.6e} | {status}")

# Summary
print("\nSummary:")
print(f"Max abs error: {max(abs_errors):.6e}")
print(f"Max rel error: {max(rel_errors):.6e}")
print(f"Mean abs error: {np.mean(abs_errors):.6e}")
print(f"Mean rel error: {np.mean(rel_errors):.6e}")
print(f"Stddev abs error: {np.std(abs_errors):.6e}")
print(f"Stddev rel error: {np.std(rel_errors):.6e}")

with open("fft_compare.csv", "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["index", "fortran_real", "fortran_imag", "numpy_real", "numpy_imag", "abs_error", "rel_error"])
    for i in range(N):
        writer.writerow([
            i,
            fortran_fft[i].real,
            fortran_fft[i].imag,
            expected[i].real,
            expected[i].imag,
            abs_errors[i],
            rel_errors[i]
        ])
