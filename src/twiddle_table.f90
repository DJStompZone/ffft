
module twiddle_table
  use fft64
  use iso_fortran_env, only: real32
  implicit none
  public :: precompute_twiddles

contains

  subroutine precompute_twiddles(twiddles, N)
    integer, intent(in) :: N
    type(fft64_t), allocatable, intent(out) :: twiddles(:)
    integer :: k
    real(real32) :: angle, wr, wi

    allocate(twiddles(N / 2))

    do k = 0, (N / 2) - 1
      angle = -2.0_real32 * 3.1415927_real32 * k / real(N, real32)
      wr = cos(angle)
      wi = sin(angle)
      twiddles(k + 1) = from_real_imag(wr, wi)
    end do
  end subroutine precompute_twiddles

end module twiddle_table
