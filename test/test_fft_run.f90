
program test_fft_run
  use fft64
  use ffft_core
  use iso_fortran_env, only: real32
  implicit none

  integer, parameter :: N = 8
  type(fft64_t) :: signal(N)
  integer :: i

  ! Initialize signal as a delta function (impulse)
  signal = from_real_imag(0.0_real32, 0.0_real32)
  signal(1) = from_real_imag(1.0_real32, 0.0_real32)

  print *, "Input:"
  do i = 1, N
    print "(I2,2F10.4)", i, get_real(signal(i)), get_imag(signal(i))
  end do

  call fft_iterative(signal, N)

  print *, "Output (FFT):"
  do i = 1, N
    print "(I2,2F10.4)", i, get_real(signal(i)), get_imag(signal(i))
  end do
end program test_fft_run
