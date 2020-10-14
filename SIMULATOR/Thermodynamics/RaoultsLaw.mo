within SIMULATOR.Thermodynamics;

function RaoultsLaw
input Integer Nc;
input Real P;
input Real T;
input Real VP[Nc,6];
output Real K_c[Nc];
Real Pvap_c[Nc];

algorithm
  for i in 1:Nc loop
    Pvap_c[i] := Simulator.Files.ThermodynamicFunctions.Psat(VP[i], T);
  end for;
  for j in 1:Nc loop
    K_c[j] := Pvap_c[j] / P;
  end for;
end RaoultsLaw;
