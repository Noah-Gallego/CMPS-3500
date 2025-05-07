C********************************************************************
C NAME: Noah Gallego
C ORGN: CSUB - CMPS 3500
C FILE: matrixops.f
C********************************************************************
C Reads two 6×6 matrices (m1.in, m2.in) and one 6×1 vector (v1.in).
C - Performs matrix and vector operations.
C - Implements two functions:
C     - Transpose for a 6x6 matrix.
C     - Power function to raise a 6x6 matrix to an integer power.
C********************************************************************

C     Define variables as arrays of 2 and 1 dimensions
      REAL matrix1(6,6), matrix2(6,6)
      REAL mat_sum(6,6), mat_subs(6,6), mat_prod1(6,6)
      REAL mat_trans1(6,6), mat_trans2(6,6)
      REAL vector1(6), mat_prod2(6)
      REAL dotprod
      REAL transp1(6,6), transp2(6,6), transp3(6,6), transp4(6,6)
      REAL power_m1_2(6,6), power_m1_3(6,6), power_m1_4(6,6)
      INTEGER SIZE1, SIZE2, SIZE3, I, J, K
      REAL, ALLOCATABLE :: mtemp1(:), mtemp2(:), mtemp3(:)

C     ****************************************
C     Reading m1.in
C     ****************************************
      OPEN(1,FILE='m1.in',ERR=2002)
      ALLOCATE (mtemp1(1:36))
      DO I=1,36
         READ(1,*) mtemp1(I)
      END DO
      matrix1 = RESHAPE(mtemp1, (/6,6/))
      CLOSE(1)

C     ****************************************
C     Reading m2.in
C     ****************************************
      OPEN(2,FILE='m2.in',ERR=2002)
      ALLOCATE (mtemp2(1:36))
      DO I=1,36
         READ(2,*) mtemp2(I)
      END DO
      matrix2 = RESHAPE(mtemp2, (/6,6/))
      CLOSE(2)

C     ****************************************
C     Reading v1.in
C     ****************************************
      OPEN(3,FILE='v1.in',ERR=2002)
      ALLOCATE (mtemp3(1:6))
      DO I=1,6
         READ(3,*) mtemp3(I)
      END DO
      vector1 = mtemp3
      CLOSE(3)

C     ****************************************
C     Performing Operations
C     ****************************************
      mat_sum = matrix1 + matrix2
      mat_subs = matrix1 - matrix2
      mat_prod1 = MATMUL(matrix1, matrix2)
      mat_prod2 = MATMUL(matrix1, vector1)
      dotprod = DOT_PRODUCT(vector1, mat_prod2)

C     Transpose Calculations
      mat_trans1 = TRANSPOSE(matrix1)
      mat_trans2 = TRANSPOSE(matrix2)
      transp1 = TRANSPOSE(TRANSPOSE(matrix1))
      transp2 = TRANSPOSE(MATMUL(matrix1, matrix2))
      transp3 = MATMUL(TRANSPOSE(matrix2), TRANSPOSE(matrix1))
      transp4 = MATMUL(TRANSPOSE(matrix2), MATMUL(matrix1, matrix2))

C     Power Logic 
      power_m1_2 = MATMUL(matrix1, matrix1)
      power_m1_3 = MATMUL(power_m1_2, matrix1)
      power_m1_4 = MATMUL(power_m1_3, matrix1)

C     ****************************************
C     Writing Outputs
C     ****************************************
      PRINT *, 'Program to show some matrix and vector operations'
      PRINT *, '*************************************************'
      PRINT *

      PRINT *, 'matrix1 = '
      WRITE(*,2000) ((matrix1(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'matrix2 = '
      WRITE(*,2000) ((matrix2(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'vector1 = '
      WRITE(*,2001) vector1
      PRINT *

      PRINT *, 'mat_sum = matrix1 + matrix2 ='
      WRITE(*,2000) ((mat_sum(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'mat_subs = matrix1 - matrix2 ='
      WRITE(*,2000) ((mat_subs(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'mat_prod1 = matrix1 * matrix2'
      WRITE(*,2000) ((mat_prod1(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'mat_prod2 = matrix1 * vector1'
      WRITE(*,2001) mat_prod2
      PRINT *

      PRINT *, 'dot_prod = vector1 . mat_prod2'
      PRINT *, dotprod
      PRINT *

      PRINT *, 'transp1 = transpose(transpose(m1))'
      WRITE(*,2000) ((transp1(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'transp2 = transpose(m1 * m2)'
      WRITE(*,2000) ((transp2(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'transp3 = transpose(m2) * transpose(m1)'
      WRITE(*,2000) ((transp3(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'transp4 = transpose(m2) * m1 * m2'
      WRITE(*,2000) ((transp4(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'pwm12 = power(m1,2)'
      WRITE(*,2000) ((power_m1_2(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'pwm13 = power(m1,3)'
      WRITE(*,2000) ((power_m1_3(I,J),J=1,6),I=1,6)
      PRINT *

      PRINT *, 'pwm14 = power(m1,4)'
      WRITE(*,2000) ((power_m1_4(I,J),J=1,6),I=1,6)
      PRINT *

C     Format output for 6x6 arrays
 2000 FORMAT(4X,6F8.2)

C     Format output for 6x1 vector
 2001 FORMAT((5X,F8.2))

      STOP

C     Error if file cannot be opened
 2002 PRINT *, 'Empty or missing input file'
      STOP
      END