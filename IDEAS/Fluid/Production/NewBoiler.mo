within IDEAS.Fluid.Production;
model NewBoiler
  //Extensions
  extends Interfaces.PartialHeater(
    redeclare Interfaces.HeatSources.Boiler
      heatSource(
        redeclare replaceable IDEAS.Fluid.Production.Interfaces.Data.BoilerData
                                                            data,
        final heatPumpWaterWater=false));

  Interfaces.BaseClasses.QAsked qAsked(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{36,18},{22,32}})));
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Sources.RealExpression h_in_val(y=inStream(port_a.h_outflow))
    annotation (Placement(transformation(extent={{88,22},{52,42}})));
equation
  PFuel = 0;
  PEl = 0;

  connect(qAsked.T_in, heatSource.TinPrimary) annotation (Line(
      points={{21.37,20.87},{8,20.87},{8,27.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qAsked.y, heatSource.QAsked) annotation (Line(
      points={{21.37,29.27},{18,29.27},{18,34},{10,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(m_flow_val.y, qAsked.m_flow) annotation (Line(
      points={{52.8,8},{46,8},{46,19.33},{36.63,19.33}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(h_in_val.y, qAsked.h_in) annotation (Line(
      points={{50.2,32},{44,32},{44,31.37},{36.63,31.37}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u, qAsked.u) annotation (Line(
      points={{30,106},{30,70},{90,70},{90,24.93},{36.63,24.93}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-58,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Ellipse(extent={{-46,46},{48,-46}}, lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,34},{32,-34}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{90,60},{60,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{60,60},{42,42}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{60,-60},{44,-44}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Line(
          points={{90,-60},{60,-60}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash)}));
end NewBoiler;