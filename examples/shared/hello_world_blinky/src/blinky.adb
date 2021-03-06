with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);
with HAL;           use HAL;
with STM32.GPIO;    use STM32.GPIO;
with STM32.Device;  use STM32.Device;
with Ada.Real_Time;  use Ada.Real_Time;
with serial; use serial;
with analog; use analog;
with control; use control;

procedure Robot is

   flt : Short_Float := 0.0;
   Raw : UInt32;
   ADC_Pin : constant GPIO_Point := PA5;
   channel_5 : constant Uint5 := 5;

   data : Character := '0';
   procedure Send_Reading;

   procedure Send_Reading is
   begin
         Raw := UInt32 (Analog_Read);
         flt := (Short_Float(Raw)*3.3)/4095.0;
         Serial_Print ("{ ""val"":"&flt'Img&"}\r\n");
   end Send_Reading;

begin
   Initialize(115200);
   ADC_Init(ADC_Pin, channel_5);
   Intialize_Controls;

   declare
   begin
      loop

         data := Character'Val(Serial_Read);
         if data /= '0' then
            Serial_Print(data'Image);
         end if;

         case data is
            when 'w' => forward;
            when 's' => backward;
            when 'a' => left;
            when 'd' => right;
            when 'q' => stop;
            when 'e' => front;
            when 'z' => Drop_Seed;
            when 'x' => Measure;
            when 'f' => Send_Reading;
            when others => stop;
         end case;

         delay until Clock + Milliseconds (1000);
      end loop;
      end;
end Robot;
