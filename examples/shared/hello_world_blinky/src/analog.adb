package body analog is

   procedure ADC_Init (Input : GPIO_Point; Channel: UInt5) is
      Input_Channel: constant Analog_Input_Channel  := Channel;
      All_Regular_Conversions : constant Regular_Channel_Conversions :=
        (1 => (Channel => Input_Channel, Sample_Time => Sample_144_Cycles));
   begin

      Configure_Analog_Input(Input);

      Enable_Clock (Converter);

      Reset_All_ADC_Units;

      Configure_Common_Properties
        (Mode           => Independent,
         Prescalar      => PCLK2_Div_2,
         DMA_Mode       => Disabled,
         Sampling_Delay => Sampling_Delay_5_Cycles);

      Configure_Unit
        (Converter,
         Resolution => ADC_Resolution_12_Bits,
         Alignment  => Right_Aligned);

      Configure_Regular_Conversions
        (Converter,
         Continuous  => False,
         Trigger     => Software_Triggered,
         Enable_EOC  => True,
         Conversions => All_Regular_Conversions);

      Enable (Converter);
   end ADC_Init;


   procedure Configure_Analog_Input (Input : GPIO_Point) is
   begin
      Enable_Clock (Input);
      Configure_IO (Input, (Mode => Mode_Analog, Resistors => Floating));
   end Configure_Analog_Input;

   function Analog_Read return uint16 is

   begin
      Start_Conversion (Converter);

      Poll_For_Status (Converter, Regular_Channel_Conversion_Complete, Successful);
      if not Successful then
         return 0;
      else
         return Conversion_Value (Converter);
      end if;

   end Analog_Read;


end analog;
