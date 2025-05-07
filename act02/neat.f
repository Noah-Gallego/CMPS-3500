C ********************************************************************
C NAME: Noah Gallego 
C ASGT: Activity 02
C ORGN: CSUB - CMPS 3500
C FILE: neat.f
C DATE: 02/15/2025
C ********************************************************************
C     PRIME NUMBER GENERATOR
      INTEGER I, J, K, N
      REAL ARRAY(100)

C Read input data
      PRINT *, 'Enter Five Numbers Below: '
      READ *, N
      DO 5 I = 1, N
         READ *, ARRAY(I)
    5 CONTINUE

C Bubble Sort: Sort the array in ascending order
      DO 10 I = 1, N - 1
         DO 20 J = 1, N - I
            IF (ARRAY(J) .GT. ARRAY(J + 1)) THEN
               K = ARRAY(J)
               ARRAY(J) = ARRAY(J + 1)
               ARRAY(J + 1) = K
            END IF
   20    CONTINUE
   10 CONTINUE

C Replace negative values with 0
      DO 30 K = 1, N
         IF (ARRAY(K) .LT. 0.0) THEN
            ARRAY(K) = 0.0
         END IF
   30 CONTINUE

C Print results
      PRINT *, 'Sorted numbers:'
      DO 40 I = 1, N
         PRINT *, ARRAY(I)
   40 CONTINUE

      END