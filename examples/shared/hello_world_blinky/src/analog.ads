with STM32.Device; use STM32.Device;

with HAL;          use HAL;
with STM32.ADC;    use STM32.ADC;
with STM32.GPIO;   use STM32.GPIO;


package analog is
   Converter     : Analog_To_Digital_Converter renames ADC_1;


   Successful : Boolean;
   
   procedure Configure_Analog_Input (Input : GPIO_Point);
   
   procedure ADC_Init (Input : GPIO_Point; Channel : UInt5);
   
   function Analog_Read return uint16;
   
   flt : Short_Float := 0.0;

   

end analog;
