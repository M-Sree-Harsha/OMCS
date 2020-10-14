within SIMULATOR.UO;

model Heater
  inner Modelicaheater.DataBase.System s ;
  parameter String file = Modelica.Utilities.Files.loadResource("Modelica://Modelicaheater/test.txt");
  parameter Real Pout = Modelica.Utilities.Examples.readRealParameter(file, "OutletPressure");
  parameter Real Tout = Modelica.Utilities.Examples.readRealParameter(file, "OutletTemperature");
  Modelicaheater.Interfaces.matConn In(Nc = s.Nc) annotation(
    Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelicaheater.Interfaces.matConn Out(Nc = s.Nc) annotation(
    Placement(visible = true, transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelicaheater.Thermodynamics.ThermodynamicsLists tp annotation( HideResult = true );
  Modelicaheater.DataBase.Flash Fl_in(Nc=s.Nc,C=s.C),Fl_out(Nc=s.Nc,C=s.C);
  //Real Q;

equation
  Out.F = In.F;
  Out.x_pc = In.x_pc;
  Out.P = Pout;
  Out.T = Tout;
  
  if tp==Modelicaheater.Thermodynamics.ThermodynamicsLists.RaoultsLaw then
  Fl_in.Choice=1;
  Fl_out.Choice=1;
  else
  Fl_in.Choice=2;
  Fl_out.Choice=2;
  end if;
  Fl_in.T=In.T;
  //Fl_in.H_p[1]=-29180.9;
  //Fl_in.F_p[2]=10;
  //Fl_in.xliq=1;
  Fl_in.P=In.P;
  Fl_in.F_p[1]=In.F;
  Fl_in.x_pc[1,:]=In.x_pc;
  Fl_out.T=Tout;
  Fl_out.P=Pout;
  Fl_out.F_p[1]=Out.F;
  Fl_out.x_pc[1,:]=Out.x_pc;
  
  
  annotation(
    Icon(graphics = {Ellipse(origin = {0, 1}, lineThickness = 0.4, extent = {{-100, -99}, {100, 99}}, endAngle = 360), Text(origin = {2, 6}, extent = {{-58, 58}, {58, -58}}, textString = "H", textStyle = {TextStyle.Bold, TextStyle.Bold}), Text(extent = {{-92, -106}, {96, -136}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));


end Heater;
