-- ---------------------------------------------------------------------------
-- CMPS 3500 / Noah Gallego
-- inverse.adb (filename must match outer procedure name)
-- compile only:            $ gcc -c inverse.adb
-- compile and link:        $ gnatmake inverse.adb
-- execute:                 $ ./inverse
-- --------------------------------------------------------------------------

with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO;      use Ada.Text_IO;

procedure inverse is
   subtype Index is Positive range 1 .. 6;
   type Matrix is array (Index range <>, Index range <>) of Float;

   procedure Load_Matrix(Filename : String; M : out Matrix) is
      F : File_Type;
      Val : Float;
   begin
      Open(F, In_File, Filename);
      for I in M'Range(1) loop
         for J in M'Range(2) loop
            Get(F, Val);
            M(I, J) := Val;
         end loop;
      end loop;
      Close(F);
   end Load_Matrix;

   procedure Display_Matrix(M : Matrix; Title : String) is
   begin
      Put_Line(Title);
      for I in M'Range(1) loop
         for J in M'Range(2) loop
            Put(M(I, J), Fore => 8, Aft => 3, Exp => 0);
            Put(" ");
         end loop;
         New_Line;
      end loop;
   end Display_Matrix;

   function Get_Minor(M : Matrix; Skip_Row, Skip_Col : Index) return Matrix is
      New_Size : constant Integer := M'Length(1) - 1;
      subtype Minor_Index is Positive range 1 .. New_Size;
      Minor : Matrix(Minor_Index, Minor_Index);
      R, C : Integer := 1;
   begin
      for I in M'Range(1) loop
         exit when R > New_Size;
         if I /= Skip_Row then
            C := 1;
            for J in M'Range(2) loop
               if J /= Skip_Col then
                  Minor(R, C) := M(I, J);
                  C := C + 1;
               end if;
            end loop;
            R := R + 1;
         end if;
      end loop;
      return Minor;
   end Get_Minor;

   function Compute_Determinant(M : Matrix) return Float is
      Det : Float := 0.0;
   begin
      if M'Length(1) = 2 then
         return M(1,1)*M(2,2) - M(1,2)*M(2,1);
      end if;

      for J in M'Range(2) loop
         declare
            Sign : constant Float := Float((-1) ** (1 + J));
            Minor : Matrix := Get_Minor(M, 1, J);
         begin
            Det := Det + Sign * M(1, J) * Compute_Determinant(Minor);
         end;
      end loop;
      return Det;
   end Compute_Determinant;

function Compute_Cofactor(M : Matrix) return Matrix is
   Cof : Matrix(M'Range(1), M'Range(2));
begin
   for I in M'Range(1) loop
      for J in M'Range(2) loop
         declare
            Sign : constant Float := Float((-1) ** (I + J));
            Minor : Matrix := Get_Minor(M, I, J);
         begin
            Cof(I, J) := Sign * Compute_Determinant(Minor);
         end;
      end loop;
   end loop;
   return Cof;
end Compute_Cofactor;

   function Compute_Inverse(M : Matrix) return Matrix is
      Cof : Matrix := Compute_Cofactor(M);
      Det : Float := Compute_Determinant(M);
      Inv : Matrix(M'Range(1), M'Range(2));
   begin
      for I in Cof'Range(1) loop
         for J in Cof'Range(2) loop
            Inv(I, J) := Cof(J, I) / Det; -- Transpose + divide by determinant
         end loop;
      end loop;
      return Inv;
   end Compute_Inverse;

   -- Declare matrices based on file size
   A : Matrix(1..6, 1..6);
   B : Matrix(1..5, 1..5);

begin
   Load_Matrix("A.txt", A);
   Load_Matrix("B.txt", B);

   Display_Matrix(Compute_Cofactor(A), "Cofactor Matrix of A:");
   Display_Matrix(Compute_Inverse(A), "Inverse of A:");
   Display_Matrix(Compute_Cofactor(B), "Cofactor Matrix of B:");
   Display_Matrix(Compute_Inverse(B), "Inverse of B:");
end inverse;