within SIMULATOR.Thermodynamics;
function NRTL
input Integer Nc "Number of components";
input Real P(unit="Pa", min=0);
input Real T(unit="K",min=0);
input Real x_c[Nc](each min = 0, each max = 1) "mole fractions";
input Real VP[Nc,6];//Vapour coefficents of each components
input String CAS[Nc];//CAS of each components
output Real K_c[Nc];
Real Pvap_c[Nc];//saturated vapour pressure of each component
Real gma_c[Nc];//activity coeff
algorithm
  for i in 1:Nc loop
    Pvap_c[i] := Simulator.Files.ThermodynamicFunctions.Psat(VP[i], T);
  end for;
  gma_c:=Modelicaheater.Thermodynamics.gammaNRTL(Nc,CAS,x_c,T);
  for j in 1:Nc loop
     K_c[j] := gma_c[j] * Pvap_c[j] / P;
  end for;
  
end NRTL;
