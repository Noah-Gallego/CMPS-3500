-- ---------------------------------------------------------------------------
-- CMPS 3500 / Noah Gallego
-- area.adb (filename must match outer procedure name)
-- compile only:            $ gcc -c area.adb
-- compile and link:        $ gnatmake area.adb
-- execute:                 $ ./area
-- --------------------------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure area is
   type Point is record
      X, Y : Float;
   end record;
   
   -- Array to store points from file
   Max_Points : constant Integer := 50; -- Based on points.txt size
   Points : array(1..Max_Points) of Point;
   Num_Points : Integer := 0;
   
   -- Variables for tracking maximum area
   Max_Area : Float := 0.0;
   Best_Points : array(1..4) of Point;
   
   -- Function to calculate area of quadrilateral given 4 points
   function Calculate_Area(P1, P2, P3, P4 : Point) return Float is
      Area : Float;
   begin
      Area := abs(P1.X * P2.Y + P2.X * P3.Y + P3.X * P4.Y + P4.X * P1.Y -
                  P1.Y * P2.X - P2.Y * P3.X - P3.Y * P4.X - P4.Y * P1.X) / 2.0;
      return Area;
   end Calculate_Area;
   
   -- Function to sanitize input strings for Float'Value
   function Sanitize_Number(Input : String) return String is
      Result : String(1..Input'Length);
      Len : Natural := 0;
   begin
      for I in Input'Range loop
         if Input(I) = '-' or (Input(I) >= '0' and Input(I) <= '9') then
            Len := Len + 1;
            Result(Len) := Input(I);
         end if;
      end loop;
      return Result(1..Len);
   end Sanitize_Number;

begin
   -- Read points from file
   declare
      File : File_Type;
      Line : String(1..100); -- Just to be safe :)
      Last : Natural;
      X, Y : Float;
   begin
      Open(File, In_File, "points.txt");
      while not End_Of_File(File) loop
         Get_Line(File, Line, Last);
         
         if Last > 0 then
            declare
               Clean_Line : String(1..Last);
               Clean_Last : Natural := 0;
               Comma_Pos : Natural := 0;
            begin
               -- Copy only printable characters
               for I in 1..Last loop
                  if Is_Graphic(Line(I)) then -- Check if the character is a 'real' character
                  -- Source: https://ada-lang.io/docs/arm/AA-A/AA-A.3/ (I Could Not Get Regex To Work) --
                     Clean_Last := Clean_Last + 1;
                     Clean_Line(Clean_Last) := Line(I);
                     if Line(I) = ',' then
                        Comma_Pos := Clean_Last;
                     end if;
                  end if;
               end loop;
               
               if Clean_Last > 0 then
                  if Comma_Pos > 0 then
                     -- Comma separated format
                     declare
                        X_Part : String := Sanitize_Number(Clean_Line(1..Comma_Pos-1));
                        Y_Part : String := Sanitize_Number(Clean_Line(Comma_Pos+1..Clean_Last));
                     begin
                        if X_Part'Length > 0 and Y_Part'Length > 0 then
                           X := Float'Value(X_Part);
                           Y := Float'Value(Y_Part);
                           
                           Num_Points := Num_Points + 1;
                           Points(Num_Points) := (X, Y);
                        end if;
                     end;
                  else
                     -- Space separated format - find the last space
                     declare
                        Last_Space : Natural := 0;
                     begin
                        for I in reverse 1..Clean_Last loop
                           if Clean_Line(I) = ' ' then
                              Last_Space := I;
                              exit;
                           end if;
                        end loop;
                        
                        if Last_Space > 0 then
                           declare
                              X_Part : String := Sanitize_Number(Clean_Line(1..Last_Space-1));
                              Y_Part : String := Sanitize_Number(Clean_Line(Last_Space+1..Clean_Last));
                           begin
                              if X_Part'Length > 0 and Y_Part'Length > 0 then
                                 X := Float'Value(X_Part);
                                 Y := Float'Value(Y_Part);
                                 
                                 Num_Points := Num_Points + 1;
                                 Points(Num_Points) := (X, Y);
                              end if;
                           end;
                        end if;
                     end;
                  end if;
               end if;
            end;
         end if;
      end loop;
      Close(File);
   end;

   -- Find maximum area quadrilateral / Check Over Every Point Pair
   if Num_Points >= 4 then
      for I in 1..Num_Points-3 loop
         for J in I+1..Num_Points-2 loop
            for K in J+1..Num_Points-1 loop
               for L in K+1..Num_Points loop
                  declare
                     Area : Float;
                  begin
                     Area := Calculate_Area(Points(I), Points(J), Points(K), Points(L));
                     if Area > Max_Area then
                        Max_Area := Area;
                        Best_Points(1) := Points(I);
                        Best_Points(2) := Points(J);
                        Best_Points(3) := Points(K);
                        Best_Points(4) := Points(L);
                     end if;
                  end;
               end loop;
            end loop;
         end loop;
      end loop;

      -- Output results
      Put_Line("The quadrilateral with the maximal area is defined by:");
      for I in 1..4 loop
         Put("(");
         Put(Best_Points(I).X, Fore => 1, Aft => 2, Exp => 0);
         Put(", ");
         Put(Best_Points(I).Y, Fore => 1, Aft => 2, Exp => 0);
         Put_Line(")");
      end loop;
      
      Put_Line("The maximum area is:");
      Put(Max_Area, Fore => 1, Aft => 2, Exp => 0);
      New_Line;
   end if;
end area;