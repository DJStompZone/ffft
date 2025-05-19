
module ffft_core
  use fft64
  use iso_fortran_env, only: real32
  implicit none
  public :: fft_iterative

contains

  subroutine fft_iterative(data, N, twiddles)
    integer, intent(in) :: N
    type(fft64_t), intent(inout) :: data(N)
    type(fft64_t), intent(in) :: twiddles(N/2)

    integer :: i, j, k, m, step, index1, index2
    type(fft64_t) :: t, u, w

    call bit_reverse_reorder(data, N)

    m = 1
    do while (m < N)
      step = 2 * m
      do k = 0, m - 1
        w = twiddles((k*N)/step + 1)
        do j = k, N - 1, step
          index1 = j + 1
          index2 = j + m + 1

          u = data(index1)
          t = multiply(w, data(index2))

          data(index1) = add(u, t)
          data(index2) = from_real_imag(get_real(u) - get_real(t), get_imag(u) - get_imag(t))
        end do
      end do
      m = step
    end do
  end subroutine fft_iterative

  subroutine bit_reverse_reorder(data, N)
    integer, intent(in) :: N
    type(fft64_t), intent(inout) :: data(N)
    integer :: i, j, bit
    type(fft64_t) :: temp

    j = 0
    do i = 0, N - 2
      if (i < j) then
        temp = data(j+1)
        data(j+1) = data(i+1)
        data(i+1) = temp
      end if
      bit = N / 2
      do while (bit <= j)
        j = j - bit
        bit = bit / 2
      end do
      j = j + bit
    end do
  end subroutine bit_reverse_reorder

end module ffft_core
