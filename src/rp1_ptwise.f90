! ==============================================================================
!  This Riemann solver provides a harness for the point-wise evaluation of 
!  Riemann solutions and requires a point-wise definition of the Riemann solver
!  in a subroutine of the form "rp1_ptwise".
! ==============================================================================

subroutine rp1(maxm, meqn, mwaves, maux, mbc, mx, ql, qr, auxl, auxr, wave, s, amdq, apdq)

    implicit none

    ! Input
    integer, intent(in) :: maxm, meqn, mwaves, maux, mbc, mx
    real(kind=8), intent(in out) :: ql(meqn, 1-mbc:maxm+mbc)
    real(kind=8), intent(in out) :: qr(meqn, 1-mbc:maxm+mbc)
    real(kind=8), intent(in out) :: auxl(meqn, 1-mbc:maxm+mbc)
    real(kind=8), intent(in out) :: auxr(meqn, 1-mbc:maxm+mbc)

    ! Output
    real(kind=8), intent(in out) :: wave(meqn, mwaves, 1-mbc:maxm+mbc)
    real(kind=8), intent(in out) :: s(mwaves,1-mbc:maxm+mbc)
    real(kind=8), intent(in out) :: apdq(meqn, 1-mbc:maxm+mbc)
    real(kind=8), intent(in out) :: amdq(meqn, 1-mbc:maxm+mbc)

    ! Locals
    integer :: i

    do i = 2 - mbc, mx + mbc

        call rp1_ptwise(meqn, maux, mwaves, qr(:, i - 1),       &
                                            ql(:, i),           &
                                            auxr(:, i - 1),         &
                                            auxl(:, i),     &
                                            wave(:, :, i),      &
                                            s(:, i),            &
                                            amdq(:, i),         &
                                            apdq(:, i))

    end do

end subroutine rp1