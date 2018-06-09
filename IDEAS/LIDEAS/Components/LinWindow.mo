within IDEAS.LIDEAS.Components;
model LinWindow
  extends IDEAS.Buildings.Components.Window(redeclare
      BaseClasses.LinWindowResponse solWin(linearise=sim.linearise,
        createOutputs=sim.createOutputs));
  parameter Integer indexWindow = 1 "Index of this window"
    annotation(Dialog(group="Linearisation"),Evaluate=true);
protected
  IDEAS.Buildings.Components.Interfaces.WindowBus winBusOut if sim.createOutputs "Window bus to connecto to sim.winBusOut";
  outer input IDEAS.Buildings.Components.Interfaces.WindowBus[sim.nWindow]
    winBusIn if sim.linearise annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=90,
        origin={80,-50})));
equation
  connect(solWin.AbsQFlowInput, winBusIn[indexWindow].AbsQFlow) annotation (Line(
      points={{10.4,-41},{34.2,-41},{34.2,-49.9},{80.1,-49.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWin.iSolDirInput, winBusIn[indexWindow].iSolDir) annotation (Line(
      points={{10.4,-45},{32.2,-45},{32.2,-49.9},{80.1,-49.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solWin.iSolDifInput, winBusIn[indexWindow].iSolDif) annotation (Line(
      points={{10.4,-49},{30.2,-49},{30.2,-49.9},{80.1,-49.9}},
      color={0,0,127},
      smooth=Smooth.None));
  if sim.createOutputs then
    connect(sim.winBusOut[indexWindow], winBusOut);
    connect(solWin.AbsQFlowOutput, winBusOut.AbsQFlow);
    connect(solWin.iSolDirOutput, winBusOut.iSolDir);
    connect(solWin.iSolDifOutput, winBusOut.iSolDif);
  end if;
end LinWindow;