within SIMULATOR.DataBase;

model System
  parameter Integer Nc = 3 annotation( HideResult = true );
  parameter Simulator.Files.ChemsepDatabase.Benzene N2 annotation( HideResult = true );
  parameter Simulator.Files.ChemsepDatabase.Toluene O2 annotation( HideResult = true );
  parameter Simulator.Files.ChemsepDatabase.Water NH3 annotation( HideResult = true );
  parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc]={N2,O2,NH3} annotation( HideResult = true );

end System;
