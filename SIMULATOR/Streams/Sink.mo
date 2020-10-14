within SIMULATOR.Streams;

model Sink
  Modelicaheater.Interfaces.matConn In(Nc = s.Nc) annotation(
    Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelicaheater.DataBase.System s;
  annotation(
    Icon(graphics = {Rectangle(fillColor = {85, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 100}, {100, -100}}), Text(origin = {-38, -119}, extent = {{134, 17}, {-60, -15}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end Sink;
