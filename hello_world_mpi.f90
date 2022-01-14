program mpi_hello
! Problem 3.7.1 in Pacheco.  Send greeting from one processor to
! another.
! Mark Petersen, 3/8/03

! to compile on mauve:
! ifort mpi_hello.f90 -lmpi

! if you are using mpich:
!  use mpi
!  use iflport, only: hostnam
  implicit none
! if you are using scali mpi:
 include 'mpif.h'

  integer send_to, rec_from, idneighbor
  integer myid, p, ierr, rc, status(MPI_STATUS_SIZE)
  integer :: istatus(4), hostnam(4)
  real :: host_name
!  istatus = hostnam(host_name)

  call MPI_INIT( ierr )
  call MPI_COMM_RANK( MPI_COMM_WORLD, myid, ierr )
  call MPI_COMM_SIZE( MPI_COMM_WORLD, p, ierr )

  send_to  =mod(myid+1,p);
  rec_from =mod(p+myid-1,p)

  print '(4(a,i4))', ' I am process ',myid,' of ',p,'. I send to ',send_to,' and rec from ',rec_from

  call MPI_SEND(myid,1,MPI_INTEGER, send_to, send_to , &
                  MPI_COMM_WORLD,ierr)

  call MPI_RECV(idneighbor,1,MPI_INTEGER,rec_from,myid, &
                    MPI_COMM_WORLD,status,ierr)

 call MPI_FINALIZE(rc)

end program mpi_hello