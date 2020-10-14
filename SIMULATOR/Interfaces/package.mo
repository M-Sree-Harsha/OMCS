within SIMULATOR;

package Interfaces
  extends Modelica.Icons.Package;
  annotation(
    Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
    __Dymola_state = true,
    singleInstance = true);
end Interfaces;
