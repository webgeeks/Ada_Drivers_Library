with HAL;           use HAL;
with STM32.GPIO;    use STM32.GPIO;
with STM32.USARTs;  use STM32.USARTs;

with STM32.Device;  use STM32.Device;

package serial is
   
   TX_Pin : constant GPIO_Point := PB7;
   RX_Pin : constant GPIO_Point := PB6;

   procedure Initialize_UART_GPIO;

   procedure Initialize(baud: UInt32);

   procedure Await_Send_Ready (This : USART) with Inline;

   procedure Serial_Print (Data : String);

   function Serial_Read return UInt9;
   
end serial;
