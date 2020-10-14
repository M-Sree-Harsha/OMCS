within SIMULATOR;

package UO
extends Modelica.Icons.Package;

  annotation(
    Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
    __Dymola_state = true,
    singleInstance = true);
end UO;
