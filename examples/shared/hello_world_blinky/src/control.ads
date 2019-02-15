with STM32.Board;  use STM32.Board;
with HAL;           use HAL;
with STM32.GPIO;    use STM32.GPIO;

with STM32.Device;  use STM32.Device;

with Ada.Real_Time;  use Ada.Real_Time;

with STM32.Timers; use STM32.Timers;
with STM32.PWM;    use STM32.PWM;


package control is

   Selected_Timer : STM32.Timers.Timer renames Timer_4;

   Timer_AF : constant STM32.GPIO_Alternate_Function := GPIO_AF_TIM4_2;


   Servo_Channel : constant Timer_Channel := Channel_1;
   Motor_Channel : constant Timer_Channel := Channel_2;
   Seed_Channel : constant Timer_Channel := Channel_3;
   Soil_Channel : constant Timer_Channel := Channel_4;

   LED_For : constant array (Timer_Channel) of User_LED :=
               (Channel_1 => Green_LED,
                Channel_2 => Orange_LED,
                Channel_3 => Red_LED,
                Channel_4 => Blue_LED);

   Requested_Frequency : constant Hertz := 50;  -- arbitrary

   Servo_Control : PWM_Modulator;
   Motor_Control : PWM_Modulator;
   Soil_Control : PWM_Modulator;
   Seed_Control : PWM_Modulator;
   
   procedure Intialize_Controls;
   
   procedure right;
   procedure left;
   procedure forward;
   procedure backward;
   procedure front;
   procedure stop;
   procedure Drop_Seed;
   procedure Measure;
   
end control;
