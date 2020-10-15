within SIMULATOR.Streams;

model Source
 parameter Boolean Use_Pin = false annotation(
   choices(checkBox = true),HideResult = true);
 parameter Boolean Use_Tin = false annotation(
   choices(checkBox = true),HideResult = true);
 parameter Boolean Use_Fin = false annotation(
   choices(checkBox = true),HideResult = true);
 parameter Boolean Use_Xin = false annotation(
   choices(checkBox = true),HideResult = true);
 parameter Integer Nc = s.Nc annotation(
   Dialog(enable = false));
 parameter String file = Modelica.Utilities.Files.loadResource("Modelica://SIMULATOR/test.txt");
 parameter Real P = Modelica.Utilities.Examples.readRealParameter(file, "Pressure") "Fixed value of pressure";
 parameter Real T = Modelica.Utilities.Examples.readRealParameter(file, "Temperature") "Fixed value of Temperature";
 parameter Real F = Modelica.Utilities.Examples.readRealParameter(file, "MolarFlowRate") "Fixed value of molar flowrate";
 parameter Real X[Nc] = {Modelica.Utilities.Examples.readRealParameter(file, "X1"), Modelica.Utilities.Examples.readRealParameter(file, "X2"), Modelica.Utilities.Examples.readRealParameter(file, "X3")} "Fixed value of mole fraction";
 SIMULATOR.Interfaces.RealInput T_in annotation(
   Placement(visible = true, transformation(origin = {-68, 80}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-120, 82}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
 SIMULATOR.Interfaces.RealInput P_in annotation(
   Placement(visible = true, transformation(origin = {-94, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-122, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
 SIMULATOR.Interfaces.RealInput F_in annotation(
   Placement(visible = true, transformation(origin = {-67, -81}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {-122, -88}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
 SIMULATOR.Interfaces.RealInput Xin[Nc] annotation(
   Placement(visible = true, transformation(origin = {-94, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-119, 29}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
 SIMULATOR.Interfaces.matConn Out(Nc = Nc) annotation(
   Placement(visible = true, transformation(origin = {95, 3}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {101, 1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
 inner SIMULATOR.DataBase.System s;
equation
 if not Use_Tin then
   T = T_in;
   Out.T = T;
 else
   Out.T = T_in;
 end if;
 if not Use_Pin then
   P = P_in;
   Out.P = P;
 else
   Out.P = P_in;
 end if;
 if not Use_Fin then
   F = F_in;
   Out.F = F;
 else
   Out.F = F_in;
 end if;
 if not Use_Xin then
   X = Xin;
   Out.x_pc = X;
 else
   Out.x_pc = Xin;
 end if;
 annotation(
   Icon(graphics = {Text(origin = {-32, -115}, extent = {{134, 17}, {-60, -15}}, textString = "%name"), Rectangle(fillColor = {85, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.3, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));

end Source;
