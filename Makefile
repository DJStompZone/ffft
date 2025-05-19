
FC = gfortran
FFLAGS = -O3 -std=f2008 -funroll-loops -ffast-math -march=native

SRC = src/fft64.f90 src/ffft_core.f90 src/twiddle_table.f90
TEST = test/test_fft_run.f90
OUT = ffft

all: $(OUT)

$(OUT): $(SRC) $(TEST)
	$(FC) $(FFLAGS) $^ -o $@

clean:
	rm -f $(OUT) *.mod
