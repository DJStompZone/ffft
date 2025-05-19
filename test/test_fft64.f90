program test_fft64
  use fft64
  implicit none

  type(fft64_t) :: z1, z2, result
  real(real32) :: r, i

  z1 = from_real_imag(1.0, 2.0)
  z2 = from_real_imag(3.0, -1.0)
  result = multiply(z1, z2)

  r = get_real(result)
  i = get_imag(result)

  print *, "z1 * z2 =", r, "+", i, "i"
end program test_fft64
