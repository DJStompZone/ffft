FC = gfortran
FFLAGS = -O3 -std=f2008 -funroll-loops -ffast-math -march=native

SRC = src/fft64.f90
TEST = test/test_fft64.f90
OUT = ftfft

all: $(OUT)

$(OUT): $(SRC) $(TEST)
	$(FC) $(FFLAGS) $^ -o $@

clean:
	rm -f $(OUT)
