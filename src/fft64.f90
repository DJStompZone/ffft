module fft64
  use iso_fortran_env, only: int32, int64, real32
  implicit none

  private
  public :: fft64_t, from_real_imag, get_real, get_imag, add, multiply

  type :: fft64_t
     integer(int64) :: raw
  end type fft64_t

contains

  function from_real_imag(r, i) result(out)
    real(real32), intent(in) :: r, i
    type(fft64_t) :: out
    integer(int32) :: r_bits, i_bits

    r_bits = transfer(r, r_bits)
    i_bits = transfer(i, i_bits)

    out%raw = shiftl(int(i_bits, int64), 32) + int(ior(r_bits, 0), int64)
  end function from_real_imag

  function get_real(this) result(r)
    type(fft64_t), intent(in) :: this
    real(real32) :: r
    integer(int32) :: r_bits

    r_bits = int(iand(this%raw, z'FFFFFFFF'), int32)
    r = transfer(r_bits, r)
  end function get_real

  function get_imag(this) result(i)
    type(fft64_t), intent(in) :: this
    real(real32) :: i
    integer(int32) :: i_bits

    i_bits = int(shiftr(this%raw, 32), int32)
    i = transfer(i_bits, i)
  end function get_imag

  function add(a, b) result(out)
    type(fft64_t), intent(in) :: a, b
    type(fft64_t) :: out
    real(real32) :: ar, ai, br, bi

    ar = get_real(a); ai = get_imag(a)
    br = get_real(b); bi = get_imag(b)

    out = from_real_imag(ar + br, ai + bi)
  end function add

  function multiply(a, b) result(out)
    type(fft64_t), intent(in) :: a, b
    type(fft64_t) :: out
    real(real32) :: ar, ai, br, bi, r, i

    ar = get_real(a); ai = get_imag(a)
    br = get_real(b); bi = get_imag(b)

    r = ar * br - ai * bi
    i = ar * bi + ai * br

    out = from_real_imag(r, i)
  end function multiply

end module fft64
