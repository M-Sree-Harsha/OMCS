within SIMULATOR.UO;

model DistillationColumn
  inner SIMULATOR.DataBase.System s ;
  parameter Integer Nt=30 "Number of Trays";
  parameter Integer Nf=1 "Number of feed inputs";
  parameter Integer Ft=30 "array of Feed Trays";
  parameter Integer TP=1;
  parameter Real RR,RB,condensertemp;
  
  SIMULATOR.DataBase.Flash Feed_VLE(Nc=s.Nc,C=s.C);
  SIMULATOR.DataBase.TrayVLE Trays_VLE[Nt](each Nc=s.Nc,each C=s.C,each Choice=TP);
  SIMULATOR.DataBase.CondenserVLE condenser_VLE(Nc=s.Nc,C=s.C,Choice=TP);
  SIMULATOR.DataBase.TrayVLE Reboiler_VLE(Nc=s.Nc,C=s.C,Choice=TP);
  SIMULATOR.Interfaces.matConn Feed(Nc = s.Nc) annotation(
    Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SIMULATOR.Interfaces.matConn Dist(Nc = s.Nc) annotation(
    Placement(visible = true, transformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SIMULATOR.Interfaces.matConn Bottoms(Nc = s.Nc) annotation(
    Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
equation

  
  Feed.P=Feed_VLE.P;
  Feed.T=Feed_VLE.T;
  Feed.F=Feed_VLE.F_p[1];
  Feed.x_pc=Feed_VLE.x_pc[1,:];
  Feed_VLE.Choice=1;
  
  
  
  //Tray 1
  if Ft==1 then
    Trays_VLE[1].F_p[1]=((RR)*Dist.F)+Trays_VLE[2].F_p[3]+Feed_VLE.F_p[1];
    Trays_VLE[1].P=101325;
    Trays_VLE[1].H_p[1]=((condenser_VLE.H_p[2]*((RR/(RR+1))*condenser_VLE.F_p[1]))+(Trays_VLE[2].H_p[3]*Trays_VLE[2].F_p[3])+(Feed_VLE.H_p[1]*Feed_VLE.F_p[1]))/Trays_VLE[1].F_p[1];

    for j in 1:s.Nc loop
      Trays_VLE[1].x_pc[1,j]=(((RR)*Dist.F*condenser_VLE.x_pc[1,j])+(Trays_VLE[2].F_p[3]*Trays_VLE[2].x_pc[3,j])+(Feed_VLE.F_p[1]*Feed_VLE.x_pc[1,j]))/Trays_VLE[1].F_p[1];
    end for;
  else
    Trays_VLE[1].F_p[1]=((RR)*Dist.F)+Trays_VLE[2].F_p[3];
    Trays_VLE[1].P=101325;
    Trays_VLE[1].H_p[1]=((condenser_VLE.H_p[2]*((RR/(RR+1))*condenser_VLE.F_p[1]))+(Trays_VLE[2].H_p[3]*Trays_VLE[2].F_p[3]))/Trays_VLE[1].F_p[1];
    for j in 1:s.Nc loop
      Trays_VLE[1].x_pc[1,j]=(((RR)*Dist.F*condenser_VLE.x_pc[1,j])+(Trays_VLE[2].F_p[3]*Trays_VLE[2].x_pc[3,j]))/Trays_VLE[1].F_p[1];
    end for;
  end if;
  
  
  
  for i in 2:(Nt-1) loop
  if i==Ft then
    Trays_VLE[i].F_p[1]=Trays_VLE[i-1].F_p[2]+Trays_VLE[i+1].F_p[3]+Feed_VLE.F_p[1];
    Trays_VLE[i].P=101325;
    Trays_VLE[i].H_p[1]=((Trays_VLE[i-1].H_p[2]*Trays_VLE[i-1].F_p[2])+(Trays_VLE[i+1].H_p[3]*Trays_VLE[i+1].F_p[3])+(Feed_VLE.H_p[1]*Feed_VLE.F_p[1]))/Trays_VLE[i].F_p[1];
    for j in 1:s.Nc loop
      Trays_VLE[i].x_pc[1,j]=((Trays_VLE[i-1].F_p[2]*Trays_VLE[i-1].x_pc[2,j])+(Trays_VLE[i+1].F_p[3]*Trays_VLE[i+1].x_pc[3,j])+(Feed_VLE.F_p[1]*Feed_VLE.x_pc[1,j]))/Trays_VLE[i].F_p[1];
    end for;
  else
    Trays_VLE[i].F_p[1]=Trays_VLE[i-1].F_p[2]+Trays_VLE[i+1].F_p[3];
    Trays_VLE[i].P=101325;
    Trays_VLE[i].H_p[1]=((Trays_VLE[i-1].H_p[2]*Trays_VLE[i-1].F_p[2])+(Trays_VLE[i+1].H_p[3]*Trays_VLE[i+1].F_p[3]))/Trays_VLE[i].F_p[1];
    for j in 1:s.Nc loop
      Trays_VLE[i].x_pc[1,j]=((Trays_VLE[i-1].F_p[2]*Trays_VLE[i-1].x_pc[2,j])+(Trays_VLE[i+1].F_p[3]*Trays_VLE[i+1].x_pc[3,j]))/Trays_VLE[i].F_p[1];
    end for;
  end if;
  end for;
  
  
  
  
  
  //Tray Nt
  if Ft==Nt then
    Trays_VLE[Nt].F_p[1]=(Reboiler_VLE.F_p[3])+Trays_VLE[Nt-1].F_p[2]+Feed_VLE.F_p[1];
    Trays_VLE[Nt].P=101325;
    Trays_VLE[Nt].F_p[1]*Trays_VLE[Nt].H_p[1]=((Reboiler_VLE.H_p[3]*Reboiler_VLE.F_p[3])+(Trays_VLE[Nt-1].H_p[2]*Trays_VLE[Nt-1].F_p[2])+(Feed_VLE.H_p[1]*Feed_VLE.F_p[1]));
    for j in 1:s.Nc loop
      Trays_VLE[Nt].F_p[1]*Trays_VLE[Nt].x_pc[1,j]=((Reboiler_VLE.F_p[3]*Reboiler_VLE.x_pc[3,j])+(Trays_VLE[Nt-1].F_p[2]*Trays_VLE[Nt-1].x_pc[2,j])+(Feed_VLE.F_p[1]*Feed_VLE.x_pc[1,j]));
    end for;
  else
    Trays_VLE[Nt].F_p[1]=(Reboiler_VLE.F_p[3])+Trays_VLE[Nt-1].F_p[2];
    Trays_VLE[Nt].P=101325;
    Trays_VLE[Nt].H_p[1]=((Reboiler_VLE.H_p[3]*Reboiler_VLE.F_p[3])+(Trays_VLE[Nt-1].H_p[2]*Trays_VLE[Nt-1].F_p[2]))/Trays_VLE[Nt].F_p[1];
    for j in 1:s.Nc loop
      Trays_VLE[Nt].x_pc[1,j]=((Reboiler_VLE.F_p[3]*Reboiler_VLE.x_pc[3,j])+(Trays_VLE[Nt-1].F_p[2]*Trays_VLE[Nt-1].x_pc[2,j]))/Trays_VLE[Nt].F_p[1];
    end for;
  end if;
  
  
  //condenser
  condenser_VLE.F_p[1]=(RR+1)*Dist.F;//Trays_VLE[1].F_p[3]
  condenser_VLE.P=101325;
  condenser_VLE.T=condensertemp;
  //condenser_VLE.xliq=1;
  //condenser_VLE.Choice=TP;
  for i in 1:s.Nc loop
    condenser_VLE.x_pc[1,i]=Trays_VLE[1].x_pc[3,i];
  end for;
  //Reboiler
  Reboiler_VLE.F_p[1]=Trays_VLE[Nt].F_p[2];
  Reboiler_VLE.P=101325;
  Reboiler_VLE.F_p[2]=RB;
  for i in 1:s.Nc loop
    Reboiler_VLE.x_pc[1,i]=Trays_VLE[Nt].x_pc[2,i];
  end for;
 
  Dist.F=Feed.F-RB;
  Dist.P=101325;
  Dist.x_pc=condenser_VLE.x_pc[1,:];
  Dist.T=condenser_VLE.T;
  
  Bottoms.P=101325;
  Bottoms.F=RB;
  Bottoms.T=Trays_VLE[Nt].T;
  Bottoms.x_pc=Trays_VLE[Nt].x_pc[2,:];
  
  

annotation(
    Icon(graphics = {Rectangle(lineThickness = 0.4, extent = {{-100, 100}, {100, -100}}), Text(origin = {2, 6}, extent = {{-74, 86}, {74, -86}}, textString = "D")}));
end DistillationColumn;
