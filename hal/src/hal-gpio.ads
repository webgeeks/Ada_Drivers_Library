package HAL.GPIO is

   type GPIO_Point is limited interface;

   type GPIO_Point_Ref is access all GPIO_Point'Class;

   function Set (Point : GPIO_Point) return Boolean is abstract;

   procedure Set (Point : GPIO_Point) is abstract;

   procedure Clear (Point : GPIO_Point) is abstract;

   procedure Toggle (Point : GPIO_Point) is abstract;

end HAL.GPIO;
