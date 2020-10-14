within SIMULATOR.Interfaces;

connector matConn
  Real P, T, F, x_pc[Nc];
  parameter Integer Nc;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 70, 70}, fillColor = {0, 70, 70}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}})}));
end matConn;
