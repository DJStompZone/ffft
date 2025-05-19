# FFFT - Fortran Fast Fourier Transform

**FFFT** is a modern Fortran implementation of a 64-bit optimized Fast Fourier Transform core, designed to push FFT to the limits of numerical performance.

## Features

- Single `int64` complex number representation (`fft64_t`)
- Portable and SIMD-friendly
- Optimized for real-world DSP use cases
- Precision-smart: accurate enough and heckin fast
- Includes Python-based benchmarking with `tqdm` support

## Structure

- `src/` – core module(s) (Fortran)
- `test/` – test(s) (Fortran)
- `bench/` – benchmarks (Python 3)
- `Makefile` – build system
- `test.sh` – convenience script to build + benchmark

## Build and Run

### Build

```bash
make
```

Or to build manually without GNU `make`:

```bash
gfortran -O3 -std=f2008 -funroll-loops -ffast-math -march=native src/fft64.f90 test/test_fft64.f90 -o ffft
chmod +x ffft
```

### Run

```bash
./ffft
```

### Benchmark

Run directly:

```bash
python3 bench/perf_test.py
```

Benchmark options:

- `-n`: Set number of iterations
- `--noprogress`: Disable the progress bar
- `-e`: Specify alternate FFT binary location

**Example:**
```bash
echo 'running performance tests, please wait...'
python3 bench/perf_test.py -e ../ffft -n 5000 --noprogress
```

A wrapper script is provided for convenience.
This builds a fresh binary and runs a quick 1000-iteration benchmark using bench/perf_test.py:

```bash
bash test.sh
```


