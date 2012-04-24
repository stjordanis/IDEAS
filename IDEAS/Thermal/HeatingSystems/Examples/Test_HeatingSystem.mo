within IDEAS.Thermal.HeatingSystems.Examples;
model Test_HeatingSystem
  "Generic test for heating systems as defined in TME.HVAC"

parameter Integer nZones = 2 "Number of zones";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature[nZones] TAmb
    annotation (Placement(transformation(extent={{18,-20},{-2,0}})));
  Thermal.HeatingSystems.Heating_DHW_TES_Radiators heating(
    nZones=nZones,
    VZones={75*2.7 for i in 1:nZones},
    QNom={100000 for i in 1:nZones},
    redeclare IDEAS.Thermal.Components.Production.HP_AWMod_Losses heater)
    annotation (Placement(transformation(extent={{18,-90},{38,-70}})));
  inner IDEAS.Climate.SimInfoManager       sim(redeclare
      IDEAS.Climate.Meteo.Files.min15 detail, redeclare
      IDEAS.Climate.Meteo.Locations.Uccle city)
    annotation (Placement(transformation(extent={{82,80},{102,100}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor[nZones] heatCapacitor(C={i*1e6 for i in 1:nZones}, T(each
        fixed=true, each start=292))
    annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
  Modelica.Thermal.HeatTransfer.Components.Convection[nZones] convection
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor[nZones]
    temperatureSensor
    annotation (Placement(transformation(extent={{-34,-60},{-14,-40}})));
  Modelica.Blocks.Sources.Pulse[nZones] TOpSet(
    each amplitude=4,
    each width=67,
    each period=86400,
    each offset=289,
    startTime={3600*7,3600*9})
    annotation (Placement(transformation(extent={{-92,52},{-72,72}})));
  Modelica.Blocks.Sources.Pulse[nZones] TOpSet1(
    each amplitude=4,
    each width=67,
    each period=86400,
    each offset=289,
    startTime={3600*7,3600*9})
    annotation (Placement(transformation(extent={{-6,24},{14,44}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(
    f=50,
    V=230,
    phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-64})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{80,-102},{100,-82}})));
  Interfaces.DummyInHomeGrid dummyInHomeGrid
    annotation (Placement(transformation(extent={{42,-90},{62,-70}})));
equation
  TAmb.T = sim.Te * ones(nZones);
  convection.Gc = if time < 1500 then zeros(nZones) else heating.QNom/4;
  connect(heatCapacitor.port, convection.solid) annotation (Line(
      points={{-80,-2},{-80,-10},{-40,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convection.fluid, TAmb.port) annotation (Line(
      points={{-20,-10},{-2,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor.port, heatCapacitor.port) annotation (Line(
      points={{-34,-50},{-80,-50},{-80,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heating.TSet, TOpSet.y) annotation (Line(
      points={{26.5714,-89},{26.5714,62},{-71,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heating.TSensor, temperatureSensor.T) annotation (Line(
      points={{21.0857,-86},{21.0857,-50},{-14,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heating.heatPortRad, heatCapacitor.port) annotation (Line(
      points={{20.8571,-82},{20.8571,-24},{-80,-24},{-80,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heating.heatPortCon, heatCapacitor.port) annotation (Line(
      points={{20.8571,-78},{26,-78},{26,-28},{-80,-28},{-80,-2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(voltageSource.pin_p,ground. pin) annotation (Line(
      points={{90,-74},{90,-82}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(heating.plugLoad[1], dummyInHomeGrid.nodeSingle) annotation (Line(
      points={{32.2857,-80},{42,-80}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(dummyInHomeGrid.pinSingle, voltageSource.pin_n) annotation (Line(
      points={{62,-80},{70,-80},{70,-48},{90,-48},{90,-54}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=200000, Interval=900),
    __Dymola_experimentSetupOutput);
end Test_HeatingSystem;
