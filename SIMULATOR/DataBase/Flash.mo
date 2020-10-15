within SIMULATOR.DataBase;

model Flash
extends SIMULATOR.GuessModels.InitialGuess;
  parameter Integer Nc "Number of Components" annotation( HideResult = true );
  parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] annotation( HideResult = true );
  Real F_p[3](each min=0 ,start = {Fg,Fliqg,Fvapg});
  Real x_pc[3, Nc](each min=0, each max=1,start={xguess,xg,yg});
  Real xliq(min = 0, max = 1 ,start = xliqg);
  Real xvap(min = 0, max = 1,start = xvapg);
  Real P(min = 0,start = Pg);
  Real T(min = 0,start = Tg);
  Real Pbubl( min = 0,start = Pmax)"Bubble point pressure";
  Real Pdew( min = 0,start = Pmin)"dew point pressure";
  Real K_c[Nc](start=K_guess); //annotation( HideResult = true );
  Real gmabubl_c[Nc](start=ones(Nc)) annotation( HideResult = false );
  Real gmadew_c[Nc](start=ones(Nc))annotation( HideResult = false );
  Real philiqbubl_c[Nc](start=ones(Nc))annotation( HideResult = true );
  Real phivapdew_c[Nc](start=ones(Nc))annotation( HideResult = true );
  Real xliqdew_c[Nc](each min = 0, each max = 1,start=xg) annotation( HideResult = true );
  Real H_pc[3, Nc](each unit = "kJ/kmol",start={ones(Nc),ones(Nc),ones(Nc)}) "Component molar enthalpy in phase" annotation( HideResult = true );
  Real H_p[3](each unit = "kJ/kmol",start={Hmixg,Hliqg,Hvapg}) "Phase molar enthalpy";
  Integer Choice;
equation


  //Thermodynamic Selection
    if Choice==1 then
      K_c = SIMULATOR.Thermodynamics.RaoultsLaw(Nc,P,T,C.VP);
      
      for i in 1:Nc loop
        gmabubl_c[i] = 1;
        gmadew_c[i] = 1;
        philiqbubl_c[i] = 1;
        phivapdew_c[i] = 1;
        xliqdew_c[i]=0;
      end for;
    else
      K_c =SIMULATOR.Thermodynamics.NRTL(Nc,P,T,x_pc[2,:],C.VP,C.CAS);
      for i in 1:Nc loop
        philiqbubl_c[i] = 1;
        phivapdew_c[i] = 1;
      end for;
      gmabubl_c = SIMULATOR.Thermodynamics.gammaNRTL(Nc,C.CAS,x_pc[1,:],T);
      gmadew_c =  SIMULATOR.Thermodynamics.gammaNRTL(Nc,C.CAS,xliqdew_c,T);
      for i in 1:Nc loop
        xliqdew_c[i] = x_pc[1, i] * Pdew / (gmadew_c[i] * Simulator.Files.ThermodynamicFunctions.Psat(C[i].VP, T));
      end for;
    end if;
    
  //Bubble point calculation
    Pbubl = sum(gmabubl_c[:] .* x_pc[1, :] .* exp(C[:].VP[2] + C[:].VP[3] / T + C[:].VP[4] * log(T) + C[:].VP[5] .* T .^ C[:].VP[6]) ./ philiqbubl_c[:]);
  //Dew point calculation
    Pdew = 1 / sum(x_pc[1, :] ./ (gmadew_c[:] .* exp(C[:].VP[2] + C[:].VP[3] / T + C[:].VP[4] * log(T) + C[:].VP[5] .* T .^ C[:].VP[6])) .* phivapdew_c[:]);


    
    if P >= Pbubl then
      sum(x_pc[2, :]) = 1;
    elseif P <= Pdew then
      sum(x_pc[3, :]) = 1;
    else
      sum(x_pc[3,:])=1;
    end if;
    //sum(x_pc[2,:])=1;
    //sum(x_pc[3,:])=1;
    for i in 1:Nc loop
        x_pc[3, i] = K_c[i] * x_pc[2, i];
    end for;
      for i in 1:Nc loop
      (x_pc[1, i]* F_p[1]) = (x_pc[2,i]* F_p[2]) + (x_pc[3,i]* F_p[3]);
      end for;
    xliq = F_p[2] / F_p[1];
    xvap = F_p[3] / F_p[1];
    F_p[1] = F_p[2] + F_p[3];

    
    for i in 1:Nc loop
    H_pc[2, i] = Simulator.Files.ThermodynamicFunctions.HLiqId(C[i].SH, C[i].VapCp, C[i].HOV, C[i].Tc, T);
    H_pc[3, i] = Simulator.Files.ThermodynamicFunctions.HVapId(C[i].SH, C[i].VapCp, C[i].HOV, C[i].Tc, T);
    end for;
    H_p[2] = sum(x_pc[2, :] .* H_pc[2, :]);
    H_p[3] = sum(x_pc[3, :] .* H_pc[3, :]);
    H_p[1] = xliq * H_p[2] + xvap * H_p[3];
    H_pc[1, :] = x_pc[1, :] .* H_p[1];
end Flash;
