package body serial is


   procedure Initialize_UART_GPIO is
   begin
      Enable_Clock (USART_1);
      Enable_Clock (RX_Pin & TX_Pin);

      Configure_IO
        (RX_Pin & TX_Pin,
         (Mode           => Mode_AF,
          AF             => GPIO_AF_USART1_7,
          Resistors      => Pull_Up,
          AF_Speed       => Speed_50MHz,
          AF_Output_Type => Push_Pull));
   end Initialize_UART_GPIO;

   procedure Initialize (baud : UInt32) is
   begin
      Initialize_UART_GPIO;

      Disable (USART_1);

      Set_Baud_Rate    (USART_1, baud);
      Set_Mode         (USART_1, Tx_Rx_Mode);
      Set_Stop_Bits    (USART_1, Stopbits_1);
      Set_Word_Length  (USART_1, Word_Length_8);
      Set_Parity       (USART_1, No_Parity);
      Set_Flow_Control (USART_1, No_Flow_Control);

      Enable (USART_1);
   end Initialize;

   procedure Await_Send_Ready (This : USART) is
   begin
      loop
         exit when Tx_Ready (This);
      end loop;
   end Await_Send_Ready;

   procedure Await_Read_Ready (This : USART) is
   begin
      loop
         exit when Rx_Ready (This);
      end loop;
   end Await_Read_Ready;


   procedure Serial_Print (Data : String) is
   begin
      for i in data'Range loop
         Await_Send_Ready (USART_1);
         Transmit (USART_1, UInt9 (Character'Pos(Data(i))));
      end loop;
   end Serial_Print;

   function Serial_Read return UInt9 is
      data : UInt9;
   begin
      Await_Read_Ready (USART_1);
      Receive(USART_1,data);
      return data;
   end Serial_Read;

end serial;
