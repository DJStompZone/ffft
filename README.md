# FFFT - Fortran Fast Fourier Transform

**FFFT** is a modern Fortran implementation of a 64-bit optimized Fast Fourier Transform core,
designed to push FFT to the limits of numerical performance.

## Features

- Single `int64` complex number representation (`fft64_t`)
- Portable and SIMD-friendly
- Optimized for real-world DSP use cases
- Precision-smart: accurate enough and heckin fast

## Structure

- `src/` – core module(s) (fortran)
- `test/` – test(s) (fortran)
- `bench/` – benchmarks (python3)
- `Makefile` – makefile

## Build and Run

### Build

```bash
make
```
### Run

```bash
./ffft
```

### Test

```bash
python3 bench/perf_test.py
```
