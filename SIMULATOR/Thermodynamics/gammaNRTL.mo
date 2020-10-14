within SIMULATOR.Thermodynamics;

function gammaNRTL
  //this function calculates the activity coefficients(gamma) as per NRTL(Non Random Two Liquid) Model
  input Integer Nc "Nember of Components";
  input String CAS[Nc];
  input Real x_c[Nc](each min = 0, each max = 1) "mole fractions";
  input Real T(unit = "K", min = 0, start = 273.15) "Temperature";
  output Real gma_c[Nc];
protected
  Real tau[Nc, Nc], G[Nc, Nc], alpha[Nc, Nc], A[Nc, Nc], BIPS[Nc, Nc, 2];
  Real sum1[Nc](each start = 1), sum2[Nc](each start = 1);
  constant Real R = 1.98721;
algorithm
  BIPS := Simulator.Files.ThermodynamicFunctions.BIPNRTL(Nc, CAS);
  A := BIPS[:, :, 1];
  alpha := BIPS[:, :, 2];
  tau := A ./ (R * T);
  for i in 1:Nc loop
    for j in 1:Nc loop
      G[i, j] := exp(-alpha[i, j] * tau[i, j]);
    end for;
  end for;
  for i in 1:Nc loop
    sum1[i] := sum(x_c[:] .* G[:, i]);
    sum2[i] := sum(x_c[:] .* tau[:, i] .* G[:, i]);
  end for;
  for i in 1:Nc loop
    gma_c[i] := exp(sum(x_c[:] .* tau[:, i] .* G[:, i]) / sum(x_c[:] .* G[:, i]) + sum(x_c[:] .* G[i, :] ./ sum1[:] .* (tau[i, :] .- sum2[:] ./ sum1[:])));
  end for;
end gammaNRTL;
