within SIMULATOR.Examples;

model Distillation
  SIMULATOR.Streams.Source source(P = 101325)  annotation(
    Placement(visible = true, transformation(origin = {-184, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SIMULATOR.Streams.Sink DistillateSink annotation(
    Placement(visible = true, transformation(origin = {-64, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SIMULATOR.Streams.Sink BottomsSink annotation(
    Placement(visible = true, transformation(origin = {-66, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SIMULATOR.UO.DistillationColumn distillationColumn(Ft = 46, Nt = 50,RB = 10, RR = 5, TP = 1, condensertemp = 310)  annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(source.Out, distillationColumn.Feed) annotation(
    Line(points = {{-174, 18}, {-130, 18}, {-130, 20}, {-130, 20}}, color = {0, 70, 70}));
  connect(distillationColumn.Dist, DistillateSink.In) annotation(
    Line(points = {{-110, 28}, {-88, 28}, {-88, 36}, {-74, 36}, {-74, 36}}, color = {0, 70, 70}));
  connect(distillationColumn.Bottoms, BottomsSink.In) annotation(
    Line(points = {{-110, 12}, {-92, 12}, {-92, -6}, {-76, -6}, {-76, -6}}, color = {0, 70, 70}));

end Distillation;
