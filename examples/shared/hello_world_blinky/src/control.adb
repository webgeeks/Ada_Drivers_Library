package body control is

   procedure Intialize_Controls is
   begin
      Configure_PWM_Timer (Selected_Timer'Access, Requested_Frequency);

      Servo_Control.Attach_PWM_Channel
        (Selected_Timer'Access,
         Servo_Channel,
         LED_For (Servo_Channel),
         Timer_AF);

      Servo_Control.Enable_Output;

      Motor_Control.Attach_PWM_Channel
        (Selected_Timer'Access,
         Motor_Channel,
         LED_For (Motor_Channel),
         Timer_AF);

      Motor_Control.Enable_Output;

      Seed_Control.Attach_PWM_Channel
        (Selected_Timer'Access,
         Seed_Channel,
         LED_For (Seed_Channel),
         Timer_AF);

      Seed_Control.Enable_Output;

      Soil_Control.Attach_PWM_Channel
        (Selected_Timer'Access,
         Soil_Channel,
         LED_For (Soil_Channel),
         Timer_AF);

      Soil_Control.Enable_Output;

      Motor_Control.Set_Duty_Cycle (8);
      Servo_Control.Set_Duty_Cycle (7);

   end Intialize_Controls;

   procedure forward  is
   begin
      Motor_Control.Set_Duty_Cycle (11);
   end forward;


   procedure backward is
   begin
      Motor_Control.Set_Duty_Cycle (5);
   end backward;


   procedure left is
   begin
      Servo_Control.Set_Duty_Cycle (5);
   end left;


   procedure right is
   begin
      Servo_Control.Set_Duty_Cycle (9);
   end right;

   procedure stop is
   begin
      Motor_Control.Set_Duty_Cycle (8);
   end stop;

   procedure front is
   begin
      Servo_Control.Set_Duty_Cycle (7);
   end front;

   procedure Drop_Seed is
   begin
      Servo_Control.Set_Duty_Cycle (5);
      delay until Clock + Milliseconds (1000);
      Servo_Control.Set_Duty_Cycle (8);
   end Drop_Seed;

   procedure Measure is
   begin
      Servo_Control.Set_Duty_Cycle (3);
      delay until Clock + Milliseconds (1000);
      Servo_Control.Set_Duty_Cycle (8);
   end Measure;
end control;
