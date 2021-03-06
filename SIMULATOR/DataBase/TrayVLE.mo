within SIMULATOR.DataBase;

model TrayVLE

extends SIMULATOR.GuessModels.InitialGuess;
  parameter Integer Nc "Number of Components" annotation( HideResult = true );
  parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] annotation( HideResult = true );
  Real F_p[3](each min=0 ,start = {500,Fliqg,Fvapg});
  Real x_pc[3, Nc](each min=0, each max = 1,start={xguess,xg,yg});
  Real xliq(min = 0, max = 1 ,start = xliqg);
  Real xvap(min = 0, max = 1,start = xvapg);
  Real P(min = 0,start = Pg);
  Real T(min = 0,start = Tg);
  Real K_c[Nc](start=K_guess); //annotation( HideResult = true );
  Real H_pc[3, Nc](each unit = "kJ/kmol",start={Hcompg,Hcomplg,Hcompvg}) "Component molar enthalpy in phase" annotation( HideResult = true );
  Real H_p[3](each unit = "kJ/kmol",start={Hmixg,Hliqg,Hvapg}) "Phase molar enthalpy";
  parameter Integer Choice=1;


equation
  //F_p[1]=270;
  //P=101326;
  //T=371;
  //xliq=1;
  //x_pc[1,:]={0.2,0.2,0.6};
  //x_pc[1,:]={0.441155,0.181587,0.568176};
  //H_p[1]=-11838.1;

  //Thermodynamic Selection
    if Choice==1 then
       K_c = SIMULATOR.Thermodynamics.RaoultsLaw(Nc,P,T,C.VP);
    else
       K_c = SIMULATOR.Thermodynamics.NRTL(Nc,P,T,x_pc[2,:],C.VP,C.CAS);
    end if;
  //K_c = SIMULATOR.Thermodynamics.RaoultsLaw(Nc,P,T,C.VP);
    for i in 1:Nc loop
        x_pc[3,i] = K_c[i] * x_pc[2, i];
    end for;
    sum(x_pc[2,:])=1;
    sum(x_pc[3,:])=1;
    for i in 1:Nc loop
      (x_pc[1, i]* F_p[1]) = (x_pc[2,i]* F_p[2]) + (x_pc[3,i]* F_p[3]);
    end for;
    xliq = F_p[2] / F_p[1];
    xliq+xvap=1;
    //xvap = F_p[3] / F_p[1];
    //F_p[1] = F_p[2] + F_p[3];
    
    
    for i in 1:Nc loop
      H_pc[2, i] = Simulator.Files.ThermodynamicFunctions.HLiqId(C[i].SH, C[i].VapCp, C[i].HOV, C[i].Tc, T);
      H_pc[3, i] = Simulator.Files.ThermodynamicFunctions.HVapId(C[i].SH, C[i].VapCp, C[i].HOV, C[i].Tc, T);
    end for;
    H_p[2] = sum(x_pc[2, :] .* H_pc[2, :]);
    H_p[3] = sum(x_pc[3, :] .* H_pc[3, :]);
    H_p[1] = xliq * H_p[2] + xvap * H_p[3];
    H_pc[1, :] = x_pc[1, :] .* H_p[1];
end TrayVLE;
