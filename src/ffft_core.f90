
module ffft_core
  use fft64
  implicit none
  public :: fft_iterative

contains

  subroutine fft_iterative(data, N)
    integer, intent(in) :: N
    type(fft64_t), intent(inout) :: data(N)
    integer :: i, j, k, m, n, stage
    integer :: half_size, step, index1, index2
    real(real32) :: angle, wr, wi, tr, ti
    type(fft64_t) :: t, u, temp

    ! Bit reversal permutation
    call bit_reverse_reorder(data, N)

    ! FFT main loop (radix-2 Cooley-Tukey)
    m = 1
    do while (m < N)
      step = 2 * m
      do k = 0, m - 1
        angle = -2.0 * 3.14159265358979 * k / step
        wr = cos(angle)
        wi = sin(angle)
        do j = k, N - 1, step
          index1 = j + 1
          index2 = j + m + 1

          u = data(index1)
          t = multiply(from_real_imag(wr, wi), data(index2))

          data(index1) = add(u, t)
          data(index2) = from_real_imag(get_real(u) - get_real(t), get_imag(u) - get_imag(t))
        end do
      end do
      m = step
    end do
  end subroutine fft_iterative

  subroutine bit_reverse_reorder(data, N)
    type(fft64_t), intent(inout) :: data(N)
    integer, intent(in) :: N
    integer :: i, j, bit, n
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
