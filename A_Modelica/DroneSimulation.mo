within ;
package DroneSimulation


  package Blocks

    package Sources
      model linePath
        Modelica.Blocks.Sources.Ramp ramp2(
          duration=0.5,
          offset=0.25,
          height=5,
          startTime=5)
          annotation (Placement(transformation(extent={{-14,-26},{6,-6}})));
        Modelica.Blocks.Sources.Ramp ramp3(
          duration=0.5,
          height=5,
          offset=0,
          startTime=15)
          annotation (Placement(transformation(extent={{-14,8},{6,28}})));
        Modelica.Blocks.Math.Add add(k1=-1)
          annotation (Placement(transformation(extent={{34,-10},{54,10}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder1(
          T=0.2,
          y_start=0,
          initType=Modelica.Blocks.Types.Init.InitialOutput)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={80,0})));
      equation
        connect(ramp3.y,add. u1) annotation (Line(points={{7,18},{28,18},{28,6},{
                32,6}},              color={0,0,127}));
        connect(ramp2.y,add. u2) annotation (Line(points={{7,-16},{28,-16},{28,-6},
                {32,-6}},            color={0,0,127}));
        connect(add.y, firstOrder1.u)
          annotation (Line(points={{55,0},{68,0}}, color={0,0,127}));
        connect(firstOrder1.y, y)
          annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end linePath;

      model circlePath
        Modelica.Blocks.Sources.Cosine cosine(
          startTime=10,
          amplitude=2,
          offset=-2,
          freqHz=0.2)
          annotation (Placement(transformation(extent={{-44,42},{-24,62}})));
        Modelica.Blocks.Sources.Ramp ramp4(
          height=1,
          duration=0,
          offset=0,
          startTime=10)
          annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
        Modelica.Blocks.Math.Add add2(k1=+1)
          annotation (Placement(transformation(extent={{-2,-50},{18,-30}})));
        Modelica.Blocks.Sources.Ramp ramp5(
          duration=0.5,
          offset=0.25,
          startTime=3,
          height=2)
          annotation (Placement(transformation(extent={{-40,-74},{-20,-54}})));
        Modelica.Blocks.Math.Product product
          annotation (Placement(transformation(extent={{-12,24},{8,44}})));
        Modelica.Blocks.Sources.Sine sine(
          startTime=10,
          offset=0.25,
          amplitude=2,
          freqHz=0.2)
          annotation (Placement(transformation(extent={{-12,68},{8,88}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,30},{120,50}})));
        Modelica.Blocks.Interfaces.RealOutput y1
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder3(
          T=0.2,
          y_start=0,
          initType=Modelica.Blocks.Types.Init.InitialOutput)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={40,-40})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder4(
          T=0.2,
          y_start=0,
          initType=Modelica.Blocks.Types.Init.InitialOutput)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={80,40})));
      equation
        connect(ramp5.y,add2. u2) annotation (Line(points={{-19,-64},{-12,-64},{
                -12,-46},{-4,-46}},     color={0,0,127}));
        connect(cosine.y, product.u1) annotation (Line(points={{-23,52},{-18,52},
                {-18,40},{-14,40}}, color={0,0,127}));
        connect(ramp4.y, product.u2) annotation (Line(points={{-21,10},{-18,10},{
                -18,28},{-14,28}}, color={0,0,127}));
        connect(product.y, add2.u1) annotation (Line(points={{9,34},{14,34},{14,
                -12},{-18,-12},{-18,-34},{-4,-34}}, color={0,0,127}));
        connect(sine.y, firstOrder4.u) annotation (Line(points={{9,78},{56,78},{
                56,40},{68,40}}, color={0,0,127}));
        connect(firstOrder4.y, y)
          annotation (Line(points={{91,40},{110,40}}, color={0,0,127}));
        connect(add2.y, firstOrder3.u)
          annotation (Line(points={{19,-40},{28,-40}}, color={0,0,127}));
        connect(firstOrder3.y, y1) annotation (Line(points={{51,-40},{110,-40}},
                                 color={0,0,127}));
        annotation (Icon(graphics={
      Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
              Ellipse(extent={{-56,56},{54,-42}}, lineColor={28,108,200}),
              Line(
                points={{34,52},{50,40},{58,30},{64,16},{64,0},{60,-12},{56,-20},
                    {50,-26},{44,-32},{38,-34}},
                color={0,0,0},
                thickness=1,
                smooth=Smooth.Bezier,
                arrow={Arrow.Filled,Arrow.None})}));
      end circlePath;
      annotation (Icon(graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Polygon(origin={23.3333,0.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
            Rectangle(
              fillColor = {128,128,128},
              pattern = LinePattern.None,
              fillPattern = FillPattern.Solid,
              extent = {{-70,-4.5},{0,4.5}})}));
    end Sources;

    package Control
      model discretePID
        parameter Real ki=10 "I gain";
        parameter Real kd=5 "D gain";
        parameter Real kp=15 "P gain";
        parameter Modelica.SIunits.Time samplePeriod=0.01
          "Sample period of component";
        Modelica.Blocks.Discrete.TransferFunction transferFunction(samplePeriod=
              samplePeriod,
          a={1,-1,0},
          b={(kp + ki*samplePeriod/2 + kd/samplePeriod),(-kp + ki*samplePeriod/2
               - 2*kd/samplePeriod),kd/samplePeriod})
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));

        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
        Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-100})));
        Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=samplePeriod)
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=
              samplePeriod)
          annotation (Placement(transformation(extent={{58,-10},{78,10}})));
      equation
        connect(u, feedback.u1)
          annotation (Line(points={{-100,0},{-76,0}}, color={0,0,127}));
        connect(transferFunction.u, feedback.y)
          annotation (Line(points={{-12,0},{-59,0}}, color={0,0,127}));
        connect(feedback.u2, u1) annotation (Line(points={{-68,-8},{-68,-100},{0,
                -100}}, color={0,0,127}));
        connect(transferFunction.y, sampler.u)
          annotation (Line(points={{11,0},{18,0}}, color={0,0,127}));
        connect(sampler.y, zeroOrderHold.u)
          annotation (Line(points={{41,0},{56,0}}, color={0,0,127}));
        connect(y, zeroOrderHold.y)
          annotation (Line(points={{110,0},{79,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.None),
              Rectangle(
                extent={{-80,-54},{-40,-56}},
                lineColor={0,0,0},
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-38,-56},{-40,0}},
                lineColor={0,0,0},
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-40,2},{0,0}},
                lineColor={0,0,0},
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Line(points={{0,20},{0,0}}, color={0,0,0}),
              Rectangle(
                extent={{2,0},{0,20}},
                lineColor={0,0,0},
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{2,18},{80,20}},
                lineColor={0,0,0},
                fillColor={28,108,200},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,94},{78,30}},
                lineColor={0,0,0},
                fillColor={28,108,200},
                fillPattern=FillPattern.None,
                textString="PID")}),                                   Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end discretePID;

      annotation (Icon(graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),   Line(
              origin={0.061,4.184},
              points={{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,
                  113.485},{-65.374,-61.217},{-78.061,-78.184}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Control;

    package Math
      annotation (Icon(graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),   Line(
              points={{-80,-2},{-68.7,32.2},{-61.5,51.1},{-55.1,64.4},{-49.4,72.6},
                  {-43.8,77.1},{-38.2,77.8},{-32.6,74.6},{-26.9,67.7},{-21.3,57.4},
                  {-14.9,42.1},{-6.83,19.2},{10.1,-32.8},{17.3,-52.2},{23.7,-66.2},
                  {29.3,-75.1},{35,-80.4},{40.6,-82},{46.2,-79.6},{51.9,-73.5},{
                  57.5,-63.9},{63.9,-49.2},{72,-26.8},{80,-2}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Math;

    package Routing
      model RealExtract
        "Pass a Real signal through without modification"
        parameter Integer index= 3 "output which variable in the array";

        Modelica.Blocks.Interfaces.RealInput u[3]
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = u[index];
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
                  color={0,0,127}), Rectangle(extent={{-100,100},{100,-100}},
                  lineColor={28,108,200}),
              Line(points={{-80,80}}, color={28,108,200}),
              Line(points={{-100,60},{0,60},{100,0}}, color={28,108,200}),
              Line(points={{-80,0},{0,0}}, color={255,0,0}),
              Line(points={{-100,-60},{0,-60}}, color={255,0,0}),
              Rectangle(
                extent={{0,20},{4,-20}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,-40},{4,-80}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid)}),
                          Documentation(info="<html>
<p>
Passes a Real signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
      end RealExtract;

      model RealExtend
        "Pass a Real signal through without modification"

        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
              iconTransformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y[3]
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        y = {0,0,u};
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
                  color={0,0,127}), Rectangle(extent={{-100,100},{100,-100}},
                  lineColor={28,108,200}),
              Line(points={{-80,0}}, color={81,255,0}),
              Line(points={{-100,0},{0,60},{100,60}},color={28,108,200}),
              Line(points={{-100,0},{100,0},{100,-60},{0,-60},{-100,0}},
                                                                       color={28,
                    108,200})}),
                          Documentation(info="<html>
<p>
Passes a Real signal through without modification. 
This enables a single input to enter the system, then translates the signal into an array.
</p>
</html>"));
      end RealExtend;

      model RealExtendMultiple
        "Pass a Real signal through without modification"

        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
        Modelica.Blocks.Interfaces.RealOutput y[3]
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.RealInput u1
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Interfaces.RealInput u2
          annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
      equation
        y = {u,u1,u2};
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
                  color={0,0,127}), Rectangle(extent={{-100,100},{100,-100}},
                  lineColor={28,108,200}),
              Line(points={{-80,0}}, color={81,255,0}),
              Line(points={{-80,0},{0,60},{100,60}}, color={28,108,200}),
              Line(points={{-80,0},{100,0},{100,-60},{0,-60},{-80,0}}, color={28,108,200})}),
                          Documentation(info="<html>
<p>
Passes a Real signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
      end RealExtendMultiple;
      annotation (Icon(graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Line(points={{-90,0},{4,0}}, color={95,95,95}),
            Line(points={{88,65},{48,65},{-8,0}}, color={95,95,95}),
            Line(points={{-8,0},{93,0}}, color={95,95,95}),
            Line(points={{87,-65},{48,-65},{-8,0}}, color={95,95,95})}));
    end Routing;
    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(
          origin={-51.25,0.0},
          points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(
          origin={51.25,0.0},
          points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
  end Blocks;


  package Sensors
    model GPS
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-70})));
      Modelica.Mechanics.MultiBody.Sensors.RelativePosition relativePosition(
          resolveInFrame=resolveInFrame)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-40,0})));
      Modelica.Blocks.Interfaces.RealOutput y[3]
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
        "GPS location frame";
    equation
      connect(relativePosition.frame_a, fixed.frame_b) annotation (Line(
          points={{-30,-1.77636e-15},{0,-1.77636e-15},{0,-60},{6.66134e-16,
              -60}},
          color={95,95,95},
          thickness=0.5));
      connect(frame_a, relativePosition.frame_b) annotation (Line(
          points={{-100,0},{-50,0}},
          color={95,95,95},
          thickness=0.5));
      connect(relativePosition.r_rel, y) annotation (Line(points={{-40,11},{
              32,11},{32,0},{110,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None), Text(
              extent={{-76,26},{78,-72}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None,
              textString="GPS
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
    end GPS;

    model Accelerometer
      Modelica.Mechanics.MultiBody.Sensors.RelativeAngles relativeAngles
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,40})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        annotation (Placement(transformation(extent={{84,-16},{116,16}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed
        annotation (Placement(transformation(extent={{-74,30},{-54,50}})));
      Modelica.Blocks.Interfaces.RealOutput y[3] annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-110,0})));
    equation
      connect(relativeAngles.frame_b, frame_a) annotation (Line(
          points={{20,40},{20,0},{100,0}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeAngles.frame_a, fixed.frame_b) annotation (Line(
          points={{-8.88178e-16,40},{-54,40}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeAngles.angles, y) annotation (Line(points={{10,29},{10,
              -4.44089e-16},{-110,-4.44089e-16}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None), Text(
              extent={{-74,32},{76,-54}},
              lineColor={0,0,0},
              fillColor={28,108,200},
              fillPattern=FillPattern.None,
              textString="Accelerometer
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Accelerometer;

    model Gyro
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None)}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end Gyro;
    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Ellipse(origin={0.0,-30.0},
            fillColor={255,255,255},
            extent={{-90.0,-90.0},{90.0,90.0}},
            startAngle=20.0,
            endAngle=160.0),
          Ellipse(origin={0.0,-30.0},
            fillColor={128,128,128},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-20.0,-20.0},{20.0,20.0}}),
          Line(origin={0.0,-30.0},
            points={{0.0,60.0},{0.0,90.0}}),
          Ellipse(origin={-0.0,-30.0},
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{-10.0,-10.0},{10.0,10.0}}),
          Polygon(
            origin={-0.0,-30.0},
            rotation=-35.0,
            fillColor={64,64,64},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-7.0,0.0},{-3.0,85.0},{0.0,90.0},{3.0,85.0},{7.0,0.0}})}));
  end Sensors;

  package Electrical
    model DCmotor
      type motorK = Real(quantity = "Torque constant", unit = "Nm/A", min=0);
      type aeroFriction = Real(quantity = "Propeller friction", unit = "Nms", min=0);
      type propellerK = Real(quantity = "Propeller constant", unit = "Ns", min=0);

      parameter Modelica.SIunits.Inertia Jp = 0.002 "Propeller inertia";
      parameter motorK Kt = 2 "Motor current to torque constant";
      parameter aeroFriction bp = 0.004 "Propeller friction force";
      parameter propellerK Kf= 0.01 "Propeller constant";

      Modelica.SIunits.Torque tout "Output torque";
      Modelica.SIunits.Force fout "Output force";
      Modelica.SIunits.AngularVelocity w "Angular speed of motor";

      Modelica.Blocks.Interfaces.RealInput current
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput torque
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      Modelica.Blocks.Interfaces.RealOutput force
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    equation
      tout=Kt*current;
      Jp*der(w)= tout-bp*w;
      fout=w*Kf;
      force = fout;
      torque = tout;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Text(
              extent={{60,46},{100,20}},
              lineColor={28,108,200},
              textString="Lift

"),         Text(
              extent={{64,-34},{96,-50}},
              lineColor={28,108,200},
              textString="T"),
            Text(
              extent={{-62,28},{74,-20}},
              lineColor={28,108,200},
              textString="motor")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end DCmotor;

    model propeller
      Modelica.Mechanics.MultiBody.Forces.Torque torque(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
        annotation (Placement(transformation(extent={{4,12},{24,32}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape4(
        m=0.01,
        r={0.154,0,0},
        I_33=0.001,
        shapeType="cylinder")
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={66,10})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape5(
        m=0.010,
        r={-0.154,0,0},
        I_33=0.001)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={66,-10})));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute
        annotation (Placement(transformation(extent={{4,-10},{24,10}})));
      Modelica.Mechanics.MultiBody.Forces.WorldForce force(
        color={244,0,4},
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
        N_to_m=10)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-14,-10})));

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        annotation (Placement(transformation(extent={{84,-16},{116,16}})));
      Modelica.Blocks.Interfaces.RealInput position
        annotation (Placement(transformation(extent={{-142,-20},{-102,20}})));
      Electrical.DCmotor dCmotor
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      Blocks.Routing.RealExtend realExtend1
        annotation (Placement(transformation(extent={{38,-78},{58,-58}})));
      Modelica.Mechanics.MultiBody.Sensors.RelativeAngularVelocity
        relativeAngularVelocity
        annotation (Placement(transformation(extent={{30,74},{50,94}})));
      Modelica.Mechanics.MultiBody.Forces.Torque torque1
        annotation (Placement(transformation(extent={{4,-50},{24,-30}})));
      Modelica.Blocks.Math.Gain gain(k=-0.004) annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=270,
            origin={40,10})));
      Blocks.Routing.RealExtract realExtract annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=270,
            origin={40,40})));
      Blocks.Routing.RealExtend realExtend2 annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=270,
            origin={40,-10})));
      Modelica.Blocks.Math.Gain gain1(k=k)
        annotation (Placement(transformation(extent={{-30,-78},{-10,-58}})));
      Blocks.Routing.RealExtend realExtend
        annotation (Placement(transformation(extent={{-28,-42},{-18,-32}})));
      parameter Real k=-1
        "Propeller gain. Set to 1 for clockwise, -1 for counterclockwise";
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1e8, uMin=0)
        annotation (Placement(transformation(extent={{-94,-4},{-86,4}})));
    equation
      connect(revolute.frame_b,bodyShape4. frame_a) annotation (Line(
          points={{24,0},{66,0}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape4.frame_a, bodyShape5.frame_a) annotation (Line(
          points={{66,0},{66,0}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_a, force.frame_b) annotation (Line(
          points={{4,0},{-14,0}},
          color={95,95,95},
          thickness=0.5));
      connect(torque.frame_a, force.frame_b) annotation (Line(
          points={{4,22},{-2,22},{-2,0},{-14,0}},
          color={95,95,95},
          thickness=0.5));
      connect(torque.frame_b, bodyShape4.frame_a) annotation (Line(
          points={{24,22},{50,22},{50,0},{66,0}},
          color={95,95,95},
          thickness=0.5));
      connect(force.frame_b, frame_a) annotation (Line(
          points={{-14,0},{-38,0},{-38,58},{86,58},{86,0},{100,0}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeAngularVelocity.frame_a, force.frame_b) annotation (Line(
          points={{30,84},{-38,84},{-38,0},{-14,0},{-14,8.88178e-16}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeAngularVelocity.frame_b, bodyShape4.frame_a) annotation (
          Line(
          points={{50,84},{50,0},{66,0}},
          color={95,95,95},
          thickness=0.5));
      connect(torque1.frame_a, force.frame_b) annotation (Line(
          points={{4,-40},{-2,-40},{-2,0},{-14,0},{-14,8.88178e-16}},
          color={95,95,95},
          thickness=0.5));
      connect(torque1.frame_b, bodyShape4.frame_a) annotation (Line(
          points={{24,-40},{50,-40},{50,0},{66,0},{66,-8.88178e-16}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeAngularVelocity.w_rel, realExtract.u)
        annotation (Line(points={{40,73},{40,46}}, color={0,0,127}));
      connect(realExtract.y, gain.u)
        annotation (Line(points={{40,33.4},{40,17.2}}, color={0,0,127}));
      connect(gain.y, realExtend2.u)
        annotation (Line(points={{40,3.4},{40,-2.8}},
                                                    color={0,0,127}));
      connect(realExtend2.y, torque1.torque) annotation (Line(points={{40,-16.6},
              {8,-16.6},{8,-28}}, color={0,0,127}));
      connect(gain1.y, realExtend1.u)
        annotation (Line(points={{-9,-68},{36,-68}}, color={0,0,127}));
      connect(dCmotor.force, gain1.u) annotation (Line(points={{-51,-4},{-44,-4},
              {-44,-68},{-32,-68}},      color={0,0,127}));
      connect(realExtend1.y, torque.torque) annotation (Line(points={{59,-68},{
              80,-68},{80,76},{8,76},{8,34}}, color={0,0,127}));
      connect(realExtend.y, force.force) annotation (Line(points={{-17.5,-37},{
              -14,-37},{-14,-22}}, color={0,0,127}));
      connect(dCmotor.torque, realExtend.u) annotation (Line(points={{-51,4},{
              -40,4},{-40,-37},{-29,-37}},    color={0,0,127}));
      connect(dCmotor.current, limiter.y)
        annotation (Line(points={{-74,0},{-85.6,0}}, color={0,0,127}));
      connect(position, limiter.u)
        annotation (Line(points={{-122,0},{-94.8,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
              Text(
              extent={{-72,22},{76,-20}},
              lineColor={28,108,200},
              textString="propellerR")}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end propeller;

    model controlModule
      parameter Modelica.SIunits.Time samplePeriod=0.01;
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
              extent={{100,10},{120,30}}), iconTransformation(extent={{100,10},{120,
                30}})));
      Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
              extent={{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,
                70}})));
      Modelica.Blocks.Interfaces.RealOutput y2 annotation (Placement(transformation(
              extent={{100,-30},{120,-10}}), iconTransformation(extent={{100,-30},{120,
                -10}})));
      Modelica.Blocks.Interfaces.RealOutput y3 annotation (Placement(transformation(
              extent={{100,-70},{120,-50}}), iconTransformation(extent={{100,-70},{120,
                -50}})));
      Modelica.Blocks.Interfaces.RealInput GPS[3] annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-100}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-120})));
      Modelica.Blocks.Interfaces.RealInput Gyero[3] annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-100}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120})));
      Modelica.Blocks.Interfaces.RealInput Height annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={60,-120})));
      Blocks.Control.discretePID discretePID(
        ki=1,
        kd=0.8,
        kp=1.5,
        samplePeriod=samplePeriod)
        annotation (Placement(transformation(extent={{-38,-40},{-18,-20}})));
      Blocks.Routing.RealExtract realExtract(index=1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.Interfaces.RealInput position[3]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
            iconTransformation(extent={{-140,-20},{-100,20}})));
      Blocks.Routing.RealExtract realExtract1(index=2)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Blocks.Routing.RealExtract realExtract2(index=3)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      Blocks.Control.discretePID discretePID1(
        kp=0.1,
        kd=0.1,
        samplePeriod=samplePeriod,
        ki=0.03)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Blocks.Control.discretePID discretePID2(
        kd=1,
        kp=1,
        samplePeriod=samplePeriod,
        ki=0.3) annotation (Placement(transformation(extent={{44,20},{64,40}})));
      Blocks.Routing.RealExtract realExtract3(index=2) annotation (Placement(
            transformation(
            extent={{-4,-4},{4,4}},
            rotation=0,
            origin={14,-72})));
      Blocks.Routing.RealExtract realExtract4(index=2)
        annotation (Placement(transformation(extent={{-52,-68},{-44,-60}})));
      parameter Real maxTilt=2 "Upper limits of input signals";
      Modelica.Blocks.Math.Add add(k1=+1)
        annotation (Placement(transformation(extent={{76,16},{84,24}})));
      Modelica.Blocks.Math.Add add1(k1=+1)
        annotation (Placement(transformation(extent={{76,-64},{84,-56}})));
      Blocks.Routing.RealExtract realExtract5
        annotation (Placement(transformation(extent={{-44,-76},{-36,-68}})));
      Blocks.Control.discretePID discretePID3(
        kd=0.1,
        kp=0.1,
        samplePeriod=samplePeriod,
        ki=0.03)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax=0.523)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Blocks.Routing.RealExtract realExtract6(index=1)
        annotation (Placement(transformation(extent={{-60,-60},{-52,-52}})));
      Modelica.Blocks.Math.Add add2(k1=-1)
        annotation (Placement(transformation(extent={{76,56},{84,64}})));
      Modelica.Blocks.Math.Add add3(k1=-1)
        annotation (Placement(transformation(extent={{76,-24},{84,-16}})));
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=0.523)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Blocks.Control.discretePID discretePID4(
        kd=1,
        kp=1,
        samplePeriod=samplePeriod,
        ki=0.1)
        annotation (Placement(transformation(extent={{32,-10},{52,10}})));
      Blocks.Routing.RealExtract realExtract7(index=1) annotation (Placement(
            transformation(
            extent={{-4,-4},{4,4}},
            rotation=0,
            origin={14,-60})));
      Blocks.Routing.RealExtract realExtract8(index=3) annotation (Placement(
            transformation(
            extent={{-4,-4},{4,4}},
            rotation=90,
            origin={-28,58})));
      Blocks.Control.discretePID discretePID5(
        kd=0.08,
        kp=0.04,
        ki=0,
        samplePeriod=samplePeriod)
        annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
      Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=0.1)
        annotation (Placement(transformation(extent={{-2,70},{18,90}})));
      Modelica.Blocks.Interfaces.RealInput yaw
        annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
            iconTransformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Math.Add add4(k2=-1)
        annotation (Placement(transformation(extent={{88,46},{96,54}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{88,6},{96,14}})));
      Modelica.Blocks.Math.Add add6(k2=+1)
        annotation (Placement(transformation(extent={{88,-34},{96,-26}})));
      Modelica.Blocks.Math.Add add7(k2=-1)
        annotation (Placement(transformation(extent={{88,-74},{96,-66}})));
      Modelica.Blocks.Math.Gain gain(k=-1)
        annotation (Placement(transformation(extent={{-10,10},{-4,16}})));
    equation
      connect(position, realExtract.u) annotation (Line(points={{-120,0},{-90,0},
              {-90,30},{-80,30}}, color={0,0,127}));
      connect(position, realExtract1.u)
        annotation (Line(points={{-120,0},{-80,0}}, color={0,0,127}));
      connect(position, realExtract2.u) annotation (Line(points={{-120,0},{-90,0},
              {-90,-30},{-80,-30}},    color={0,0,127}));
      connect(realExtract2.y, discretePID.u)
        annotation (Line(points={{-59,-30},{-38,-30}}, color={0,0,127}));
      connect(realExtract1.y, discretePID1.u)
        annotation (Line(points={{-59,0},{-40,0}}, color={0,0,127}));
      connect(GPS, realExtract4.u) annotation (Line(points={{-60,-100},{-60,-64},
              {-52,-64}}, color={0,0,127}));
      connect(realExtract3.y, discretePID2.u1) annotation (Line(points={{18.4,
              -72},{54,-72},{54,20}}, color={0,0,127}));
      connect(realExtract4.y, discretePID1.u1) annotation (Line(points={{-43.6,
              -64},{-4,-64},{-4,-16},{-30,-16},{-30,-10}}, color={0,0,127}));
      connect(discretePID.y, add.u2) annotation (Line(points={{-17,-30},{26,-30},
              {26,17.6},{75.2,17.6}}, color={0,0,127}));
      connect(discretePID.y, add1.u2) annotation (Line(points={{-17,-30},{26,
              -30},{26,-62.4},{75.2,-62.4}}, color={0,0,127}));
      connect(GPS, realExtract5.u) annotation (Line(points={{-60,-100},{-60,-72},
              {-44,-72}}, color={0,0,127}));
      connect(realExtract5.y, discretePID.u1) annotation (Line(points={{-35.6,
              -72},{-28,-72},{-28,-40}}, color={0,0,127}));
      connect(Gyero, realExtract3.u)
        annotation (Line(points={{0,-100},{0,-72},{10,-72}}, color={0,0,127}));
      connect(discretePID2.u, limiter.y)
        annotation (Line(points={{44,30},{21,30}}, color={0,0,127}));
      connect(realExtract.y, discretePID3.u)
        annotation (Line(points={{-59,30},{-40,30}}, color={0,0,127}));
      connect(realExtract6.u, GPS)
        annotation (Line(points={{-60,-56},{-60,-100}}, color={0,0,127}));
      connect(realExtract6.y, discretePID3.u1) annotation (Line(points={{-51.6,
              -56},{-46,-56},{-46,20},{-30,20}}, color={0,0,127}));
      connect(discretePID3.y, limiter.u)
        annotation (Line(points={{-19,30},{-2,30}}, color={0,0,127}));
      connect(add2.u2, add.u2) annotation (Line(points={{75.2,57.6},{26,57.6},{
              26,17.6},{75.2,17.6}}, color={0,0,127}));
      connect(add3.u2, add.u2) annotation (Line(points={{75.2,-22.4},{48,-22.4},
              {48,-30},{26,-30},{26,17.6},{75.2,17.6}}, color={0,0,127}));
      connect(limiter1.y, discretePID4.u)
        annotation (Line(points={{21,0},{32,0}}, color={0,0,127}));
      connect(realExtract7.u, Gyero)
        annotation (Line(points={{10,-60},{0,-60},{0,-100}}, color={0,0,127}));
      connect(realExtract7.y, discretePID4.u1) annotation (Line(points={{18.4,
              -60},{42,-60},{42,-10}}, color={0,0,127}));
      connect(realExtract8.u, Gyero) annotation (Line(points={{-28,54},{-14,54},
              {-14,-100},{0,-100}}, color={0,0,127}));
      connect(discretePID5.y, limiter2.u)
        annotation (Line(points={{-17,80},{-4,80}}, color={0,0,127}));
      connect(limiter2.y, add1.u1) annotation (Line(points={{19,80},{72,80},{72,
              -57.6},{75.2,-57.6}}, color={0,0,127}));
      connect(add3.u1, add1.u1) annotation (Line(points={{75.2,-17.6},{72,-17.6},
              {72,-57.6},{75.2,-57.6}}, color={0,0,127}));
      connect(add.u1, add1.u1) annotation (Line(points={{75.2,22.4},{72,22.4},{
              72,-57.6},{75.2,-57.6}}, color={0,0,127}));
      connect(add2.u1, add1.u1) annotation (Line(points={{75.2,62.4},{72,62.4},
              {72,-57.6},{75.2,-57.6}}, color={0,0,127}));
      connect(discretePID5.u1, realExtract8.y)
        annotation (Line(points={{-28,70},{-28,62.4}}, color={0,0,127}));
      connect(yaw, discretePID5.u)
        annotation (Line(points={{-120,80},{-80,80},{-80,80},{-38,80}},
                                                      color={0,0,127}));
      connect(add2.y, add4.u1) annotation (Line(points={{84.4,60},{86,60},{86,
              52.4},{87.2,52.4}}, color={0,0,127}));
      connect(add.y, add5.u1) annotation (Line(points={{84.4,20},{87.2,20},{
              87.2,12.4}}, color={0,0,127}));
      connect(add3.y, add6.u1) annotation (Line(points={{84.4,-20},{86,-20},{86,
              -27.6},{87.2,-27.6}}, color={0,0,127}));
      connect(add1.y, add7.u1) annotation (Line(points={{84.4,-60},{86,-60},{86,
              -67.6},{87.2,-67.6}}, color={0,0,127}));
      connect(add4.y, y1) annotation (Line(points={{96.4,50},{98,50},{98,60},{
              110,60}}, color={0,0,127}));
      connect(add5.y, y) annotation (Line(points={{96.4,10},{98,10},{98,20},{
              110,20}}, color={0,0,127}));
      connect(add6.y, y2) annotation (Line(points={{96.4,-30},{98,-30},{98,-20},
              {110,-20}}, color={0,0,127}));
      connect(add7.y, y3) annotation (Line(points={{96.4,-70},{98,-70},{98,-60},
              {110,-60}}, color={0,0,127}));
      connect(discretePID2.y, add5.u2) annotation (Line(points={{65,30},{68,30},
              {68,8},{87.2,8},{87.2,7.6}}, color={0,0,127}));
      connect(discretePID2.y, add7.u2) annotation (Line(points={{65,30},{68,30},
              {68,-72},{87.2,-72},{87.2,-72.4}}, color={0,0,127}));
      connect(discretePID4.y, add6.u2) annotation (Line(points={{53,0},{70,0},{
              70,-32.4},{87.2,-32.4}}, color={0,0,127}));
      connect(discretePID4.y, add4.u2) annotation (Line(points={{53,0},{70,0},{
              70,47.6},{87.2,47.6}}, color={0,0,127}));
      connect(discretePID1.y, gain.u) annotation (Line(points={{-19,0},{-18,0},
              {-18,13},{-10.6,13}}, color={0,0,127}));
      connect(limiter1.u, gain.y)
        annotation (Line(points={{-2,0},{-2,13},{-3.7,13}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-64,74},{66,12}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None,
              textString="MCU"), Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.None)}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end controlModule;
    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Line(
            points={{12,60},{12,-60}}),
          Line(
            points={{-12,60},{-12,-60}}),
          Line(points={{-80,0},{-12,0}}),
          Line(points={{12,0},{80,0}})}));
  end Electrical;

  package Mechanical
    model droneChassis
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(
        r={0,0.25,0},
        r_CM={0,0.175,0},
        m=m)
        annotation (Placement(transformation(extent={{-22,36},{-2,56}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape1(
        r={0.25,0,0},
        r_CM={0.175,0,0},
        m=0.5)            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-12,14})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape2(
        m=0.5,
        r={0,-0.25,0},
        r_CM={0,-0.175,0})
        annotation (Placement(transformation(extent={{-22,-24},{-2,-4}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape3(
        m=0.5,
        r={-0.25,0,0},
        r_CM={-0.175,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-12,-48})));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder(
        density=0,
        r_shape={0,0,0},
        diameter=0.01,
        r={0,0,-length},
        length=length)
        annotation (Placement(transformation(extent={{32,-10},{52,10}})));
      Modelica.Mechanics.MultiBody.Parts.PointMass pointMass(m=0.50,
          sphereColor={255,0,255})
        annotation (Placement(transformation(extent={{52,-10},{72,10}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        annotation (Placement(transformation(extent={{-116,4},{-84,36}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a1
        annotation (Placement(transformation(extent={{-116,44},{-84,76}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a2
        annotation (Placement(transformation(extent={{-116,-36},{-84,-4}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a3
        annotation (Placement(transformation(extent={{-116,-76},{-84,-44}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a4
        annotation (Placement(transformation(extent={{-16,-16},{16,16}},
            rotation=90,
            origin={0,-100})));
      parameter Modelica.SIunits.Length length=0.25 "Length of cylinder";
      parameter Modelica.SIunits.Mass m=1 "Mass of rigid body";
    equation
      connect(bodyShape.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-2,46},{16,46},{16,0},{32,0}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape3.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-2,-48},{16,-48},{16,0},{32,0}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape1.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-2,14},{16,14},{16,0},{32,0}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape2.frame_b, bodyCylinder.frame_a) annotation (Line(
          points={{-2,-14},{16,-14},{16,0},{32,0}},
          color={95,95,95},
          thickness=0.5));
      connect(pointMass.frame_a, bodyCylinder.frame_b) annotation (Line(
          points={{62,0},{52,0}},
          color={95,95,95},
          thickness=0.5));
      connect(frame_a1, bodyShape.frame_a) annotation (Line(
          points={{-100,60},{-62,60},{-62,46},{-22,46}},
          color={95,95,95},
          thickness=0.5));
      connect(frame_a, bodyShape1.frame_a) annotation (Line(
          points={{-100,20},{-62,20},{-62,14},{-22,14}},
          color={95,95,95},
          thickness=0.5));
      connect(frame_a2, bodyShape2.frame_a) annotation (Line(
          points={{-100,-20},{-62,-20},{-62,-14},{-22,-14}},
          color={95,95,95},
          thickness=0.5));
      connect(frame_a3, bodyShape3.frame_a) annotation (Line(
          points={{-100,-60},{-62,-60},{-62,-48},{-22,-48}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder.frame_a, frame_a4) annotation (Line(
          points={{32,0},{16,0},{16,-76},{0,-76},{0,-100}},
          color={95,95,95},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
              Text(
              extent={{-68,26},{70,-26}},
              lineColor={28,108,200},
              textString="droneChassis")}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end droneChassis;
    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
        Rectangle(
          origin={8.6,63.3333},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-4.6,-93.3333},{41.4,-53.3333}}),
        Ellipse(
          origin={9.0,46.0},
          extent={{-90.0,-60.0},{-80.0,-50.0}}),
        Line(
          origin={9.0,46.0},
          points={{-85.0,-55.0},{-60.0,-21.0}},
          thickness=0.5),
        Ellipse(
          origin={9.0,46.0},
          extent={{-65.0,-26.0},{-55.0,-16.0}}),
        Line(
          origin={9.0,46.0},
          points={{-60.0,-21.0},{9.0,-55.0}},
          thickness=0.5),
        Ellipse(
          origin={9.0,46.0},
          fillPattern=FillPattern.Solid,
          extent={{4.0,-60.0},{14.0,-50.0}}),
        Line(
          origin={9.0,46.0},
          points={{-10.0,-26.0},{72.0,-26.0},{72.0,-86.0},{-10.0,-86.0}})}));
  end Mechanical;

   package Tests
    model motorTest
      Electrical.DCmotor dCmotor
        annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
      Modelica.Blocks.Sources.Step step(startTime=1)
        annotation (Placement(transformation(extent={{-86,-2},{-66,18}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={54,-34})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-58,-2},{-38,18}})));
      Modelica.Blocks.Sources.Step step1(startTime=2)
        annotation (Placement(transformation(extent={{-76,-46},{-56,-26}})));
      Electrical.propeller propellerRev1
        annotation (Placement(transformation(extent={{-10,-76},{10,-56}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed1(r={0.5,0,0}) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={54,-66})));
    equation
      connect(propeller1.frame_a, fixed.frame_b) annotation (Line(
          points={{10,-34},{44,-34}},
          color={95,95,95},
          thickness=0.5));
      connect(step.y, feedback.u1)
        annotation (Line(points={{-65,8},{-56,8}}, color={0,0,127}));
      connect(feedback.y, dCmotor.current)
        annotation (Line(points={{-39,8},{-12,8}}, color={0,0,127}));
      connect(propeller1.current, feedback.y) annotation (Line(points={{-12,-34},
              {-24,-34},{-24,8},{-39,8}}, color={0,0,127}));
      connect(step1.y, feedback.u2) annotation (Line(points={{-55,-36},{-48,-36},
              {-48,0}}, color={0,0,127}));
      connect(propellerRev1.position, dCmotor.current) annotation (Line(points=
              {{-12.2,-66},{-24,-66},{-24,8},{-12,8}}, color={0,0,127}));
      connect(propellerRev1.frame_a, fixed1.frame_b) annotation (Line(
          points={{10,-66},{44,-66}},
          color={95,95,95},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end motorTest;

    model chassisTest
      Electrical.propeller propellerRev(k=1)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Mechanical.droneChassis droneChassis1
        annotation (Placement(transformation(extent={{30,-10},{80,10}})));
      Electrical.propeller propellerRev3(k=1)
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Modelica.Blocks.Sources.Step step(startTime=0, height=1)
        annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-72,0},{-56,16}})));
      Modelica.Blocks.Sources.Step step1(height=1, startTime=0.5)
        annotation (Placement(transformation(extent={{-100,-38},{-80,-18}})));
      inner Modelica.Mechanics.MultiBody.World world(n(displayUnit="1") = {0,0,
          -1})
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Electrical.propeller propellerRev1(k=-1)
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Electrical.propeller propellerRev2(k=-1)
        annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={60,-70})));
      Modelica.Mechanics.MultiBody.Sensors.RelativePosition relativePosition(
          resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={44,-36})));
      Modelica.Blocks.Math.Gain gain(k=5)
        annotation (Placement(transformation(extent={{-50,4},{-42,12}})));
    equation
      connect(propellerRev.frame_a, droneChassis1.frame_a1) annotation (Line(
          points={{0,50},{16,50},{16,6},{30,6}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev3.frame_a, droneChassis1.frame_a2) annotation (Line(
          points={{0,-20},{12,-20},{12,-2},{30,-2}},
          color={95,95,95},
          thickness=0.5));
      connect(step.y, feedback.u1)
        annotation (Line(points={{-79,8},{-70.4,8}}, color={0,0,127}));
      connect(step1.y, feedback.u2) annotation (Line(points={{-79,-28},{-64,-28},
              {-64,1.6}}, color={0,0,127}));
      connect(propellerRev2.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{0,-60},{16,-60},{16,-6},{30,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.frame_a, droneChassis1.frame_a) annotation (Line(
          points={{0,20},{12,20},{12,2},{30,2}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.position, propellerRev.position) annotation (Line(
            points={{-22.2,20},{-30,20},{-30,50},{-22.2,50}}, color={0,0,127}));
      connect(feedback.y, gain.u)
        annotation (Line(points={{-56.8,8},{-50.8,8}}, color={0,0,127}));
      connect(gain.y, propellerRev3.position) annotation (Line(points={{-41.6,8},
              {-30,8},{-30,-20},{-22.2,-20}}, color={0,0,127}));
      connect(propellerRev1.position, propellerRev3.position) annotation (Line(
            points={{-22.2,20},{-30,20},{-30,-20},{-22.2,-20}}, color={0,0,127}));
      connect(propellerRev2.position, gain.y) annotation (Line(points={{-22.2,-60},
              {-30,-60},{-30,8},{-41.6,8}}, color={0,0,127}));
      connect(relativePosition.frame_a, fixed.frame_b) annotation (Line(
          points={{54,-36},{58,-36},{58,-60},{60,-60}},
          color={95,95,95},
          thickness=0.5));
      connect(relativePosition.frame_b, droneChassis1.frame_a3) annotation (
          Line(
          points={{34,-36},{28,-36},{28,-6},{30,-6}},
          color={95,95,95},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end chassisTest;

    model simpleHoverTest
      Electrical.propeller propellerRev(k=1)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Mechanical.droneChassis droneChassis1(m=10)
        annotation (Placement(transformation(extent={{30,-10},{80,10}})));
      Electrical.propeller propellerRev3(k=1)
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      inner Modelica.Mechanics.MultiBody.World world(n(displayUnit="1") = {0,0,
          -1})
        annotation (Placement(transformation(extent={{60,40},{80,60}})));
      Electrical.propeller propellerRev1
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Electrical.propeller propellerRev2
        annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-68})));
      Modelica.Mechanics.MultiBody.Sensors.RelativePosition relativePosition
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,-28})));
      Blocks.Routing.RealExtract realExtract annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-76,-40})));
      Modelica.Blocks.Sources.Ramp ramp(height=5, duration=0.5)
        annotation (Placement(transformation(extent={{-118,-10},{-98,10}})));
      Modelica.Blocks.Continuous.PID PID(
        k=1.5,
        Ti=0.8,
        Td=1,
        initType=Modelica.Blocks.Types.InitPID.SteadyState)
        annotation (Placement(transformation(extent={{-58,-6},{-46,6}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
    equation
      connect(propellerRev.frame_a, droneChassis1.frame_a1) annotation (Line(
          points={{0,50},{16,50},{16,6},{30,6}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev3.frame_a, droneChassis1.frame_a2) annotation (Line(
          points={{0,-20},{12,-20},{12,-2},{30,-2}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev2.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{0,-60},{16,-60},{16,-6},{30,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.frame_a, droneChassis1.frame_a) annotation (Line(
          points={{0,20},{12,20},{12,2},{30,2}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.position, propellerRev.position) annotation (Line(
            points={{-22.2,20},{-42,20},{-42,50},{-22.2,50}}, color={0,0,127}));
      connect(propellerRev1.position, propellerRev3.position) annotation (Line(
            points={{-22.2,20},{-42,20},{-42,-20},{-22.2,-20}}, color={0,0,127}));
      connect(relativePosition.frame_b, droneChassis1.frame_a3) annotation (
          Line(
          points={{28,-28},{26,-28},{26,-6},{30,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame_b, relativePosition.frame_a) annotation (Line(
          points={{50,-58},{50,-28},{48,-28}},
          color={95,95,95},
          thickness=0.5));
      connect(relativePosition.r_rel, realExtract.u) annotation (Line(points={{
              38,-17},{66,-17},{66,-92},{-76,-92},{-76,-50}}, color={0,0,127}));
      connect(feedback.u1, ramp.y)
        annotation (Line(points={{-84,0},{-97,0}}, color={0,0,127}));
      connect(feedback.u2, realExtract.y)
        annotation (Line(points={{-76,-8},{-76,-29}}, color={0,0,127}));
      connect(feedback.y, PID.u)
        annotation (Line(points={{-67,0},{-59.2,0}}, color={0,0,127}));
      connect(PID.y, propellerRev3.position) annotation (Line(points={{-45.4,0},
              {-42,0},{-42,-20},{-22.2,-20}}, color={0,0,127}));
      connect(propellerRev2.position, propellerRev3.position) annotation (Line(
            points={{-22.2,-60},{-42,-60},{-42,-20},{-22.2,-20}}, color={0,0,
              127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -120,-100},{100,100}})),                             Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{
                100,100}})));
    end simpleHoverTest;

    model propellerTest
      Modelica.Mechanics.MultiBody.Forces.WorldForce force(
        color={244,0,4},
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
        N_to_m=10)
        annotation (Placement(transformation(extent={{-44,46},{-24,66}})));

      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(
        m=0.5,
        r={0,0.25,0},
        r_CM={0,0.175,0})
        annotation (Placement(transformation(extent={{-10,46},{10,66}})));
      inner Modelica.Mechanics.MultiBody.World world(n(displayUnit="1") = {0,0,-1})
        annotation (Placement(transformation(extent={{-78,-84},{-58,-64}})));
      Modelica.Mechanics.MultiBody.Forces.WorldForce force1(
        color={244,0,4},
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
        N_to_m=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-34,24})));

      Modelica.Blocks.Sources.Constant torque1
                                             [3](k={0,0,-1})
        annotation (Placement(transformation(
            origin={-120,80},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape1(
        m=0.5,
        r={0.25,0,0},
        r_CM={0.175,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,24})));
      Modelica.Mechanics.MultiBody.Forces.WorldForce force2(
        color={244,0,4},
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
        N_to_m=10)
        annotation (Placement(transformation(extent={{-44,-16},{-24,4}})));

      Modelica.Blocks.Sources.Constant torque2(k=1) annotation (Placement(
            transformation(
            origin={-200,14},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape2(
        m=0.5,
        r={0,-0.25,0},
        r_CM={0,-0.175,0})
        annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
      Modelica.Mechanics.MultiBody.Forces.WorldForce force3(
        color={244,0,4},
        resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
        N_to_m=10) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-34,-38})));

      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape3(
        m=0.5,
        r={-0.25,0,0},
        r_CM={-0.175,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,-38})));
      Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder(
        density=0,
        r_shape={0,0,0},
        length=0.25,
        diameter=0.01,
        r={0,0,-0.25})
        annotation (Placement(transformation(extent={{44,0},{64,20}})));
      Modelica.Mechanics.MultiBody.Parts.PointMass pointMass(m=0.50)
        annotation (Placement(transformation(extent={{64,0},{84,20}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape4(
        m=0.01,
        r={0.154,0,0},
        I_33=0.001)
        annotation (Placement(transformation(extent={{72,72},{92,92}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape5(
        m=0.010,
        r={-0.154,0,0},
        I_33=0.001)
        annotation (Placement(transformation(extent={{72,46},{92,66}})));
      Modelica.Mechanics.MultiBody.Forces.Torque torque(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
        annotation (Placement(transformation(extent={{-10,94},{10,114}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute
        annotation (Placement(transformation(extent={{-8,72},{12,92}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape6(
        m=0.01,
        r={0.154,0,0},
        I_33=0.001)
        annotation (Placement(transformation(extent={{246,-216},{266,-196}})));
      Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape7(
        m=0.010,
        r={-0.154,0,0},
        I_33=0.001)
        annotation (Placement(transformation(extent={{246,-242},{266,-222}})));
      Modelica.Blocks.Sources.Constant torque4
                                             [3](k={0,0,1})
        annotation (Placement(transformation(
            origin={126,-144},
            extent={{10,-10},{-10,10}},
            rotation=180)));
      Modelica.Mechanics.MultiBody.Forces.Torque torque5(resolveInFrame=
            Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
        annotation (Placement(transformation(extent={{164,-194},{184,-174}})));
      Modelica.Mechanics.MultiBody.Joints.Revolute revolute1
        annotation (Placement(transformation(extent={{166,-216},{186,-196}})));
      Blocks.Routing.RealExtend realExtend
        annotation (Placement(transformation(extent={{-78,46},{-58,66}})));
      Modelica.Mechanics.MultiBody.Sensors.RelativeAngles relativeAngles
        annotation (Placement(transformation(extent={{18,-84},{38,-64}})));
      Modelica.Mechanics.MultiBody.Sensors.RelativePosition relativePosition
        annotation (Placement(transformation(extent={{18,-114},{38,-94}})));
      Blocks.Routing.RealExtract realExtract annotation (Placement(
            transformation(
            extent={{-7,-7},{7,7}},
            rotation=180,
            origin={-149,-115})));
      Modelica.Blocks.Math.Gain gain(k=15)
        annotation (Placement(transformation(extent={{-146,38},{-126,58}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-176,38},{-156,58}})));
      Modelica.Blocks.Continuous.Derivative
                          realDer(k=5, initType=Modelica.Blocks.Types.Init.SteadyState)
        annotation (Placement(transformation(extent={{-144,-50},{-124,-30}})));
      Modelica.Blocks.Continuous.Integrator integrator(k=10, initType=Modelica.Blocks.Types.Init.SteadyState)
        annotation (Placement(transformation(extent={{-144,-82},{-124,-62}})));
      Modelica.Blocks.Math.Add3
                          sISO
        annotation (Placement(transformation(extent={{-86,-24},{-66,-4}})));
    equation
      connect(force.frame_b, bodyShape.frame_a) annotation (Line(
          points={{-24,56},{-10,56}},
          color={95,95,95},
          thickness=0.5));
      connect(force1.frame_b, bodyShape1.frame_a) annotation (Line(
          points={{-24,24},{-10,24}},
          color={95,95,95},
          thickness=0.5));
      connect(force2.frame_b, bodyShape2.frame_a) annotation (Line(
          points={{-24,-6},{-10,-6}},
          color={95,95,95},
          thickness=0.5));
      connect(force3.frame_b, bodyShape3.frame_a) annotation (Line(
          points={{-24,-38},{-10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape.frame_b, bodyShape3.frame_b) annotation (Line(
          points={{10,56},{28,56},{28,-38},{10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape2.frame_b, bodyShape3.frame_b) annotation (Line(
          points={{10,-6},{28,-6},{28,-38},{10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape1.frame_b, bodyShape3.frame_b) annotation (Line(
          points={{10,24},{28,24},{28,-38},{10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder.frame_a, bodyShape3.frame_b) annotation (Line(
          points={{44,10},{28,10},{28,-38},{10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyCylinder.frame_b, pointMass.frame_a) annotation (Line(
          points={{64,10},{74,10}},
          color={95,95,95},
          thickness=0.5));
      connect(torque.frame_a, bodyShape.frame_a) annotation (Line(
          points={{-10,104},{-20,104},{-20,56},{-10,56}},
          color={95,95,95},
          thickness=0.5));
      connect(torque.frame_b, bodyShape4.frame_a) annotation (Line(
          points={{10,104},{42,104},{42,82},{72,82}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape5.frame_a, bodyShape4.frame_a) annotation (Line(
          points={{72,56},{70,56},{70,82},{72,82}},
          color={95,95,95},
          thickness=0.5));
      connect(torque.torque, torque1.y) annotation (Line(points={{-6,116},{-28,
              116},{-28,80},{-109,80}},  color={0,0,127}));
      connect(revolute.frame_a, bodyShape.frame_a) annotation (Line(
          points={{-8,82},{-20,82},{-20,56},{-10,56}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute.frame_b, bodyShape4.frame_a) annotation (Line(
          points={{12,82},{72,82}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape7.frame_a, bodyShape6.frame_a) annotation (Line(
          points={{246,-232},{244,-232},{244,-206},{246,-206}},
          color={95,95,95},
          thickness=0.5));
      connect(torque5.torque, torque4.y) annotation (Line(points={{168,-172},{146,
              -172},{146,-144},{137,-144}}, color={0,0,127}));
      connect(revolute1.frame_b, bodyShape6.frame_a) annotation (Line(
          points={{186,-206},{246,-206}},
          color={95,95,95},
          thickness=0.5));
      connect(torque5.frame_b, bodyShape7.frame_a) annotation (Line(
          points={{184,-184},{216,-184},{216,-232},{246,-232}},
          color={95,95,95},
          thickness=0.5));
      connect(revolute1.frame_a, torque5.frame_a) annotation (Line(
          points={{166,-206},{158,-206},{158,-184},{164,-184}},
          color={95,95,95},
          thickness=0.5));
      connect(bodyShape2.frame_a, torque5.frame_a) annotation (Line(
          points={{-10,-6},{-16,-6},{-16,-220},{68,-220},{68,-184},{164,-184}},
          color={95,95,95},
          thickness=0.5));
      connect(force.force, realExtend.y)
        annotation (Line(points={{-46,56},{-57,56}}, color={0,0,127}));
      connect(force1.force, realExtend.y) annotation (Line(points={{-46,24},{-46,
              40},{-57,40},{-57,56}}, color={0,0,127}));
      connect(force2.force, realExtend.y) annotation (Line(points={{-46,-6},{-52,
              -6},{-52,56},{-57,56}}, color={0,0,127}));
      connect(force3.force, realExtend.y) annotation (Line(points={{-46,-38},{-46,
              9},{-57,9},{-57,56}}, color={0,0,127}));
      connect(world.frame_b, relativeAngles.frame_a) annotation (Line(
          points={{-58,-74},{18,-74}},
          color={95,95,95},
          thickness=0.5));
      connect(relativeAngles.frame_b, bodyShape3.frame_b) annotation (Line(
          points={{38,-74},{38,10},{28,10},{28,-38},{10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(world.frame_b, relativePosition.frame_a) annotation (Line(
          points={{-58,-74},{-20,-74},{-20,-104},{18,-104}},
          color={95,95,95},
          thickness=0.5));
      connect(relativePosition.frame_b, bodyShape3.frame_b) annotation (Line(
          points={{38,-104},{38,10},{28,10},{28,-38},{10,-38}},
          color={95,95,95},
          thickness=0.5));
      connect(relativePosition.r_rel, realExtract.u) annotation (Line(points={{28,
              -115},{-142,-115},{-142,-115}}, color={0,0,127}));
      connect(torque2.y, feedback.u1) annotation (Line(points={{-189,14},{-182,14},
              {-182,48},{-174,48}}, color={0,0,127}));
      connect(gain.u, feedback.y)
        annotation (Line(points={{-148,48},{-157,48}}, color={0,0,127}));
      connect(feedback.u2, realExtract.y) annotation (Line(points={{-166,40},{
              -166,-115},{-156.7,-115}},           color={0,0,127}));
      connect(integrator.u, feedback.y) annotation (Line(points={{-146,-72},{
              -156,-72},{-156,48},{-157,48}},
                                         color={0,0,127}));
      connect(sISO.u1, gain.y) annotation (Line(points={{-88,-6},{-112,-6},{
              -112,48},{-125,48}}, color={0,0,127}));
      connect(sISO.y, realExtend.u) annotation (Line(points={{-65,-14},{-62,-14},
              {-62,38},{-102,38},{-102,56},{-80,56}}, color={0,0,127}));
      connect(realDer.y, sISO.u2) annotation (Line(points={{-123,-40},{-120,-40},
              {-120,-14},{-88,-14}}, color={0,0,127}));
      connect(integrator.y, sISO.u3) annotation (Line(points={{-123,-72},{-112,
              -72},{-112,-22},{-88,-22}}, color={0,0,127}));
      connect(realDer.u, feedback.y) annotation (Line(points={{-146,-40},{-156,
              -40},{-156,48},{-157,48}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -220,-260},{280,120}})),                             Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{
                280,120}})));
    end propellerTest;

    model noiseTest
      Modelica.Blocks.Noise.BandLimitedWhiteNoise bandLimitedWhiteNoise(
          noisePower=0)
        annotation (Placement(transformation(extent={{-68,34},{-48,54}})));
      Modelica.Blocks.Continuous.Filter filter(
        analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
        filterType=Modelica.Blocks.Types.FilterType.LowPass,
        order=4,
        normalized=true,
        f_cut=5)
        annotation (Placement(transformation(extent={{-26,34},{-6,54}})));
      Modelica.Blocks.Noise.BandLimitedWhiteNoise bandLimitedWhiteNoise1(
          noisePower=0)
        annotation (Placement(transformation(extent={{-64,-66},{-44,-46}})));
      Modelica.Blocks.Continuous.Filter filter1(
        filterType=Modelica.Blocks.Types.FilterType.HighPass,
        order=4,
        f_cut=5,
        analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
        normalized=true)
        annotation (Placement(transformation(extent={{-22,-66},{-2,-46}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{24,-20},{44,0}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{24,-72},{44,-52}})));
      Modelica.Blocks.Continuous.Filter filter2(
        analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
        filterType=Modelica.Blocks.Types.FilterType.LowPass,
        normalized=true,
        order=5,
        f_cut=5)
        annotation (Placement(transformation(extent={{64,-72},{84,-52}})));
      Modelica.Blocks.Continuous.Filter filter3(
        filterType=Modelica.Blocks.Types.FilterType.HighPass,
        analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
        normalized=true,
        f_cut=5,
        order=5)
        annotation (Placement(transformation(extent={{64,-20},{84,0}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{102,-46},{122,-26}})));
      Modelica.Blocks.Sources.Ramp ramp(duration=0.013)
        annotation (Placement(transformation(extent={{-146,-90},{-126,-70}})));
    equation
      connect(bandLimitedWhiteNoise.y, filter.u)
        annotation (Line(points={{-47,44},{-28,44}}, color={0,0,127}));
      connect(bandLimitedWhiteNoise1.y, filter1.u)
        annotation (Line(points={{-43,-56},{-24,-56}}, color={0,0,127}));
      connect(filter.y, add.u1) annotation (Line(points={{-5,44},{10,44},{10,-4},
              {22,-4}}, color={0,0,127}));
      connect(filter1.y, add1.u1)
        annotation (Line(points={{-1,-56},{22,-56}}, color={0,0,127}));
      connect(add1.y, filter2.u)
        annotation (Line(points={{45,-62},{62,-62}}, color={0,0,127}));
      connect(add.y, filter3.u)
        annotation (Line(points={{45,-10},{62,-10}}, color={0,0,127}));
      connect(filter3.y, add2.u1) annotation (Line(points={{85,-10},{92,-10},{
              92,-30},{100,-30}}, color={0,0,127}));
      connect(filter2.y, add2.u2) annotation (Line(points={{85,-62},{92,-62},{
              92,-42},{100,-42}}, color={0,0,127}));
      connect(ramp.y, add.u2) annotation (Line(points={{-125,-80},{-90,-80},{
              -90,-16},{22,-16}}, color={0,0,127}));
      connect(add1.u2, ramp.y) annotation (Line(points={{22,-68},{10,-68},{10,
              -80},{-125,-80}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -160,-100},{140,100}})),                             Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{
                140,100}})));
    end noiseTest;

    model discreteTest
      Modelica.Blocks.Sources.Ramp ramp(duration=0.013)
        annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
      Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
      Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=0.01)
        annotation (Placement(transformation(extent={{48,-10},{68,10}})));
    equation
      connect(ramp.y, sampler.u)
        annotation (Line(points={{-41,0},{-16,0}},  color={0,0,127}));
      connect(sampler.y, zeroOrderHold.u)
        annotation (Line(points={{7,0},{46,0}},    color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end discreteTest;

    model discteteControlTest
      Mechanical.droneChassis droneChassis1
        annotation (Placement(transformation(extent={{30,10},{80,30}})));
      inner Modelica.Mechanics.MultiBody.World world(n(displayUnit="1") = {0,0,
          -1})
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Electrical.propeller propellerRev1
        annotation (Placement(transformation(extent={{-20,30},{0,50}})));
      Electrical.propeller propellerRev2
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-48})));
      Modelica.Mechanics.MultiBody.Sensors.RelativePosition relativePosition
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,-8})));
      Blocks.Routing.RealExtract realExtract annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-76,-20})));
      Modelica.Blocks.Sources.Ramp ramp(height=5, duration=0.5)
        annotation (Placement(transformation(extent={{-130,8},{-110,28}})));
      Blocks.Control.discretePID discretePID(
        ki=1,
        kd=0.8,
        kp=1.5,
        samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-86,8},{-66,28}})));
    equation
      connect(propeller1.frame_a, droneChassis1.frame_a1) annotation (Line(
          points={{0,70},{16,70},{16,26},{30,26}},
          color={95,95,95},
          thickness=0.5));
      connect(propeller3.frame_a, droneChassis1.frame_a2) annotation (Line(
          points={{0,0},{12,0},{12,18},{30,18}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev2.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{0,-40},{16,-40},{16,14},{30,14}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.frame_a, droneChassis1.frame_a) annotation (Line(
          points={{0,40},{12,40},{12,22},{30,22}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.position, propeller1.current) annotation (Line(
            points={{-22.2,40},{-42,40},{-42,70},{-22,70}}, color={0,0,127}));
      connect(propellerRev1.position, propeller3.current) annotation (Line(
            points={{-22.2,40},{-42,40},{-42,0},{-22,0}}, color={0,0,127}));
      connect(relativePosition.frame_b, droneChassis1.frame_a3) annotation (
          Line(
          points={{28,-8},{26,-8},{26,14},{30,14}},
          color={95,95,95},
          thickness=0.5));
      connect(fixed.frame_b, relativePosition.frame_a) annotation (Line(
          points={{50,-38},{50,-8},{48,-8}},
          color={95,95,95},
          thickness=0.5));
      connect(relativePosition.r_rel, realExtract.u) annotation (Line(points={{38,3},{
              66,3},{66,-72},{-76,-72},{-76,-30}},            color={0,0,127}));
      connect(ramp.y, discretePID.u)
        annotation (Line(points={{-109,18},{-86,18}}, color={0,0,127}));
      connect(realExtract.y, discretePID.u1)
        annotation (Line(points={{-76,-9},{-76,8}},    color={0,0,127}));
      connect(discretePID.y, propeller3.current) annotation (Line(points={{-65,18},
              {-42,18},{-42,0},{-22,0}},         color={0,0,127}));
      connect(propellerRev2.position, discretePID.y) annotation (Line(points={{
              -22.2,-40},{-42,-40},{-42,18},{-65,18}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -140,-100},{100,100}})),                             Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{
                100,100}})));
    end discteteControlTest;

    model discretePIDTest
      Blocks.Control.discretePID discretePID(
        kd=0,
        ki=0,
        kp=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Sine sine(freqHz=10)
        annotation (Placement(transformation(extent={{-98,-10},{-78,10}})));
      Modelica.Blocks.Sources.Step step1(height=1)
        annotation (Placement(transformation(extent={{-74,-68},{-54,-48}})));
      Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
      Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
    equation
      connect(step1.y, discretePID.u1)
        annotation (Line(points={{-53,-58},{0,-58},{0,-10}}, color={0,0,127}));
      connect(sine.y, sampler.u)
        annotation (Line(points={{-77,0},{-66,0}}, color={0,0,127}));
      connect(sampler.y, zeroOrderHold.u)
        annotation (Line(points={{-43,0},{-38,0}}, color={0,0,127}));
      connect(discretePID.u, zeroOrderHold.y)
        annotation (Line(points={{-10,0},{-15,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end discretePIDTest;

    model controlModuleTest
      Electrical.controlModule controlModule(maxTilt=0.05, samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-30,8},{-10,28}})));
      Mechanical.droneChassis droneChassis1(length=0.25, m=0.5)
        annotation (Placement(transformation(extent={{44,6},{94,26}})));
      Electrical.propeller propellerRev(k=1)
        annotation (Placement(transformation(extent={{8,36},{28,56}})));
      Electrical.propeller propellerRev3(k=1)
        annotation (Placement(transformation(extent={{8,-4},{28,16}})));
      Electrical.propeller propellerRev1
        annotation (Placement(transformation(extent={{8,16},{28,36}})));
      Electrical.propeller propellerRev2
        annotation (Placement(transformation(extent={{8,-24},{28,-4}})));
      inner Modelica.Mechanics.MultiBody.World world(n(displayUnit="1") = {0,0,
          -1})
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Blocks.Routing.RealExtendMultiple realExtendMultiple
        annotation (Placement(transformation(extent={{-58,8},{-38,28}})));
      Modelica.Blocks.Sources.Ramp ramp(          duration=0.5, height=5)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-50})));
      Sensors.GPS gPS annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={18,-40})));
      Sensors.Accelerometer accelerometer
        annotation (Placement(transformation(extent={{8,-76},{28,-56}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(
        T=0.2,
        y_start=0,
        initType=Modelica.Blocks.Types.Init.InitialOutput)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-20})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-92,36},{-72,56}})));
      Blocks.Sources.circlePath circlePath
        annotation (Placement(transformation(extent={{-92,10},{-72,30}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{10,-36},{-10,-16}})));
    equation
      connect(propellerRev.frame_a, droneChassis1.frame_a1) annotation (Line(
          points={{28,46},{36,46},{36,22},{44,22}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev3.frame_a, droneChassis1.frame_a2) annotation (Line(
          points={{28,6},{32,6},{32,14},{44,14}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev2.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{28,-14},{36,-14},{36,10},{44,10}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.frame_a, droneChassis1.frame_a) annotation (Line(
          points={{28,26},{32,26},{32,18},{44,18}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev.position, controlModule.y1) annotation (Line(points=
              {{5.8,46},{-2,46},{-2,24},{-9,24}}, color={0,0,127}));
      connect(propellerRev1.position, controlModule.y) annotation (Line(points=
              {{5.8,26},{0,26},{0,20},{-9,20}}, color={0,0,127}));
      connect(propellerRev3.position, controlModule.y2) annotation (Line(points=
             {{5.8,6},{0,6},{0,16},{-9,16}}, color={0,0,127}));
      connect(propellerRev2.position, controlModule.y3) annotation (Line(points=
             {{5.8,-14},{-2,-14},{-2,12},{-9,12}}, color={0,0,127}));
      connect(controlModule.position, realExtendMultiple.y) annotation (Line(
            points={{-32,18},{-37,18}},                   color={0,0,127}));
      connect(gPS.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{28,-40},{36,-40},{36,10},{44,10}},
          color={95,95,95},
          thickness=0.5));
      connect(gPS.y, controlModule.GPS) annotation (Line(points={{7,-40},{-26,-40},
              {-26,6}},       color={0,0,127}));
      connect(accelerometer.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{28,-66},{36,-66},{36,10},{44,10}},
          color={95,95,95},
          thickness=0.5));
      connect(accelerometer.y, controlModule.Gyero) annotation (Line(points={{7,-66},
              {-20,-66},{-20,6}},       color={0,0,127}));
      connect(ramp.y, firstOrder1.u)
        annotation (Line(points={{-80,-39},{-80,-32}},   color={0,0,127}));
      connect(controlModule.yaw, const.y) annotation (Line(points={{-32,26},{-36,
              26},{-36,46},{-71,46}},      color={0,0,127}));
      connect(firstOrder1.y, realExtendMultiple.u2) annotation (Line(points={{
              -80,-9},{-80,2},{-64,2},{-64,12},{-58,12}}, color={0,0,127}));
      connect(circlePath.y, realExtendMultiple.u)
        annotation (Line(points={{-71,24},{-58,24}}, color={0,0,127}));
      connect(circlePath.y1, realExtendMultiple.u1) annotation (Line(points={{
              -71,16},{-66,16},{-66,18},{-58,18}}, color={0,0,127}));
      connect(controlModule.Height, const1.y) annotation (Line(points={{-14,6},
              {-14,-26},{-11,-26}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        __Dymola_Commands(file="drone_animation_setup.mos"
            "drone_animation_setup"),
        experiment(StopTime=10));
    end controlModuleTest;

    model controlModuleTest_fmu_inputs
      Electrical.controlModule controlModule(maxTilt=0.05, samplePeriod=0.01)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      Mechanical.droneChassis droneChassis1(length=0.25, m=0.5)
        annotation (Placement(transformation(extent={{44,-12},{94,8}})));
      Electrical.propeller propellerRev(k=1)
        annotation (Placement(transformation(extent={{8,20},{28,40}})));
      Electrical.propeller propellerRev3(k=1)
        annotation (Placement(transformation(extent={{8,-22},{28,-2}})));
      Electrical.propeller propellerRev1(k=-1)
        annotation (Placement(transformation(extent={{8,-2},{28,18}})));
      Electrical.propeller propellerRev2(k=-1)
        annotation (Placement(transformation(extent={{8,-42},{28,-22}})));
      inner Modelica.Mechanics.MultiBody.World world(n(displayUnit="1") = {0,0,
          -1})
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Blocks.Routing.RealExtendMultiple realExtendMultiple
        annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
      Sensors.GPS gPS annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={18,-58})));
      Sensors.Accelerometer accelerometer
        annotation (Placement(transformation(extent={{8,-94},{28,-74}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-36,26})));
      Modelica.Blocks.Interfaces.RealInput xcoord
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput zcoord
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      Modelica.Blocks.Interfaces.RealInput ycoord
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput xgps
        annotation (Placement(transformation(extent={{100,70},{120,90}})));
      Modelica.Blocks.Interfaces.RealOutput ygps
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealOutput zgps
        annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-40})));
    equation
      gPS.y[1] = xgps;
      gPS.y[2] = ygps;
      gPS.y[3] = zgps;
      connect(propellerRev3.frame_a, droneChassis1.frame_a2) annotation (Line(
          points={{28,-12},{32,-12},{32,-4},{44,-4}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev2.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{28,-32},{36,-32},{36,-8},{44,-8}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev1.frame_a, droneChassis1.frame_a) annotation (Line(
          points={{28,8},{32,8},{32,0},{44,0}},
          color={95,95,95},
          thickness=0.5));
      connect(propellerRev.position, controlModule.y1) annotation (Line(points=
              {{5.8,30},{-2,30},{-2,6},{-9,6}}, color={0,0,127}));
      connect(propellerRev1.position, controlModule.y) annotation (Line(points=
              {{5.8,8},{0,8},{0,2},{-9,2}}, color={0,0,127}));
      connect(propellerRev3.position, controlModule.y2) annotation (Line(points=
             {{5.8,-12},{0,-12},{0,-2},{-9,-2}}, color={0,0,127}));
      connect(propellerRev2.position, controlModule.y3) annotation (Line(points=
             {{5.8,-32},{-2,-32},{-2,-6},{-9,-6}}, color={0,0,127}));
      connect(controlModule.position, realExtendMultiple.y) annotation (Line(
            points={{-32,0},{-37,0}},                     color={0,0,127}));
      connect(gPS.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{28,-58},{36,-58},{36,-8},{44,-8}},
          color={95,95,95},
          thickness=0.5));
      connect(gPS.y, controlModule.GPS) annotation (Line(points={{7,-58},{-26,
              -58},{-26,-12}},color={0,0,127}));
      connect(accelerometer.frame_a, droneChassis1.frame_a3) annotation (Line(
          points={{28,-84},{36,-84},{36,-8},{44,-8}},
          color={95,95,95},
          thickness=0.5));
      connect(accelerometer.y, controlModule.Gyero) annotation (Line(points={{7,-84},
              {-20,-84},{-20,-12}},     color={0,0,127}));
      connect(controlModule.yaw, const.y) annotation (Line(points={{-32,8},{-36,
              8},{-36,15},{-36,15}},       color={0,0,127}));
      connect(xcoord, realExtendMultiple.u) annotation (Line(points={{-120,80},{-78,
              80},{-78,6},{-58,6}}, color={0,0,127}));
      connect(ycoord, realExtendMultiple.u1)
        annotation (Line(points={{-120,0},{-58,0}}, color={0,0,127}));
      connect(zcoord, realExtendMultiple.u2) annotation (Line(points={{-120,-80},{-80,
              -80},{-80,-6},{-58,-6}}, color={0,0,127}));
      connect(propellerRev.frame_a, droneChassis1.frame_a1) annotation (Line(
          points={{28,30},{42,30},{42,4},{44,4}},
          color={95,95,95},
          thickness=0.5));
      connect(controlModule.Height, const1.y) annotation (Line(points={{-14,-12},
              {-12,-12},{-12,-40},{-11,-40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={215,215,215},
              lineThickness=1), Bitmap(
              extent={{-98,-98},{98,98}},
              imageSource=
                  "/9j/4AAQSkZJRgABAQEBLAEsAAD/7RMiUGhvdG9zaG9wIDMuMAA4QklNBCUAAAAAABAAAAAAAAAAAAAAAAAAAAAAOEJJTQQ6AAAAAADlAAAAEAAAAAEAAAAAAAtwcmludE91dHB1dAAAAAUAAAAAUHN0U2Jvb2wBAAAAAEludGVlbnVtAAAAAEludGUAAAAAQ2xybQAAAA9wcmludFNpeHRlZW5CaXRib29sAAAAAAtwcmludGVyTmFtZVRFWFQAAAABAAAAAAAPcHJpbnRQcm9vZlNldHVwT2JqYwAAAAwAUAByAG8AbwBmACAAUwBlAHQAdQBwAAAAAAAKcHJvb2ZTZXR1cAAAAAEAAAAAQmx0bmVudW0AAAAMYnVpbHRpblByb29mAAAACXByb29mQ01ZSwA4QklNBDsAAAAAAi0AAAAQAAAAAQAAAAAAEnByaW50T3V0cHV0T3B0aW9ucwAAABcAAAAAQ3B0bmJvb2wAAAAAAENsYnJib29sAAAAAABSZ3NNYm9vbAAAAAAAQ3JuQ2Jvb2wAAAAAAENudENib29sAAAAAABMYmxzYm9vbAAAAAAATmd0dmJvb2wAAAAAAEVtbERib29sAAAAAABJbnRyYm9vbAAAAAAAQmNrZ09iamMAAAABAAAAAAAAUkdCQwAAAAMAAAAAUmQgIGRvdWJAb+AAAAAAAAAAAABHcm4gZG91YkBv4AAAAAAAAAAAAEJsICBkb3ViQG/gAAAAAAAAAAAAQnJkVFVudEYjUmx0AAAAAAAAAAAAAAAAQmxkIFVudEYjUmx0AAAAAAAAAAAAAAAAUnNsdFVudEYjUHhsQHLAAAAAAAAAAAAKdmVjdG9yRGF0YWJvb2wBAAAAAFBnUHNlbnVtAAAAAFBnUHMAAAAAUGdQQwAAAABMZWZ0VW50RiNSbHQAAAAAAAAAAAAAAABUb3AgVW50RiNSbHQAAAAAAAAAAAAAAABTY2wgVW50RiNQcmNAWQAAAAAAAAAAABBjcm9wV2hlblByaW50aW5nYm9vbAAAAAAOY3JvcFJlY3RCb3R0b21sb25nAAAAAAAAAAxjcm9wUmVjdExlZnRsb25nAAAAAAAAAA1jcm9wUmVjdFJpZ2h0bG9uZwAAAAAAAAALY3JvcFJlY3RUb3Bsb25nAAAAAAA4QklNA+0AAAAAABABLAAAAAEAAQEsAAAAAQABOEJJTQQmAAAAAAAOAAAAAAAAAAAAAD+AAAA4QklNBA0AAAAAAAQAAABaOEJJTQQZAAAAAAAEAAAAHjhCSU0D8wAAAAAACQAAAAAAAAAAAQA4QklNJxAAAAAAAAoAAQAAAAAAAAABOEJJTQP1AAAAAABIAC9mZgABAGxmZgAGAAAAAAABAC9mZgABAKGZmgAGAAAAAAABADIAAAABAFoAAAAGAAAAAAABADUAAAABAC0AAAAGAAAAAAABOEJJTQP4AAAAAABwAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAADhCSU0EAAAAAAAAAgADOEJJTQQCAAAAAAAqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOEJJTQQwAAAAAAAVAQEBAQEBAQEBAQEBAQEBAQEBAQEBADhCSU0ELQAAAAAABgABAAAAHThCSU0ECAAAAAAAEAAAAAEAAAJAAAACQAAAAAA4QklNBB4AAAAAAAQAAAAAOEJJTQQaAAAAAANHAAAABgAAAAAAAAAAAAAIAAAACAAAAAAJAEgAZQByAG8ALgAwADAAOQA1AAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAABAAAAABAAAAAAAAbnVsbAAAAAIAAAAGYm91bmRzT2JqYwAAAAEAAAAAAABSY3QxAAAABAAAAABUb3AgbG9uZwAAAAAAAAAATGVmdGxvbmcAAAAAAAAAAEJ0b21sb25nAAAIAAAAAABSZ2h0bG9uZwAACAAAAAAGc2xpY2VzVmxMcwAAAAFPYmpjAAAAAQAAAAAABXNsaWNlAAAAEgAAAAdzbGljZUlEbG9uZwAAAAAAAAAHZ3JvdXBJRGxvbmcAAAAAAAAABm9yaWdpbmVudW0AAAAMRVNsaWNlT3JpZ2luAAAADWF1dG9HZW5lcmF0ZWQAAAAAVHlwZWVudW0AAAAKRVNsaWNlVHlwZQAAAABJbWcgAAAABmJvdW5kc09iamMA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6lvq5etw6/vshu0R7ZzuKO6070DvzPBY8OXxcvH/8ozzGfOn9DT0wvVQ9d72bfb794r4Gfio+Tj5x/pX+uf7d/wH/Jj9Kf26/kv+3P9t////4RCyaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzMiA3OS4xNTkyODQsIDIwMTYvMDQvMTktMTM6MTM6NDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNS41IChXaW5kb3dzKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTctMDItMDdUMjM6NTc6MzBaIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDE3LTAyLTA3VDIzOjU3OjM0WiIgeG1wOk1vZGlmeURhdGU9IjIwMTctMDItMDdUMjM6NTc6MzRaIiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDRhY2U0MTUtYjViMi0yMjQ1LThkOWYtNWM4ZTVlN2Y0OTUzIiB4bXBNTTpEb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6MmY4YzZjMWEtZWQ5MS0xMWU2LWEyOGUtODE5YjdiZDM2YzQ0IiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NjBlY2JmZmQtOTM1OC01OTRjLWExNjgtNmY3MjI0YmVkNDVkIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBwaG90b3Nob3A6SUNDUHJvZmlsZT0ic1JHQiBJRUM2MTk2Ni0yLjEiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjYwZWNiZmZkLTkzNTgtNTk0Yy1hMTY4LTZmNzIyNGJlZDQ1ZCIgc3RFdnQ6d2hlbj0iMjAxNy0wMi0wN1QyMzo1NzozMFoiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1LjUgKFdpbmRvd3MpIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDplMTA4ZGZmNy02MGUxLTE5NDQtYjM1Yi04NTJmM2RlNTFkNmQiIHN0RXZ0OndoZW49IjIwMTctMDItMDdUMjM6NTc6MzRaIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNS41IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvanBlZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iZGVyaXZlZCIgc3RFdnQ6cGFyYW1ldGVycz0iY29udmVydGVkIGZyb20gYXBwbGljYXRpb24vdm5kLmFkb2JlLnBob3Rvc2hvcCB0byBpbWFnZS9qcGVnIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo0NGFjZTQxNS1iNWIyLTIyNDUtOGQ5Zi01YzhlNWU3ZjQ5NTMiIHN0RXZ0OndoZW49IjIwMTctMDItMDdUMjM6NTc6MzRaIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNS41IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6ZTEwOGRmZjctNjBlMS0xOTQ0LWIzNWItODUyZjNkZTUxZDZkIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjYwZWNiZmZkLTkzNTgtNTk0Yy1hMTY4LTZmNzIyNGJlZDQ1ZCIgc3RSZWY6b3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjYwZWNiZmZkLTkzNTgtNTk0Yy1hMTY4LTZmNzIyNGJlZDQ1ZCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8P3hwYWNrZXQgZW5kPSJ3Ij8+/9sAQwABAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECAgEBAgEBAQICAgICAgICAgECAgICAgICAgIC/9sAQwEBAQEBAQEBAQEBAgEBAQICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC/8AAEQgCWAJYAwERAAIRAQMRAf/EAB8AAQAABgMBAQAAAAAAAAAAAAABAgMEBQYHCAoJC//EAFEQAAECBAQDBQUGBQEEBgcJAAEAAgMEBREGByExEkFRCBNhcZEJFIGh8BUiMrHB4QojQtHxUhYXJGIzNENTcpIYJTVEc4KTGSZIVWNkZXSi/8QAHAEBAAMBAQEBAQAAAAAAAAAAAAECBAMFBgcI/8QAPhEBAAIBAQQFCgUDAwQDAQAAAAECEQMEEiExBUFRYXEGEyKBkaGx0eHwFDJCUsEHI0MzU/EVNGKCCJLSov/aAAwDAQACEQMRAD8A9/CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgxtYrFKw/S6hW65UJOk0ekycxUKnU6hMQ5WRkJGUhOjTM3NzMZwbAl4cJjnOc4gABB8S+0P7aTLHAjqhS8r8H4rxXMQosSTlKvEkaZKipzHeGDLfY1PqVUa95jxjDEDvoBc/vmXhAnhQfYbKr/bF2XODI2YMeaj42nMP06oYnZOytJk5qRq9SgioTVHjwaHLQZR0SRdNCSMSBCYyKaf3tuJ5JDkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQWNTqdPo1OnqtVp2VptLpkpMT9QqE9HhyslIyUpCdHmZubmYzgyBLw4LHue9xDWtaSSg8w/tGvaIR8249Qy5y4qExTcpKRNOEzNNdElpvMCoSj7wqnPwjZ0HDsOKzikpR+sRwbNzLe87mFADoP7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"
                   +
                  "YcIPeR8fBOGfufkYmepcRMLZoRpaNMS2IaBh98OHEfDgSFOjVKPEIY4cBjzZ1cA4kW/qYLKJx1fFMRiYzOMvllnNmNnTRMW1XCmIswa/GdKd0+1Oq85KyMeXmWd5AiQYUHuS1hZ/S5gc03BGlz1ruzHLjHNz1d6tuc4etD+FkzXna9kv2rcp6nVZidj4PzYwZmJIQJ2ajTEb3XMbCEeh1GPDMd7iGGp4Aa55vq+YBOpJWDbo9Olu2Meyfq3bFPoWjsn4vVhxDlf9Oe6wthxjT6t8UEeIfDqdPh5oIoCAgICAg4szwyroeeGTuZ2T+JGQn0XMvAuJ8FTz4sPvRKtxDSZqnQJ+G3lHlpqNLzEMjVsSVa4agIPA3ktjPEeX+KMQZX417yUxRgXEdawdXpSOXMiQq3hmqTVDq0F7XHQe+yMe2mrXA7IPWj7O/tnwcxKRTMmMxqsHYupsmyDgavz0e78T0uVhaUCdjxHXiV+Vl2fyHuJdNy0LhJMxBJjB9ZkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEGv4rxPQ8E4YxFjHE9QgUjDmFaHVcR1+qTLuCXp1FokjHqVTnozj+GHCkpaM8/+G3NB+ar23+1DXO1f2jc0M56rFmGS+LsRTD8O02NEc77FwfTQKZhKitBNmGXoUrJCIBvHiRn2u8oOo0vCdHe0AE8R1PTrryFhf8ANB9A8G9nCuYAwVS8bY5pcanVjFMhDn6FQ56A6HOSdEmoYiS1Sn5aK28vFmoLmvgwnNDxBc2I8N7xoQdZJ7G8lhrNeTmpSagRI1Im5eJElmRb/eY8OiQQ2GDwOtuLaE6rVp0m+njdmZ7o9The0VtmZiPW9EH/ANujWMruyZltk12fcq60zOSk4fnMP1bMTMCRl5rA+FJRlRnn06qYaoctG73GNadJTUF0OHOCUkJSJBBj+/i8uemjsebf3rRWvZHOe7uctXacV/t1mZ7eqPm+dFK9or7QOcmpmfjdrDOx03NzESZiwxWqeySbFjRC97JaltoolpGXDnEMhQYMOExtmsY1oAXpRs2zf7VcQ8+dfXzP96Yn1fDDkqme0s9ohT7d12n8xo1v/wAxpOBqlfX/APfYOeSNtb+qfhdmnlpR7Z+aY2jaI/zTnwj5N3kPay+0apwAb2hZmbtb/wBp5b5Vzl9tC44LaSqzsWzT/jx65+afxW0R/kzPfEfJy/lr7Wn2iWJ8U02kT2buEZilwxHqddnJvKDAfHJ0GlQjN1WYa6Rp8uO+MBndQtNYsywW5L4/y66X0PJTyZ2/pXZ9Dz/SV9zZti0ptONbbtptGls1JjnuRe3nNTjw0tO85jm+g8mNh1+nemtl2HV1fNbHXe1tp1IrGabNoxv61o6t6axuU7b2rw6nYTNT2ufbFy3wzh90Ko5ZzmLsRzEadbJ1XL1j5elUeG8xokKPCp9el3RphjY8lLcZc0OjNjvtZoaPyr+k/lV5V+XHlF05G2bToavkt5P6dNGdbT2fzeptW1zG5W1b781pp3mmrtG5FJ3dK2jTObTafuPLroboTya6K6O/DaWrTpnpS9rxp31d6mhoR6Uxau7E2tXeppZmYzeNS3KIhxFIe3Y7bso0Cbwz2f6nbcxsC4vlCbaG/ueYYGvlyX9A/wDT9D91o9cfJ+VRt2v1xXj3T823ynt9e1hCaBPZO9n6d2BfBlsxqcTa99sYRwD8OSiejtDq1L+5b8drRzpWfa7BZEe3yqVUxxTKN2ism8PYUwPU4jJWaxrlpVsQ1acwxGiODIdTqmF65BfEq1FaSPePc5kTcFl4kKBMkGGeWr0diudK82tHVOOPhLrp7dm0RqU3YnrjM48e56HsJY7w3j3DdHxjgiu0nFWFcQSUKo0TENBnYNTpNSk44u2LLTcs4gkah7HcMSG4FkRjHtc0eZMTEzExiYb4mJjMTmJYPHWbWBcs6VM1vH2LsP4RpsnBdMTEzW6lLSRhwWDidE7iI/vHNsNDwhvK6RE2mIiMzPYTMRGZnEPj7nn7crJDBE3N0fJrCdWzdqMu6JC+2pqZdhrCZitJbeBNPgvjz0G/9UJhB5HmtmnsOtfjbFI9s+zqZb7Zp1zFc3n3PlhnN7ZHtkZotmJHCeIMN5NUCYhiE6Uy6pLDiMt+9dz8YYldNzEJ1joZSHJOFvxHdaqbFpU/PE3nv5eyPmy32vUvwrikffW+aOK8b4rx/Wo2IMdYqxJjLEMy90SNV8X1qp4gq0R7yS7/AI2sTUaIBfkxwaLaCy0VrFYxSuMdjhabTObTvZ7/AOWA4zrrr15/H4fkpU9H1pmxHNcHC12kEaAgEEEaHfUc9ETFsZxHBB8aaiOc987NviOcXOfFeyK4lzi46uYCBqQNdlPDERiOCd7nxnPu96o2JZpc4gk2vGiCGYhAvp3vDcMuT938PO19VBvRMxE8Y964giPH1gwXubsYh/lwv/qPsCNOV0WxXqrMspDkohsYkRzibfcgju2XHIx4rbn/AOVg81WZxyjKd2PDC/hScW47tzZYbF0JvHHN97zEficHX/08KrMXx8lmQlqFJRHiJMtMw/YxJl7o79zziOPCFz4dQ2iEaJS4RjTcxJScFgDnRY8WDAhNA1sXxCALac+SLRu9fFomIu0dklg7jZUsc0eJMQxYylLiOq00XD+gQ5Bj/v6bEhW3bdis3jGJnl99Tr5int/4HkhEhYUwjiCvxRxBkxUY0vRZJx1IPATFjFtx/oBt0Vo0545nl61fOVjPDedNs9MyZjOfDuG8y5rD9GoNWpuI61gqeFJEZz5mkxpKDXKBDqc1GIM7FgRIVZhwXua0shxO7F2taBXO5ea9WIlf8+nFp7cPuJ/DDZpNwz2z83cuZmYMKWzR7PlSnpSBxAMj1rLPF1DrUBwadHxBRsQV+3MN4jtdZdt9KtZ57s/H/ho2Tha1e2P5+r3WsqTSRqbfC97W0v4Lz29XZPtcL8XgBfn10O2l0F6yODw6gXtoDcnx80Fw19/geQ+Gp62QVWuB0v62F/r9EE6AgICAddPyQeEf21mWH/o1e0QxNi+nQRTsN5/0Oi5w0pwcGwX16O44bx/Ba5oAMx/tJSPfYo3b/tEwu/GCQxGQudAiNo9TptXfJ1KSjys5JzcnMugTUnOS0RkaWmZePDcHQo8OMxrmuBBa5gKD1ydiXtc0ztEYOZQcRTctLZp4YkoX21Lgw4LMTU2HwQYeKKbBBsHlzmNnoLBaBHeIjQIMaGGh3rQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBB8Ev4gntG4vyo7I0plPgqiYoixM8a0+k46xfS6FV5nD+FsuMOulajWKfWcQysg6Wo05Was+kyUJkaYhujSUGogNc26Dwuwy+biiID3ne/ea5p4g/i/CWEE3ab8tCg7h5b5JYjw3IYJx/jKgz9JpmN6XUsR5dvnoZlXVymUOpspj8TScF9nxaUKq2LDlJgDuZiLIxnQXPEBxWvZdCurNrX41pjh2zP8ADLtOtOnFa1nE26+yIazn/nRnLiifmZDE+aePK/KuHA5lXxHOzsV7BcBkSciO797LD+qIbgWOmi9Wmz7PiLeZrnwz9Hlam0a+cedtET3uBsvIDfeJwMux74Zc5zSQ+I46uLnA3cS7UkknddbxG7ywpp2mJmZnOe33u0tOhO+zpB5uT7vDuTztcDzOnyWOYxM9jZWcx25jh99zZJN7dAQ2452PLfW17rpSeHg52iZjgzDJiPDN4ceND0H4I8ZgtfQDhfp8OSu48uUrsVSpsA4Z+bHKximI3S2hEUHw9PBE709rm/JHEVQhVHGEN0dkVzsLys2O9lJKKXQabiWizk5AJdLXdCiSwcIjb2c1gvfRfj/9YdG+psHkrqRaYrTpHU0u6L7R0ftelo37rU1MbsxGYm3Dm/Rf6c6sV2zpykxE2tsdL9+7pbXoX1K8Oq1fzR1xEZ4M12mKzVBj2nxI/uMxCj4blvdxMU2Te1nc1GpNjBpEIWDoha42Opd5Lyf/AI86mlPkTt2np6ddPU0ekNXfmsREzv6GzzSbYxyrmsd0Y7Wz+rVdSPKPZb3tN6amy03c8cbutqxaIz2zxnvddftp+z6ZRX6j/wBwiQ76bDuplvNfu+9Pa/Lsx+2Eoq0N7ms+wqbGe4gNbA+0WPcSSLNYyacXHyBU789X37kxj9vH1t6omDK1W+GI/C8ClypHHEm5+pzUm1kMauiCDFhvdwhv+rhGu4VZ1cZ45XjTm0T6O7Hbl2cyz7Vp7K1CqVHyqxxmJXK9PzHvUak0nHVeoGW1LnbFjo0aRpMzDbWJri/HwNfx8IBjQ7LlfZ515i16xpx4elPt5OtdaNGN2lpvPjwh1Nza7QGa+dtWjVXMbGFVr3eTD5iDTHTMaHRZR7nFwdCp/euEeMP++mHR45tcxVp09HT0o9CsR39bPfUvqf6ls/D7+8uIhNuve5vbmbX02XRXPWu4U+W/1ba6+Gvoox2cBkYdTDhwvAc06lrgHN9DzuomsZnh7xfw5xn9D3M0H3b94zqdHG7fgR5Ks14dninh1rqHNRIgcWQI8z3bHPe2TgvmIgDQXE90xvFfQ2AuTawuSqzXHrMZ5cU0lPyU6zvXzE1JwjpaNQ6+2PpqbtjUtrYZ8yfJRwx3rRSZ58GxysXDsKzxOwnvG8SchTYeDzLWR5VrWG/RoVcxPBeK1jqyyDaxRnR4cuKrJCNE0hQ4sR8AxDoAyE6ZYxr3kkANaSTfQHRRvV48fuFlpXMVYew1AdM1yrSFKgww4l8/NwpYXaNbCK8EutfQAlRM8fRjM9xPDnwdcMWdrzL6id7BoEOfxRNMDmtdIw/dpDiHN07NgcTdN2Nd4K27brnc9/uUm8dXF1mxV2vMzq4YkGh/Z+FpVxLWmThe/T9iTw/8XNjhY63+mGN9FPm6Rj9UT28FZvae517ruMcW4nivjYgxHWaxEeeItnqjMRYbTfW0uYgYBryaB8FaOGYrwmforMzPOWtgEG33RfewAuDvbrt8048pzwQnH1by5HoonhiMYHNuXWGalj/AmN8F0h0i2qQ6thjFEialOQ5GUhsp03OUyqRokzFBEMCnVd7iAC53d8IBNguOrwtGexo0uNLR3w+pXs2adE7Gvagysz5nPt7GM1Qpeuy1WmcMtp8LBkKg4kps3h7FOHJ185OtqEepxqNNvjyUx7qJMzUvAa5zTxW4ald+k15Zd9P+3aLZ5Pf9g7FtFxxhigYywpVINZw1iekyVbodUljeFPUyoQWx5eMG3JhxeEuZEhn70KLDfDdZzCF5cxMTMTwmOb0YmJjMcYluUJz7/QGiDKy73kbn8jc21QZqGXaC9yLb7/n4oLtptty2+H6ILhAQEBAQdIu3b2B8i+3/AJSuy2zfpsxIVuiPnKnlrmbh9ktCxrlpiWZgNguqlDmZhhhz1LjiFLsqVKmg6SqMCC1kVsOPClpmXDxKZqdj/OfsJ55PyQzerVJJMWQreGsb4Zk5+tUzGOXlSqzqTKYxpOFmTcKeZMMmYcSBN0x0QRoE80SrJmLCiQJqMH3H9kXlp/vTzdrmJapjLHmXFbySmcPYhkMEx6DHodVzGw5XzUpWTxB79WSXyGD4z5LuJ+nw4ExMObUoUJ0+2HEbEih6gUBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBAkDn4eW/9kHy97T3s/c1s285qvn/AJHdtvO7ITGtZw9Q8N1TLupU3Dua/Z1rdLw7JxJWVptXyhr7ZWFFlZp8aYiTzjNRokWLORIjOC7WNDpDSvYfYBzVzIw7jDtFZcZUYDreGq7IV3F9X7LFcxBhfKnP+mQosV81ScT5KYqo3e5R16YmmS0Sej0CrTErHlokaDDcyLEa6CGE9v5kNU8H9njLztS5TYJpdRkOzfLymA8cYOp7YlGkqbkvXo8rT6RU6HBpsu6FTZOg4j+z4boQgOhMkK5FiEMZK3W/YdSIvbSmcRqcvGPnDHtdJ3a6kRmac/CflLyU9laQw72+e1PgTs3zmK5Hs/V3Mx1Rp+E8WYsk4uM8PVDFcrJRZ2m4UMtR5mQjy9QqHcTEKUiPf3ZmGw4LhxRWr0NTX8xTemk3iOycfw8+mhGtfdjU3fGM/wAvSxgf+GYiUOXExWu2OYlTiMcIsCk5GhtOb04IlQzLMZ/jcN220WO3SOYxGj//AF9GqvR8RxnVz6vq3Wp/w9WL5KShyuHO1FhmoOgsLWGvZUVenB5uSON9MxvM8A13DT5Kk7bExidPHr+kOsbJMRw1OXd9XFVV9gZ2pKeHvoebeQ9ca133Ic3NY9w/He3e5bEwrOMadBp3h80rtlIxms+75onZb4nFomfW4rrHsVu3ZSS9shh7KrEjQSA6j5pSUsYg2u1mIKLI2B8XBdo2zR7Zj1OE7JrdkT6/o4ornsqO37QQ4x+zzVqo1l7xMPYyy6rbXBu5YyWxYHuvyAbc9Lq0bVoT/kx4xPyUnZdeP0Z9cfNhMD9intgYIxHPRsUdmjOimU2bwtiimR55mB6lVpNkaZpUV0m18agiaBLp2BAa3qXN818L/UfYdfpbye2XT6N0Z27bdi6S6O2munp8bzTS2msa0xEzHCuje9rf+MS+p8jdo0+j+l9a223jZtn2nZNr0ZvfhWLX0pnTicZ/NetYjvmOTXO05ldmayYwbU5jLLMmWiQqPOy1TExl7jSA6Re6JJTTWzZiUMCB9+NMj7xFzDdroV8T/Q/onpfoHR8rujulujtbo7TttelqaE61JpXVrFdXStbTtPC8YppzMx1Wr28fo/6mbfsPSl+gdr2HatPa7eZ1KakadotNJzp3iLxHGs5taOMc4nsda6Hgovhe94ghTkmO8e2DS3QnyM47uohZEfOsmIXeSbeNr2tZwiIeEk8Itf8AdLX4zFcTjr6n5hFMcbcJnq5M3M4xwzg5roFLkZN080WMKTY2LHDhr/xU/F4jC1Oxc53/ACK1dO9/zcI+/vKd+tImI5/fX8XFGJMfYhxLxQpycfBkC4kU+Ve+FKkcu/1vNOtf8f3b6hoXeunWvKMz2uV7Xv14jsaWXOtbUjTTTa+3orq4hTL7cjtz08EPBJxnr+R5W6ac0M96HEQb38ee25+CGcTxlcQBMR4ghS7HRIh14WA3APNxvZrfE6Jy4yiZjPDjLcKfQy20SdiF79+4huIht12fEGsQ+AsPErnN+xZtstE93a1kJrWMb/S1oa0c9gdfPdc5nM5Wmezgz0vVojbAueLbFrnbaa6ORaL9sM9K1YxOH/iHg9DEcLHyv0v9aqu5HHhjK8WiW1S3DVJSdkJlsOcgzknNQfd5tjZmWiufAiBjYsGKHNiMLy24I5rnaIicRGF684eeScrtUrszGjVmfnJ6ehzE3Ae6dm480We7TceWEOH38RxYxjYQaANgyy61n0Y6nG9ZzM8/4Yabn5WVDe8isBe7hhw23fEiP2DIUJgLop1H3WNcfBRbUrSN618FdO954VymmjGpsmJ+rNlaOyMYRp8nVp1srV6o18Rof9n0VrXRnNbCL38cbuWcMMi3EQDn/GUtqxWsTi3DLROyTXTtaZ9KI5Lz7tgRq3cHlbWxBvtrpyWz9M8eDGlvY32v4XBBsb3A1/fzTjaeyYFvGmocH8b2h3/dt4nRDvtCZdxPw8yumIjETHEcn5O50S2UuLYWJH0qHXYDpaPKzdHmn9xLTkCagmE+BHiC5bu0i2ocARquGrp70xxxh10r7uY7Xeel9oXOPH7YEHA+BsLZYUeZa3uq1VZacrNSfDdoItOp8/wtd4RYkEQr24XuOhp5vvz8PvwWnU/8YrHv+j3p+zIw5J4c7CvZ1pkPMCFmdUTg2NU8S4thTkKcZFxbXq1Uq5iSihsKG0U8UyoVEyPupZDdAEmAWAOaXePrZnUvNq7s9j1dLd83XdtvR2u/EOEzw0t8hobfH5rm6MjBhD/lubD420N/P8kGSYALW05DfQ8tx4ILgE+X11QVA797b6fD61QRDwbfPTQH180E3EL2v9HZAuOt/LVBFBZVKpU6jU6frFXn5Ol0mlSU1UanU6jNQJGn06nyUB8zOz8/OzURkKTkoMtCiRIsWI9sOGyG573BoJQfn+e3R7Z8v2g+3tlBVsgMwML5mYFyhyykqFhmh4cqLpGFi2i5rT3fY+xJBmqo2WNRhfa9HocKn1CGXSENtCgTco9wiRYzw4A7BntS80sCdrrJOo4LynzXp2IJj3vAmZ2K81cXVKqYFxbh3EczJti0yq/aEuXYXpsrMS9LZLxJKYmDDmKRAnn8UJkWXeH6QNMqVPrEhKVOlT8lVKdPQIczJVCnTUCdkZ2WijihTMpNyz3Q5mXe3Vr2OLXDUFBfICAgICAgICAgICAgICAgICAgICAgICAgICAglLh8DuenwQUib/L8kEzb3Gg+QPiQgqXAQaXmHgbCmaOBcY5b45pEvXsGY8wzXMIYqo02wPgVPD+IqbM0qrSTwQeHjkpqKGuH3mP4Xts5oKmtpraLVnE14wiYi0TWeMS/Kk7ZXZwzN9nz2xsbZZwKlUqXi7InMen4jy0xnBESWmarh2BOy2KMsscSUZp1iR6P9mxIvCbMmpeZguN4bgvdia6+jF+cXjEx8fZLxbRbR1pjrpPDw6n6WPs9+19h7twdkbJ7tEUeJKw6rirD0Om4/o8s5t8OZl4eaymY3osSExo93hirw3TMs06mTqcs/UOC8S9Jpe1Z6ns0tF6xaOt3OdFHXa17HbmOaosk778rb/K9tv1QWkWaFrAi2twQRy5X5XG/igs3R+Lfh18B4XFvM6oIseb3b90jm02NvMW+ig+F/tFva1Yo7O+bmIezHkvhCL/vAw1hig4jx1mbiO1RkMOSGKKRBrFLkMCYTbFIxFXnSM5JmLO1BzJKRdFc4yc33TnDro6NtfUikTuxzmeyPnxctbVjRpNpjenqh5c8Z5o4mxtVapValUJx0xWJ6bqNSm401FmqlU52ejxJmcm6lUYv8yZmYsxFiPiEcIc6IeLiXvaejTTiIiM493g8W2tbVmZmcZ9s/fL5uOTENtPH4a316m66q4jGOpKX/XPXkPrkhM4Sd50JPLbXruiJmOuef31IcQtf0/fTREb0dvxSh5J28AB15Ib0RPPPDvZaUpb4zg6ZcYLL/wDRtAMc63sb6QRbmbu/5URWtuMzMxluMlDl5ZrYUvCbCadTw7uNt3udcvdfqfKypeJxnnH31OkRhlWRBp68r/A81yF2zp5ePPS9wh39S9hQnOOg1106kbC36+KLViZnh1NExhmplzgCE9+K8Y0WlRmC4kjNsmak62vDDp8qXxQ4kc2gX5qM9kZW3MfqxLrVint0ytBlPtDAeG6vNyTZyFJQK/X5WYlqXMTcQRYjYElKtaBNxO7gRHFpjt4Wt4ntAIvS/CM27/d99jrX0pnd/T9975iVur1OFTZyrSkCG6dmKvUJiJLu7wQnCdrU3HjQv5JDmgtjEDh1BtYcjx1NS1dK814TX6L6cRbUrE8plgpjG1Zp593odDksLzr4UMTVWdFj1StxnRGh1pWp1hnFKQyD91sGGYo/pevM9PUt12mfv1PRjc046qx9+uVlRsKVarz/ANqVaNPAveY8aozrnGPHiA3bxRZ95jRwQTcua0WuATdatHZb71bX9GIxLPq7RWImtY3plznLScw6ExsKC+IGtAMaIO4g2A3BiC8Qf+FrvNenvRjlnPq+v/DztyZmZ5J4lKe0fz4rv/hwOKEDfkHXMSJvyLfJTNp4zyRNeGN3OWqViPCkWuhtZ3e/ExrQ1zuhdroT1cSfBXi2I4c+9ExicS5Gy4xjkfTJinxqjWvdqw1vDMzU7ITj4pmmNY6P7tHmpLgk5VhiMbeCYd9CYjnPAUb1c8Yzaerw8P5MWmMxiIj75z8HdWj5y5XyFOEzTqzMYkiOb/JkMK06NWqnMxm2b3XAyI2HAiXtd0eMxrQbuNlGJnjHWryzxx2vrD7Ln2n2KOyxifMg5hYDxVN5PYpocgMPZdU7G+EvtI4zhVCAYuNaw+pvdApE4yhQYkmyVkGf8SJwunpmJ7rLNGfadktq7sxMRaOfPPg07PtNdLeiYnd9T7lUr29fZymOET+TGc8oSBxmSqeXNUDbjXhtiKAXc+QWSej9XH56+/5NX47T/bb3fNyRTPbndkKZLBOYRz6plwOJzsGYWqTWfGn43JePIKk7DrRwzX2/Rb8bo9lvZHzb7T/bXdiCbI95q2bFKvbWoZU1l9vG9MnZnx0F/BVnY9eOqJ9cJja9GeufZLfKf7YDsETwb3ub9aphI1FSywzIgcP/AI3QMNxANb8zzVfwmv8As98fNaNq0J/X7pbjJe1M7Bc+Wd12ksJy3Fb7lSoWO6Y4eDzO4UaG6Dcmyj8Nr/7c8PCf5T+J0P8Acj3t5pntEuxFVLCX7UGTwc4A/wDGYph0066a/aUvBtr1sonZ9eOelb2Lef0p5ake1yDTO2L2TquB9n9pbImPxW4R/vUwZBcSdhwzFXYd1XzWpH+O3slaNSk8rx7YbnKdoLImoAe4Z1ZST4fYtMnmXgmZ4if9PdV08W6rNLxzpMeqU79f3R7YbxRMaYSxJEfCw7ijDteiwoXfxIdErtJq0SHB42s758OnTkUshd45o4iOG7gL3ICiYmOcYymJiet80/a/TWOsUdkTF+RuWMpS6jjjPKUqOGpKnVWqQ6NDqlGoEKTr1bpMnUYzu7kqjNuZTZeHFmGulGtjxGTXBBiOe2Evz9cX5f1fK2u1qU7SeSUzQs+ZaRw3S6CM0KTimnZg5bUXDpimlTOEJiVxGynR8FT0u+IJfggVKmVEMMzAif8ADtuGrYVxG3D1Sl56mmPLvgxXRWMZMx2QWufYOcYLYnCTbY2vzFjqg9KXst/at4yyej0bLDHT3Ymykmp6HDmKbFjg1PCInYzGzdYwxMRdWwWOJjR5CITAj2iOhdxHc6I4PZbJT0rUJOWn5GPCm5OdloE7JzUBwfBmZWZhMjy0eE4fihvgxGPaRuHXQXYO/meY5AfXxQTICAgICAgICAgICAgICAgICAgICAgICAgg42FwgoG/52v8dfHVBK3Yeh8PrRBMPT60QCep9SgpPeLen5/4QeWn+Je7EMPM7JjCXbNwZSBGxZki2DgrNb3SBeYqeUmIqneiV6a4G3iCg4wnuF7jfgksVTDyQyXFvR2DVxadGZ4X4x49nrj4MG26WaxrVjjThPh9HzQ/hpe2rEya7Q+LextjarmXwP2hB9uZcicjcErSs4sOSLy2ny/eu4YBruGYMeWLRbvJykSQ1c5TtulwjUr1fD/k2TV47kzz+P1e6Yx72LTvvqRpuD6XXmt6R8ew1O2nif30QWRjcTtNefzOl/iEF1Bhh4Bdptf5+mqC6sxvP10FttRz/dB4o/ba5T4xwv7Tao5vzEpVZDB+YPZvwFT6BU+5nIVKqdcw3U5KmVR9OqMNncvrEk2ishzUERBMQoM/KxC3uorSd/R0/wB68dtf5hi26P7dJ7LfxL5p9/K1HSpwHd+dftSQbChTbtTrOShLIM8eZcDBinm95XseDyprFszylbTFAqDWPjSDmVaXYOJz5HjdMwm2veZp8RojwbA6ngczo8jVTmHPdtHfjrhrxeQ6zgWuBsQd2kaWP+k3CK5z1ohwPPXbfwTkLmBLRZj7zfuwwbGK+/CLf0sAF4jvAX8bImImeUMxBgQ4Fixp4tjEeB3h5fcA0hN32u7q6yOkVwvIbiCAASPA9b8/r1SeMYXZ6TgR4xAYx7r9ASdD0Avy1VZtu8+YwOJcxcv8DMccV4spFNjwxrT2TAnao+wvwtpsl3kW97fia0a6kLlxmeEc1sYxmcOs+Me2lQpDvZbAuFZqqxW8TWVPEMb7Pk73t3jKdKOfGiDmA+JCJ5gK0adp5zg34iY6+zs9jqZi/tIZqY2n5GnVjFtRo1FqNSlJOap2EmwqKBJRYtplsJ8MOiRowlw/hMWI8XIuFeunXMcM+PFW1rYnHBzPVexvlni6kSc/LY1zIl4VWlWT8CuUbEUjDm56DMtJ440SepExwxQS5rg0scx8MtOoISaV4xGazHD7z/CIvMRHGLR4fL+Y5tpzjyUfiPKfCeDMGxYkKYyvw/KyGE6ZNPZGFffIuhPnX1Kfi8L/APaSeloAh+9E926LZj4bWRXObyvo70TNczMdXdHBfS1922LVisW9WJ7cdnwdIY1N/m1OkzMpMPfAn5iFMS/dxYT4L3GFFdDjPcWtgPa57mkF4IIPRZ/RmJi0ZaONZ4TxhkqThSTlCHQ5aXlXhv8A0jWmdniCbkGcmQeAa8g/dRGK/ljBNpnnLeJClyzXs7mA6PGBsYr/AOfGG2piP+7B8bcPkrb2IzHGysd3W2uBR3ROEx3iGCNWQvvxDe/4orxYaDkNOqb0+C1azM45YXxpEqGObChNaToYluOI423c91yfVRme1O7OOHW4sxVgmcmWx40mBFdwvIZsdidPj+SvW8YxPU5zpTMz9+pxdgTAZNf7moQnAmWlpyKyLDex4lBBjTEYNa5ugdONjQ73/EwaaC3XRtWdS/DMxj2Y+cz73LWi1dOnHGc+3PP2RHtdmpaXhw3QYMOFChQYYayHChsa2ExgtwsYxtgALedySbkru5TEVjMRlvjIEGw/lQ7ix0ht5AG/4dNdVOSKxwnHGPBWbBhg/dbbxYC2wtoPukeKZntRNaxnjxXUOLHhk8EzMwiNB3c1MMI5D8EUWTMua+hVSrwiDCrNYhjQAMqk+NALWH/EeKTaZ+4GQhYoxTA0hYmr7La2+1Zt3If95EOv1ZM90eyE5ntX8PHuOIVu7xZW7AW/mTEOLsd/5kE3069U9H9sew3rdVphew8zcfst/wDeeaeAdo0tT4umu/FKfe/dRiv7Y+/Wnft+6ZXbc2MeN/HVZKYH/wCvRqdE8rkQm+fxUTWs/pxPjKYveM8eE90Ltmb2MQLRGYcj9e8oEuOIbm/dxhb9k3KdnvT52+eefVDtV2Mu3ji3spdoXBecJolLnaPT3TFDxdI0eUjyc7O4RrTpeHWYUOCyYcyeLBAgxRAeP5hgfynMjiE4cNo0I1tOaxMxaOMZnhns+rtobTOlqRa0ZrPCcdn0ehD2mHa5yvzzr3s/pDJ7MKl105h1DG+YkoMOV6EMQUSlS8vhaTgTc22QjiZo0z7y+YgwnvbD70y0UND2iIweDuzXf3omJrmPW9vei0VxOYtx9XN0u9rp2R6/m/lHg7tAUWoNxFmbldhhlJrMJ9EkZTEeMMu4L4k8+UmqhSnwoVbq9GjRpuZk+KThx4krNzcDvHkQWKq7y4S0xwlrgdDYgg7g8x8kHOuVONY2Ha7JTDIxaxsZnEOIWLb6gi+otdB+hl7KztDQM/eyNgl8zUBN4ly1d/u7r3eRu8mHytLl4UzhecijUhkTD8eVghx/E+mxOiD6Thw05X1G1+R1HTT5oKodffe+yCdAQEBAQEBAQEBAQEBAQEBAQEBAQEBBAmwv+yCk5+vTf56H68UFs+Ja413t1te4/RBSMfhG40uPHTx5cvRA97byLedtd9CQgk97Y4fi10HgfnugpRI2n4tNdvO2n90Gg5gYRwrmXgnF+XWOaTL13BeO8M1vB+K6LMta+FU8PYip0xSqtKODhYPfKTMXgcBdkRrHtILQVNbTW0WrOJrxhFoi0TWYzE8Jfl/9q3InMv2fnbGxhl7J1OfpmMsiMxqdiPLfGMERIEerUGWnZbE+WuNZSK23G2ao5pkSLwkgTEKZgHVjgvdi1do0az1akce6ccXiYts+ran7J4d8c4l+jZ2H+1Vhvtm9lvKPtE4efLwo+OMOQGYvpEu9rv8AZzMKjWpuOcPxWtuYXc12DMRIINrys9LvGjgV4mpSdO80nnD2qWi9YtHW7OTM80O4A7UnQX/Lp+yosuJU8VnOO9v108d0GSEa1gDawPnz8d90EwjX3N+W9tv00+aD5Ke2swZXsa9iWcj4foNUr8xg3NbAOL6jDpNOmKnMUygS8tiOkVmszEGUhPiQKdAh1WWMzGA4IUNwfFLYYLm7NhmK7REzOMxMfD5Mu2RM6PCM4mJ9TxxwNeEghzXAEOaeJrgdnNcDqN7G9l7jyctlkwCWO5tN2vBILCNix41Y7xBTx5DYIspL1JoFQlpefcG8IiTLCJtulhafgOZG/wDqOijT8JC5701/LPP7x/wiYiYxMZ7+v2uHM0K3h3K+Tp9YnKbUZ2TnIs3DdBiVWRgSsD3SDDjPdEmny7YjoZEVoDe74nbAuJsbRqcLTOKxHOerH8ffgpNI3qxWs2m3V/xzde4/av76abIUHKuuVSZfCLpeHCMSK10NrXPLgInu/cQAxriXxBDaGi91lnbtmjOL2nHZX4drXXZNox+WK57Z+X34tKqXa4zLMyZOl5LTBjlxaxofJTb3H+kfdrjgTqLb3uqT0joR+m9vVELxsWvPO1Y9stSxH2s85sPS749ZwZRcOR+7MSDSpuqYah12YHDxAQaTAZNRoYts+OITP+YlUt0npR/jt7YWjYNWf8sR6lrW85sycY0qRjR8W1aXpdUp8nPtkqc6BSWOhT0rCm2QpltLawxXtZGDXAxHNJabXC1xaJxbHC0RPthlnerM1meNZmOHc4bmZOLEL4ji573/AHnvd95z3G5u9x1cfE6rrFonrwpMZxxYSYkYrL2aSNb6H5KyMcev+Gkxy92IaPDAI7mfl78ruL7nz0skT6cR4Jtyl9Lsg8ZNgQ2YLrEcMkKlF7yhzMV9odOq0UAOlHvcbMk5pwA1NmR+F2giPXS8fq7ObPpXx6M8p5eLsROyr4L3wojC1zS5rmuaQQ4GxB6G4II6hc44cXW2Z6s463UbOzLmJCnImM6HLMdCnIzXYlgBxayVnIphwYNc4WtJbLx3d3CmLANbMcMQkd+bZtekV3b8q3nHH93PEdszETOI482jQtOpmmc2pGfVyz7eH1cIytLa3WZiujHQmGwGFC6BpAPE8f8AiPwXBpikdfFskuWQmhjGhrANA0WAtbly0vsiZrmIxGMMlCi6jWxOl9fO1/rZEVzGOqq7ZFbq3iAcALgkcQJ2PANQDY2625otnvSx48KHDiOixoEvChw+9jRZiNCgQoMFpHFGixIrmthwRsXOIbc2vfRUvOKznhCcZ4RGX1w7I/shswu03gOj5w1/MfBGWOFMV4MnanlrMFkxi6vYpl6pLTBoUzUpCkxoULDuF41Qhwoj4kWNGnxCc6LAkSXDjz02qNK+9WN7qnqzH893UvbZp1aTW3o9ceP3z7nCda9k97QKg4omMPS/ZwxVitsrMRIcDEWC6phav4TqkFjyGTlOrf27BtLRGgOa2YhQI4DuGJBY8Fq9GNs2aYz5zHjE/Jitsuvxr5ve74mMfwvJ/wBmd2/KY1xmeyRnVEYy3E6Qw3K1YHh0PAaVU43Hpta6tG1bNP8Amr7VJ0Np/wBqfdzaHU+w/wBsqig/anZV7Qknw7k5SY1js0OtnSdIigj46q/n9Dq1qz64/lztoa+ZmdG3scd1Ps+59UUvFYyPzkpZh/j+0MqsfSgbbfiMbDwDQNdb8laNTTnlqVn1x81PNasc9O0eqWiTuD8W00kVPCuKabw6O+0cNV2R4TpcH3unstqrRMTymJ9cKzW0c6zHqlr0Zvu/3Y/8h2o4Y7u5dcDQ8MXhPXfopVxjmpd/LusGzMqSOkzBvvtw8fK5TE9gqizhZrmu5fdLXH//ACfEoJu7fc/cceejTt4IIOa5ouQR13Fj0QWrtSehtpsdjpa6DnDs2Q34QzMp+bVPb73WcDzMrDpNNn3vi0ePCqXvD6nKR5cffgw4rYUJ3FLvhPhxR3oLi57X59fR09WJi3ozbrj79rVs+vfTn91a9UvuHmn7UXA9by6laBivKrG2Hqm2TEB03hupULFFHfEbDLeNkOdj0+agQy4aNcyIRexeV509H6s/k1K2jvzHzeh+P0oj0q2j2S842cM3gmt40rWJMvZOrU2i1SO6oT1HqtOl6cabPTcZxmIlPhS07HaabEjODi27e4ixuAAw3MI4a2y62hWLXiMT2Tn2u2ltOlrTNaTxjt4OPqdPugRobg78Lgb9NeiztD09fw/favZhHP6byRr1SEGjZy0J9JpsOPG4YDMa4dZHq+G3NaTbvpiTFZk2/wCp07Cb0Qez+FEDhfU3GhvvbYj4H5ILtr78zpr0/wAFBVafL8jqT033CCqgICAgICAgICAgICAgICAgICAgICCm52lhz+rWQWr3ix6W08+Vr8/zQWrwSDz5crkbkjXpdBaRA+xGpFtBex8NOmpQY+K545G4236n1CCwixy3cnbqUGOj1hsFti61tDY/E/og12axRLtPCYrQfE2sg8z38RV2TZHNLKPCHa9wXT4cfF+TIhYJzQEnDa6ZquVGIKkXUKuTIhi8U0HFk6WOeQeCSxPEJIZLi3obBrYtbRty1OMZ7Y5+2Pgw7bpZrGrEca8J8Po6G/w7Hbbdkzmzjzsh42qvcYLzmbExlluZyPwStJzSw/JcNTpkAxHWhNrWGILhwi3HN0OXH4nq226X+SI4xwn5/fUrserxnTnr5PZVRsTSVTcZhkyyJCuRxggtc69/um9rWsvNeg3mBU2RLBjgRbTW3kd/BBkoczxa39LbfA6i6C8bEPI/A/3QVuMEEOtZzXNc02Ic17S17XD+prmEhwIs4EgghB8iu1v7IHIHP+PVcaZVPlshc0p10acmZig0tsxltiafiF0R0TEWC5d0P7ImosQnvJykOl3EvMSLJzLt9ujturp4refOUjt5x4T8/cyauyaepma+hbu5T4x/MPOn2guxB2kOyzUHszSwDMuw06LFZT8wcKRDibAlThwi0GI2tSUEPpEThiQi6BUoEnGZ3gBab3Xp6W06WtwrbFuyeE/X1PP1NDV0uNq5r2xxj6et1xlrWB0sbEWsQQfEaWupmeLk6gduVrxlTSY8Ilr4WJIQ4he4bEbLGxI8YY9Fn2r/ALbV6vy/GHfZv+40pnv9uHxnxFjLGWGKLHreGKjFlK3Ta3KPg1Hu4c2+nS0dkJkxMNgTAcwh8RsvBLnNI4JhzdC4EeM9l2Fmc5MX4jwDgCvUZ8phWYxXQqkMUGhyEGTnYtdotZmaPUXylQsYknIxu7hxWsh8Dx33CXusSg4pMo57o8WJ3kaNHLnxo8d0SLGjPc0kvixohc6LEN9S4k67qMRGe0c/YXZx4Qwk4i5OGKHc8/8A2bLBvLmF79P9LSntpX4PD1Inzmpw65+LOw5OJMP7uBBix3n+mFDdEeAOYDBf8grKRWZ5RlPHp8pKi9RnZSUcBcwGH36dvyBlpUkQz4RHw/Fc51q15TmXSujaefotVitoEGZbGlqO6cmRE4mTtSiCG6G+/wCOBJyRAhvA2L4sS3MHZc41770TXhOXbzNZiYmM5jDtVgjDUtVafLTcEWa9jXcAJ4obrAuYSPwuFx8nBejGrvV3o4Q8/wAziZiYfSDI7LWFmvTZyexNWY0jBwtFkafUmyEAzddxO6YhOiSX2dB4HBk02DDLJqKWvN+CMGAOiPh/kX9Uv6l7V5EaWybD0N0XTpLpzpPR1dalte/mtj2XQ0r1077RtF81m0VvasV04tTMzETeZmtL/f8AkT5G6XlLbaNq6Q222ydG7FqU07V0o3to19S9ZtGnpxi0VzWJ3rTFpjqrwtaOTcbY4ykwXh6tYBoOGKXVJGqyM1SK9Rqe6VnolTlpiE6BNS+KMYzEOYb3jmuN4UiJuLCe0Fk1LvaOH8g8nPIH+pnlx0z0f5X+U3T20bHbY9Suvsu0bVXV0dPRmJzE9HdEadtC25McI1ttnZaalZnOza9ZzP33S/lT5GeTHR+1dBdD9Gae0efrbT1tLRml7XiYxMbXt1o1I3u2mhGtasx/q6cxiPi/jnCkbCNdjSkMRHUua7ybo0zEcYjoki6KQJaNFOsScl3EQox0Li1sWwEUL+rbadtOYpe2/aIjNsY3p65xHCMzxxHCOUcIfitdSmpG9SN2OzOcdkZ68ds8Z5y1JjiOvU8gddh6FVWatWqpU3VJ1NlY7pOBClZZ8R8O0CPFjTJjOLRMPF4cFsFkP8ABu83dsFl2jVtSYrXhM83bS063zNuOGep1EmZah1Sbo1Rk4mKozYXuMrNtc+Sitv8Az/eZ6NHBdNBhvCDh3RdcPcLhZ6a1qb36pt1zxdbaVbTXqivVDtXllkNj7tY02l5cZjY+wxkxkvAqlCrE/grKTDtJjZgYuqdHl3NgTmMcSxYkTjjGamJt4bMTM7Ch94DDk4OjBzte1+Np3l61ivKMPU32fo8hljgPAeW+EI9Qg4WwBheh4RoDZ+bE1O/ZVCkoUlKPnZhkNgmJt0OHxRXhjGue9xDWjQVWfRzLzMCWtBE1Mse88Ny8tJ1890HbChYjlJyHDMN7ALNI4bDQje6Dk6nTl2tLZksva3DGe22vKzr7INqgz0xawn5q1r2E5GHqBE1TEdguH8Ew3hmDDmhbVsyWTDT/APLHDgf3QYKewVgqrg/aeDsG1S4IcKjhPDVQ4xzB98pb7781OZjlMoxHY43rPZx7Plba8VjIXJCqB+r/AH7KTLyZc+9tS5+HL3P681MampHK9o9c/NWdOk86RPqj5OJqx2FexdXC41TsndniaLi67v8AdPhGUdvvxSFOgm97eqvGvrRy1bR65ROjpTz0q+yHG1S9l37Pmr8ZmuyHk0xz9XOp1Gq9HNzzaaTXIHBv/SArRtW0Ry1re35qTsuzz/hr7HHNX9jn7OSotN+zVSKcTf71FxzmZTC2+n3RCxi4DysrRte0x/ln2RP8K/g9m/2Y9/zcP4g9iF7POZ7x0rlnj2j8V7fZWcONw1t+bWVGZmRodr3+Kt+O2n98f/WFfwOz/s98uv8AmH7E3ImjYNxP/wCj9iDH+Gsde5x6hQKXjXFcjiPCdcrMrAd7hSqxPzNBhzdEko33oRm4MSJ3LorYkSE9geukdIa2c3rW8eGPerOw6WPRmaz45+Lzv4kyazbxj2g8LdkKay8xBgvP/FOJjhOiYLxqyVoktNz5pVYrTZ9mIXxnysXDT6TRKhHh1SCY0lFhQg6HFcHaaadIaP64tWZ7on4M2psOryrMW9zs/hz+H/7fuK63LQqu3JLL+mPiBs1Wa/mfAr7IcrEu2OPsbCFHnJieBglw7u8Pivbjb+Jsau27Nelqbtr73Dlj3z8uZo7Hr0tFsxWY7/vm+cPbo7E+aPYKz0n8nsxYsCuUyepsvibLvMOlSU5J4czCwjM2gxKpSoU458STnpOqCYkajIxYj48nMy7S9zoUxLxInkPW8XHXZyx/j7A+b2X2I8sZKuVXMCgYqoeIMJ0rDdPn6vXZ+r0WpS1QkoUhSaTLxZmd4o0BrHiHDd9yI4O0KD9RHLnF01jnAOC8aT1ArOE57FuFaDiOewviOnTdIr+G6hWKbLT09QaxSp+CyPIVCUnI0eBEhRGhzTBudCCg39j+R00tsRfXc66fRQXLDcAi+378tt/qyCrxdT01HMeuiCqL8/DogigICAgICAgICAgICAgICAgICCkXdOXr03B1QWsSJYHprbptufl5ILck87i2rbgAna/PRBKHbEfvtyHmdUEx0Gug38OdrfBBZRXtF/utNt/u36W0QYSajQ2g/dBFj018D0CDQ61GlyxwMMX/AOUka+NkHCWIYMeJ3ploszBceKxa8O1/8LgbhB1Pzfy2xzmThPFWBuCTq+H8YUGr4arVMrcJwk5+k1qRjSE7KRYbC4Oa6XjusSAWua14HE0FTEzWYtXhas5jxhFoi0TWeMTweeHJX+Hr7VNNzZoeNcQZ2ZfZU4fwfi+BW8O1bCLMQ43zAmZCl1ITFMjy8Cak6ZI0ipvk4cMPdHmJlkOI5xMOM37rturts6lZrGnEb0YnPH5MelscUtFp1JmY5Y4e16z8KYInMN02RpzJmYmRJy8KB30wQ6NGdDhhr48YsYA6M9wc55AA4nEgAWAwtrkSVbOwRYt4gLXseXUnZBmYVSmIYAe1wPh4eSC+ZXCBY38v3QVjWjyv4dd+hHigourb+Rv8flofmg4FzVxTQ5KsSU7iWr0ul4fouHa7NVWPWpqTlKW1j4cMthzMWdiNhRnRI0SQ4YLrui+6GGxj3O4U8Dx5PLN2qOzzifDE/iHMOnUrCmEcOS+QL6nh+n1KYlqDRMV51TeMJGPQIUCZpUKJEnocxgh1UEeBLADvGyzgDHLr6dPademI3pvWOq3H384ZtTZ9G/HG7M9cPktmhgHFnaFwfL5cubhrLXEzqgJs1zGlbnIGX0KNK/y3QzieVo0SLCY+wdDdEk2tcLgvBADtNtppq6V6XrbTm0YziJ784zHYzV2a+nqUvS0Xik8p4c4mO+M8XUKN2FseYHmY0Oexfkfjp0XjbNmiYjxhiCmzcCKO5mJSI0YWlYTpV8uYjSzq4ROIuY1Y9zR/3ZnwrH/6/hsm+r1acR42n/8ALI4j7OkWLTMJUqh0CQo1PoUrOU5lJpk9KQqbIienHVCZnYk5VJmHGjQTMBxNoUSYiPjXIAuRXcpmfT4eEfNfetiPR4z99jVZns0VoubAjVekQKfEZEbMQ6XO0unz5b3T7QzV6rVZh8PvHWhl8vLQ3s7zjBsDbpT8PXE3i157M4jw4Zc7eftwraKZ68TPx4OTqVlHSKVAgSjpjDrJKmsZI02Wj4obEhCnyBkINPbFhSkq1zeORZPMiM715hxIcF4iRg94Gi+2ZiIpiuIxHCeUcnCmy9d/TmefUyGK8BUmptl4FIxZhigSkMObGlmzUV0KMNWw3xIcqB3kUsa0u43O+851rAgLnGvWc79ptLp5ieEViKw0X/dDQG6TGZmHWAbiBIzDx8A+ZFzcKJ2inD0ZnHenzE/uRZlXgCC4Oj5mS7+E3IgUputtxd8yfW3JW/Fx+zh4nmJnnbHqcvYWqeAMIsfDlsWxZ2HEbDa+HEkmNZxwhwiKwQ3XY7gFjrYi3QWmu22rmIpwnv8Av761J2Os4zbk5vo3aRplBw5Ew5Q48lLS8xGmok7Py0hHg1SoMm3ObMS09OMmQ2PKukokSVLOAf8ACxDDJOhXzHSXQPR3SvT/AER5RbZp21Nt6FrNdGkzWdD886lbX07VnevS8xelotG7atbRGaxL2tj6S2vYOiukOh9nvFNm6SnOpaMxq/likxW8WiIrasbtomJzEzHKWg1TNnDjIT5hkKJFcXWhysqw2aXF3CHOiOvCgAaXIceQGq+rjpLU/VpVtnrzaJ/l4E9HaeJxea9nCMfw4kx9mHRKzh2bFSpUODLyXHUZWci1EQI0GYgQXOMKWjvlmww6PCYYLmkkO7xhA42MtXV6QtqREeaiMdeZmV9HYo0pmfOzbPdGHGn+/vspR8t8NQpeiV6Rx7N1CPGxBX5/FUtGp4kp174NOwtK4RdTZaPTqxCL5cPnPtCOZiIHGHDDIrIcDJOtqz+uYa/N0/a3XAOMux1hWWr8bOTJnOHEdQnoMWBhSNSa1UMOScvVIncQ4bqo2crDYs0xj++Pdwnl8Qx4bCYYhnveXjxXxjhHCGlMx3kRQ8TUk1XBmOJGiVLEDWyWHZuJOSVfrFKlpmHNT9Go9UnYsRr6v9l8cMR2ysfunxGx3S72t4XBt1B7VOW0nmRiY5SUvEGW2HaU6Xm5Cn44xPAnzKCM8QPseHX5qXlItaqDYkGLGiOECGIbIrYNohb3hDu9hn2hOcNPp7oFEn6QDCglzKpP0qPVJWGGwy5hMSKxjX8RDQ0t70kuB4Tqg1Sd9pH2wqmS2RzNqmHoZ/CygSVKpPADcWbElKeH2F/9d/RBLIe0C7bsse9le0pm3KuJGkDFk8xot/pZci3wQbvIe0x9oDJW927VWcTLWsXYjZGtbbSYk3D80G1yvtWfaMy1u77V+aRt/wB9M0KZBsdiJihO+N0GyyvtfPaTywHB2pMaxQLf9aouBpq9uvf4UOiDYpX2y/tKpb/8SNUj9PesDZaTN9txEwfr+l0Gfge2v9pRDADs9qdMEW1mcrMsIxPW5/2Wbcb3PigzUv7b32jsKwiZq4Jmrb+95O5evv59zSod/l8EGelfboe0TgEcWNsq5jh5TGTOFbHxcZeLDsd9iEGwwPbye0Ehi0aoZHzQB1MfJ2WYXdb+64jh2+FkHd7sOe29xnmLnJS8te2JDy+w5g7HEaTomGcycE4eiYTlMH4qmpkQJCFjeWn6rOwo2FahFiwpd0+3uXUuYdCjR2xZOJHfADutjDtP9q/Ivt55ddnHPbDmVlUyLzqqVblcpc2sK4Yr+HanWYPuE1HpVOqMSPiick5XF1Pq0ORkqvJCHwRWT8CoSbmy0zC4A+j32dgqtV/D2KavhnC9UxThNs8zCmJqnQqRP4jww2qS8SVqTMO12bk3zdEZMSsaLDjiVjQmxYcZ7XhzXuBDl6nR4cYBzYjSDa2voCEHVTtz9hHJzt/5PSeVuaUSpUKpYdxDJYowJmHhmDTnYuwXU2RZeDXoFJi1OBEgxqZVqFDjSM9LR2ugPJlpvgMeSgFB88MA+zX7UmBKdOZc9kN2Qfs3sqpgxaXXM2qf7z2l+3HmfIw3GA+r4jzJdJSVHwCyZhs7yFT6TUY3u3fAMmINjDYH197H/Z2qvZayVpeUdZztzP7QNRk8Q4kxHN5jZtTUtOYqnZrFE8ypTtPbEgRYr2UeFOe8RJdkxMzUeGZ2I0zDofdshh2shRAdCb6blztT1OupsgyEN2g3PI6kg+XhbZBcA+nxFxfRBVaTYDTn18f1QTg9RYoIoCAgICAgICAgICAgICAgIJXGw9OqC3cbee4G/lv4/kgtHm++o8NxtpqelrIJTra1rW3uL28Lb7IIWtufj8OfQb7oLaI4m4O5vz0sRy6fsgxUeJoTfrz6j5oMBNuJvr4en5bFBqc5LGMTc3HLmOiDCmjQojruDRyvYE230+fkgyUrRZSD96HBYX2H3yAbb7dEF/7pw9By0CCbhZDG1yNfigtYsyBcFjbAdNL7a9UGPizLf9OtrnkeW3TVBj3zIvppvfrrz08wgt3TdhYuG1zfew/wgsok80Aknrrf6sg6hZ/5SZbZ7NmcJ5l4UpGLqaKfWpuiy1ZfP9xSsQwWydPkazLmQm4LmzUGHH+653Hwte5zWhxug+InbNzLx9kf2bsDdm7LuQmMtsN4mxTjmk5hYUfAFeko9EfSID30OVbis1EyNLmpqeE/LvkosHgdAhTMjEgPJcQ+RWW+QuI8a1cVmTwHVMV4HpxiSlYa3HFYwtOT062JAfDh4erU173K+/QwyIIzZ2E+Wjd86XiNaT3sOJz1RxIx1uCO1VjTJ3BFVmMOYfyzzFy/r1MiCTqEjiHB89GnmTboYiwocWalc9IslGbFhEPgR4cpAlZphD4HE3au9EW3JjGeU9U90d/d6+1bd9HejjEc+7v8O98467m/U4kvMQ6NIz8KNMO44M/XYksZiC2BEBdAlKDTIz2Soiua5j4k1NzT2tv3bWus5dYpe2JrHo5jPh148Ofe5zascJnGeXj1Z7p5Ppf7OTCOQvaVxNmthbN7DtZi1ehYfw9iDB8nJYsrVAiRpB1RmqfiSKx9Oj/8eYESYovGH34WTjXtGryFqbvXkrbe6nc/GPs4sm4danKhh7MHGFGw4/if9hT0tS6xM06GR98yVdeyHEm3N/7MTMF4BH80xhoo4Y5cU4nPPg6EZtdm4ZWys5MQK5KY2k405FgUep0KBPMnIUN7feIT8RUYUuLBpMuyXhRWvimcdxxozIbW8R176NNLUvuzM1znnPDuxLjq31KVzGLcurj3uq8KBOxTaBKRH624WSsF+t9re4mx11v0Xf8AC6fbPt+jhO03jhuwz0lQK3NPa0SUaEHkWLoVJhuvfXhEemHw5FW/CaWcb9vd8lZ2rU7K+/5tgnsJzVNp0zUZibiycrKNa6YnJ5uFpWQgAuDf505M0hrG66AX4jfQFTfZNCsZnUmvjj5FNq1rziNOJ9vzZnJ+tZJYxrdUwfVsc12o4wl5dlUo8ph0UOm4crUnBiwIVWo0nWZrCJiTuIZeBFizbWy4dAiy8rFax7nw3E+Hrxt//VujNLZK6et0XrecrtEzW3ntO0ad76d6TFor5u01jTtms2i0xjhbh62nOyxsG26m0TbT27S3J0YiY83eJvWt62jE234iZtGJiJiJzxjj2lxZkxgWi4ijvkpLEn+yM4yV+y5mpV6YmY8GRn5SBN0jEDpiliC10Calo0CK6C4h8LvI8MsYYcIH1dKdi/FzsN/+4ikakRNvz1mbRMVjO96G76WYxiYxM4nHn6kbV+Hjaq/6E3mkzFZxWYisxmcYxbPCM5zE56s8P4tyNwJUTHkK5h0zjWuLXQ41Vq8xBJAJZFhw48++Gbgtc1wbqCHDQr0vwmz2x/axE9eZ+bBO1bRXP9zjHbEOs9Z7K2R+IZmvyFKwhiDEOIsNUSLX6Lg6g1irxqzXqjRn97NOkSJmKQ6HeC5//DRocPvON0JsFpcPH16U09W1NOZtFOGZxz7Ix2cs9b1NG976db3iKzbjiHVTH+NcsKzR5J7cQ5iU6vU6oufMYPxLDlGT9OmpWIBHgzkzChQyHB0IH8FzwWdwkLk6sjlRhl3aVxFEm67GxJhXBuAIE7WIWZtVlJiNSKdXniCyWp1OitqEt3lQjsD+IsiO4GwQww3viQ2OD67dmT2fWVGLaW/GNalapmdOVaY7mM+utbISdHnZd3FPS8pKUiYAjue+Kx3fxIjy5ndmG2GS5B9KqZ7OTLrEMhDkoFAreGv5bWQolCrVQfCgtDQwH7PrMWbgOA+6SAxhJG6DhrMH2RueNLgxqplTHpeZMo0OiNoMeNLYVxYGAXEOBBqkz9n1OLbYNnJd7jo2FrZB0krnZsz7wjVYlAxJkPnZSKvCLryMXKPMKcdEDXcBfLzNJw7My85BLr2iQY8SG64LXEEIK0p2cc/50tEn2fc/Jvi/D7vkdmvEB00tbB/X80G+0rsU9r6tcP2V2Ue0fOcYu13+5nHMkxwNrHjqdJgNb8SEHItL9mv29KsGmU7ImdsPitZ1TodAobb8yftvE0uWCw/qAQchU32SntCqlwW7NVYpwfYg1vH+UlKDQ62sQRMfPczX/lvpsg3qR9jD2/5oNMzlll9R2ut/7WzrwIHNv/qbSos4Rbnug26T9iV20H2dUp7IqjA24u+zLrVUdDuLkcNJwDED97aO+KDcKX7DztGTJAqebmR1KN7EQIeYlYOupsW4ZlQ7bqB4oOQJP2EuZRAdUe0NggDdzaPltiidcNNQx8/iiW4udrtF7aoMqz2IYkmuZWc+cQzGhD4dKympsKFEYQQ9hdUMax7tLSQbtIIOoI0QfTduDcaxcgsrcgMyqnN5rwMmcRYVxJl/mtimkNpWZ9AqOBqpCm8Ix5SrU6oPg+8SlHhxKPEjxIcSJP0iO6Vne+eGxgHP9Ix3WoAhe8RT3pN3tubC7tt9ABcc7BB2JwNjqYnDDbE4rGwPPfRB2VpE4+Mxjr3uGkE8ttLfFBusq4kC5+ralBl4QPW/qUGShN9Ta35H68EGQh2NtzbbxHM3O+6C7bblppbx0PP1QVB56+Auf8oKjTe++/Pwt6fugmQEBAQEBAQEBAQEBAQEBAQUHHW5sdfhp+n7oLdxJ5216gjy9LoKJIJ+eo+gbkfWiCFvO2tufxFvFBSdoARuRoBcg6W0ufNBYRNSdDzO2g5fLyQYyY57X/fQ2+KDCR/vXvt0059fiUGNiQuV/wDFyduWqC0fBF99tOnx80EzC6Fe+21vEdPTmgnfHZbUbW+iLa6XQY+LFZ/qtttqb87X5a/JBZOZx6g6G31t5IKD4FgdN/I/Pz6oMdHhaEkan66+XqgwkyS3i5A6fDltz39UGsT053IdrtfXXlpoSUHBuL6mJWowKi53CyXmIjY7ySGtlKjAZBdEceTGTUOWc7Wwawk7IOiXay7OdI7QNI72Tn4dMxVKPgxZKJNxXMkpmYlZd0rKcUVsNzpKYEKI+GYli0tI4x9xpAebLMftG5sZXZwV6PgzGFdw1RsK4sreFML4Llpl7sGU7DGEai+gy1HnsKv/AOCqjJoyr40++PCdGm5ifjx3xhEcxzA1jtz1yj9oDLTBuZNCpMKk1qeocxNCDLBz3S4kJr3PGuDjHiN45mTlKjEgVGluiEvZL1CCd5iOXRNa3ia25T7pjjEx3xJmazvRzj3x1w+TFDy2np60aZhgW0mIzi3hDmfdbEeS77nE5r9TfYE7q9NabUjMcYzE45ZjhP07lLacxPPOfh1e59F+xbl/N5c5lwMctc6Tl6NJVinVKKXcDI1MrtEicMB79A5vvfcFoOnFDadwFEzM81orEeLuhnd2j4WHcNtdToro83WpqZp0s1kXuy6Wk4UONUYvFfWGDHk4RI0JmHAG4NoS+XWPs7cXYlixWxKhGlYby4d1LxXAuB5Pfe7roOFO9npt9/eI/fRCfvNjRWk33P3HhTmY5TMImsTzjOWQ+w8QRofBL1iqMc8fhZUJtmo22jDhsrec1P3zHrlG5T9seyGDquWOJMROhwqnU6hVXMs2BBnJybnxCNiLshRormw3W5gA23Ki1rWnNrTae+ckVrX8tYr4RhteC+yhi+LVaZXZGaNCmadOS0/I1JgLJmVmpaI2JBjQSf6g4ajUOaS1wLSQYiZrMWicWrxjxTMRMTExmJ5vo9Q5ebkm/Y1YhSkZ89LM+85ohSDpsua+YmZfvXNEuXvY48RcCx8KG0kttevSOl57T0Ok9nvbR19jtnUnTid+1d2YiMViZvWJn8mJia2vynMmxX81fV2DWiupobVHob/CsWzmZzMxFbTj82Y41p1ThZmVFXp7JDiYJ+V7uDJR4p4WzEjEiNhdzFffR0DvA5h5weJn/ZhfRTqblb2nqiZ7sxHJ4kUjUmuJ3omYjl1Zj+Gu5n9iTtHUHH8znxQMps1q/g5k7BxBQsy8hqRV8XzGD5yHDYS7EmEcIxPt/B87CLS336SlJunzEIB73MicTR89MzMzM8Zl7cRiIiOUOgnapz0zAzSgT2B82sWx8YyTnyrJn/bDBrabi/vZCPDmJYTdWqWEZKtQ5tsWCziMWMIjxdj+JrnAkuGJSbzYzbZSMP0Wg5i41laNK0ym0mHJ0WqSmGaLKUqTgU6RiPqE9AgUuQ7qVlIPHMOfDivMMxIsSJEc9xD1p+yRwHMTWU4y8rkvJTdXwnIsq9QmZOMZ4Q52p1N8CNKxp9zf/WEUQ+54orf5fFC4IXFDa17g+6OGsrJWVay0owcNibw/LT8Ov5aIObaLgSVghv8Aw7RYD+kdNUHJVNw7ElmBkvFmYLBY8EGYjwmA7fgY8D5INogUiYFrzM047/emI7gQNrXf5oMhDoriRd8Rx58RLt//ABHUoL6HRtC6w5/0NJ3t0QXLaS8bcNjrbhagpR6NFe02DTf/AJPP5INVn8OxH/0MIub/AHAd9ht1Qa+/Djmuv3EMkDofXbxCC4hUd0Ow7ho5eHh5hBGYpLHNu6XJNtdb3PTxG31qg0GsYTgzXGPdrB3+rXy0tprsg1JuWsmX8RhAadNN7lBvuHcIy9Mex8Jn9QJuOehvb4IOfaC0d2wC44bCx+un7oN8ldhp0/Lfw/ZBmoPDofLxsEGThgG3O/jtoCR4aoL6GLjUgC/x3vc80Fy29tf0568vrVBMgrDpzt8bX2vZBN9fX1yQEBAQEBAQEBAQEBAQEBBK7ztoevzt5hBRI9NvAjY8kFEg6a2Ou/W2vkNR/hBTsduQtcWNrXtsdtT8roJTppbcW5XNvh4+aC2eN9QD8T5fqgs3gi/xJvuP7G5+uYYuO0m5530/P9SgxURhJ6nz3/uN0FsYLibW003QPdSdbH0/LVBbxZRxv9actuaDGR5V/IHb435aeSDGPl3tdz+e++oQUi0gHfofnZBaRYpaOQte+pQYaan+EG+otY33vpf4W+roNSqFahMDuIjY+fIW18boOMq5iaVY2IeM/wBW5A111tf8kHB2JcUScRzrx2BpDmPDwHNLHA34mndou4O/5Xu30BDiSp11kFjmQ3cPd3/rL3M5sAc9xPABw8O4sNDayDzkdu3IA4bzYr+MIUAw8DZj1ubxFRqxDhl0jRsYVRgj4iwlVXs/6o+POw4s9IuNu/hTj2wuOJLRmANGyxySrON8latDiQHxJHD+Yk4ZWOBxQBAncEQ/t6Cx4FixvuVCdEA2c5nFYlBxNhTIajSNMnomInOlpGPLhkXgfwTDobQ50Z0NzGF0OwcGlwFwS4NIdqM+z23vPz+nzt4j/wBcVn1b0Wh11Yx5qP1blc+vMx7phslRn6ZKtmaLhmJAp1GgQxM1OpTDvdpKBIU2VhQXz8/Gd/1enS0tDOriXHkDEexh0OToxmjjiYxziImhy82aDSJZtHw9DfCeI8WRgxYkWPU5mEB/KnJ2diR5mIzeG2LCgm/c3QadRstcZ16O0wKPMv4/wvigQ2AHrx+YQc1Ujs8Y2hsbEdTITnOsXP8AeIYDL2/IIOVcP9nqo/diVeMyVaAOJkM8TzfcAg9NOSDnbDmU1GpIaJSnCPGGhjx4Ye46btBGmvnqg5bpeBnu4Q+DfazGtFhtytYc9kG4VDJ3/aWjxpGXhNhVBjXRadHLbBkyGi0KMbaS8QAMfvw3D92rtoa1tDUi0cp4THd845w46+lGrpzWeccY++yet1nkaJN0/EcCmVGVfKz0nVoMpOykxDtEgx4E2yFHgRYbtHa3BvcODri7SvV1bROje1ZzE1/h52nXd1YrPCYtHxepLsbUjFdFy1hxcKYgkGyrZQFlCxTIzc7Kyn3PwUfEVJmYNQpcEX+7BjNqEKHtCbDYAweI9d80O3jT8Y1WvT8xU5WBCj9449/TsVvnYb3gu1H2jQ5aNDAFrcXEdbctQ+PlUl61DL4MxMBgu7SYnJiqPZ95wJYO7gsBtY3vuTvbUPur7F7DLJudzYe8xJh0PDeHXRYkUsJL5jEEwA1rIYDYTA2CbBo6klziSg9ClOwxAYGkwx4/d32uLeaDbJWiwYdrQ2/+XXbrZBnINOgiwDBcAE2AOunh5/BBfw5GFYWb0PI7/l+6C9ZIsG4t5D4X12P9kFy2RZ0022/ID4oK7ZFumnl/i/ggj7g2+vM9D+vkgsY9Ma4Wt8r3O2v1+aDDR6QLk8Ovl5Dy0KC0+yTpYA76kfJBRiUdxB+7c7AWvbqDdBhJuhEAu4eug5HY/G/9kGvxJDgOrALO+HTX4IK0CBwWHDY+XX890G40hxY5tmnl0N/gg3qXdoCNPCyDMwXnQX0016DfTVBloLhpry0G3qb/AFZBfMdtpY9bjlt+SC6adBr6nX6v8kE43QTDly013031tfUXKCoDf18NPDQ/V0EUBAQEBAQEBAQEBAQEBAP1zQUzYbbgjkB8rbbIKZA2Nj80Ep29dtNd73v1v6oLdzRr8egHmeu6Cg5tzrqTdotrc76eP90FrEba5dp10vfTYIMbGbrca/LXpqNP2QWJhg3vfpp4/BBO2CP9NtND8/RBUELwHkLXOxCCUwGkbfHh5+CChEkWncep38dkGMjSAOw2v9eeqDEx5Fwv93TnpvyI26oMFNShs6w63GnQeul0GmVOXe0OsL2HT5EoOIsRGNDbEPDawO3he9wPNB1ixnUpmCI9nPaA02IPoddkHVbEuJ55kWKGxn6Oda/ENtevkg4nqOYkzIMMKe7yNLNuIcSA5omZduukJryGx4Op/lOItr3b2aghwjjXEoxBJzstIxqJWpSegGBUKJWJenzUpUZcOEQS1Tw9XoRgz0MRGhzRwROF4D4T2vAcg4NrGYWYNMwjEwJRsK4bwvhpsKZloUDD+H6fRpOWl5p3HOMloMB7YEB8Z2saLZ0R4FnPsk8YxnHgOlmPJ+nyrLYmxZDitlITYUGi0WJCrVUc2GXOZB91pkQS8ubud9+amIfCXak7Kta1pWK1jdrX"
                   +
                  "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tYb29UCwI2tpt05/mgmQLWv46oCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWH16oIWFrW0QLa389efKyCXhF76jW/Lz+HNBGwvfTn5aaEnrugcI6emn5IJeEg6fpp6eZQA3qNfodLbIIcOuh6+o3Gm37oHDbS19Rz6ny02QR4NfD/Py0HqgcJB8L/Ifmgmt0GtugtuN/gghw6C/L9fjvdA4Ttfbw38wUEeHlpb63HPkgcI5aa/Xx28kDhHTla37oI2/T4W/e/qghwDX68d0Dh+A5/K36oI2H19eJ9UD6/dBGw6b7+KAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIP/9k=",
              fileName="modelica://DroneSimulation/dronepic.jpg")}), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        __Dymola_Commands(file="drone_animation_setup.mos" "drone_animation_setup"));
    end controlModuleTest_fmu_inputs;

    model controlModuleTest_fmu_main
      Modelica.Blocks.Sources.Ramp ramp(duration=5, height=5)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-56,-10})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-66,18},{-46,38}})));
      controlModuleTest_fmu_inputs controlModuleTest_fmu_inputs1
        annotation (Placement(transformation(extent={{-18,-16},{32,34}})));
    equation
      connect(const.y, controlModuleTest_fmu_inputs1.xcoord) annotation (Line(
            points={{-45,28},{-28,28},{-28,29},{-23,29}}, color={0,0,127}));
      connect(ramp.y, controlModuleTest_fmu_inputs1.zcoord) annotation (Line(
            points={{-45,-10},{-28,-10},{-28,-11},{-23,-11}}, color={0,0,127}));
      connect(controlModuleTest_fmu_inputs1.ycoord,
        controlModuleTest_fmu_inputs1.xcoord) annotation (Line(points={{-23,9},
              {-36,9},{-36,28},{-28,28},{-28,29},{-23,29}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,
                -40},{40,60}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-80,-40},{40,60}})),
        experiment(StopTime=10));
    end controlModuleTest_fmu_main;
    annotation (Icon(graphics={
             Rectangle(
             extent={{-100,100},{100,-100}},
             lineColor={215,215,215},
             lineThickness=1), Bitmap(
             extent={{-98,-98},{98,98}},
             imageSource=
                 "/9j/4AAQSkZJRgABAQEBLAEsAAD/7RMiUGhvdG9zaG9wIDMuMAA4QklNBCUAAAAAABAAAAAAAAAAAAAAAAAAAAAAOEJJTQQ6AAAAAADlAAAAEAAAAAEAAAAAAAtwcmludE91dHB1dAAAAAUAAAAAUHN0U2Jvb2wBAAAAAEludGVlbnVtAAAAAEludGUAAAAAQ2xybQAAAA9wcmludFNpeHRlZW5CaXRib29sAAAAAAtwcmludGVyTmFtZVRFWFQAAAABAAAAAAAPcHJpbnRQcm9vZlNldHVwT2JqYwAAAAwAUAByAG8AbwBmACAAUwBlAHQAdQBwAAAAAAAKcHJvb2ZTZXR1cAAAAAEAAAAAQmx0bmVudW0AAAAMYnVpbHRpblByb29mAAAACXByb29mQ01ZSwA4QklNBDsAAAAAAi0AAAAQAAAAAQAAAAAAEnByaW50T3V0cHV0T3B0aW9ucwAAABcAAAAAQ3B0bmJvb2wAAAAAAENsYnJib29sAAAAAABSZ3NNYm9vbAAAAAAAQ3JuQ2Jvb2wAAAAAAENudENib29sAAAAAABMYmxzYm9vbAAAAAAATmd0dmJvb2wAAAAAAEVtbERib29sAAAAAABJbnRyYm9vbAAAAAAAQmNrZ09iamMAAAABAAAAAAAAUkdCQwAAAAMAAAAAUmQgIGRvdWJAb+AAAAAAAAAAAABHcm4gZG91YkBv4AAAAAAAAAAAAEJsICBkb3ViQG/gAAAAAAAAAAAAQnJkVFVudEYjUmx0AAAAAAAAAAAAAAAAQmxkIFVudEYjUmx0AAAAAAAAAAAAAAAAUnNsdFVudEYjUHhsQHLAAAAAAAAAAAAKdmVjdG9yRGF0YWJvb2wBAAAAAFBnUHNlbnVtAAAAAFBnUHMAAAAAUGdQQwAAAABMZWZ0VW50RiNSbHQAAAAAAAAAAAAAAABUb3AgVW50RiNSbHQAAAAAAAAAAAAAAABTY2wgVW50RiNQcmNAWQAAAAAAAAAAABBjcm9wV2hlblByaW50aW5nYm9vbAAAAAAOY3JvcFJlY3RCb3R0b21sb25nAAAAAAAAAAxjcm9wUmVjdExlZnRsb25nAAAAAAAAAA1jcm9wUmVjdFJpZ2h0bG9uZwAAAAAAAAALY3JvcFJlY3RUb3Bsb25nAAAAAAA4QklNA+0AAAAAABABLAAAAAEAAQEsAAAAAQABOEJJTQQmAAAAAAAOAAAAAAAAAAAAAD+AAAA4QklNBA0AAAAAAAQAAABaOEJJTQQZAAAAAAAEAAAAHjhCSU0D8wAAAAAACQAAAAAAAAAAAQA4QklNJxAAAAAAAAoAAQAAAAAAAAABOEJJTQP1AAAAAABIAC9mZgABAGxmZgAGAAAAAAABAC9mZgABAKGZmgAGAAAAAAABADIAAAABAFoAAAAGAAAAAAABADUAAAABAC0AAAAGAAAAAAABOEJJTQP4AAAAAABwAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAADhCSU0EAAAAAAAAAgADOEJJTQQCAAAAAAAqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOEJJTQQwAAAAAAAVAQEBAQEBAQEBAQEBAQEBAQEBAQEBADhCSU0ELQAAAAAABgABAAAAHThCSU0ECAAAAAAAEAAAAAEAAAJAAAACQAAAAAA4QklNBB4AAAAAAAQAAAAAOEJJTQQaAAAAAANHAAAABgAAAAAAAAAAAAAIAAAACAAAAAAJAEgAZQByAG8ALgAwADAAOQA1AAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAABAAAAABAAAAAAAAbnVsbAAAAAIAAAAGYm91bmRzT2JqYwAAAAEAAAAAAABSY3QxAAAABAAAAABUb3AgbG9uZwAAAAAAAAAATGVmdGxvbmcAAAAAAAAAAEJ0b21sb25nAAAIAAAAAABSZ2h0bG9uZwAACAAAAAAGc2xpY2VzVmxMcwAAAAFPYmpjAAAAAQAAAAAABXNsaWNlAAAAEgAAAAdzbGljZUlEbG9uZwAAAAAAAAAHZ3JvdXBJRGxvbmcAAAAAAAAABm9yaWdpbmVudW0AAAAMRVNsaWNlT3JpZ2luAAAADWF1dG9HZW5lcmF0ZWQAAAAAVHlwZWVudW0AAAAKRVNsaWNlVHlwZQAAAABJbWcgAAAABmJvdW5kc09iamMA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6lvq5etw6/vshu0R7ZzuKO6070DvzPBY8OXxcvH/8ozzGfOn9DT0wvVQ9d72bfb794r4Gfio+Tj5x/pX+uf7d/wH/Jj9Kf26/kv+3P9t////4RCyaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjYtYzEzMiA3OS4xNTkyODQsIDIwMTYvMDQvMTktMTM6MTM6NDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNS41IChXaW5kb3dzKSIgeG1wOkNyZWF0ZURhdGU9IjIwMTctMDItMDdUMjM6NTc6MzBaIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDE3LTAyLTA3VDIzOjU3OjM0WiIgeG1wOk1vZGlmeURhdGU9IjIwMTctMDItMDdUMjM6NTc6MzRaIiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDRhY2U0MTUtYjViMi0yMjQ1LThkOWYtNWM4ZTVlN2Y0OTUzIiB4bXBNTTpEb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6MmY4YzZjMWEtZWQ5MS0xMWU2LWEyOGUtODE5YjdiZDM2YzQ0IiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6NjBlY2JmZmQtOTM1OC01OTRjLWExNjgtNmY3MjI0YmVkNDVkIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBwaG90b3Nob3A6SUNDUHJvZmlsZT0ic1JHQiBJRUM2MTk2Ni0yLjEiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjYwZWNiZmZkLTkzNTgtNTk0Yy1hMTY4LTZmNzIyNGJlZDQ1ZCIgc3RFdnQ6d2hlbj0iMjAxNy0wMi0wN1QyMzo1NzozMFoiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1LjUgKFdpbmRvd3MpIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDplMTA4ZGZmNy02MGUxLTE5NDQtYjM1Yi04NTJmM2RlNTFkNmQiIHN0RXZ0OndoZW49IjIwMTctMDItMDdUMjM6NTc6MzRaIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNS41IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY29udmVydGVkIiBzdEV2dDpwYXJhbWV0ZXJzPSJmcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvanBlZyIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iZGVyaXZlZCIgc3RFdnQ6cGFyYW1ldGVycz0iY29udmVydGVkIGZyb20gYXBwbGljYXRpb24vdm5kLmFkb2JlLnBob3Rvc2hvcCB0byBpbWFnZS9qcGVnIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo0NGFjZTQxNS1iNWIyLTIyNDUtOGQ5Zi01YzhlNWU3ZjQ5NTMiIHN0RXZ0OndoZW49IjIwMTctMDItMDdUMjM6NTc6MzRaIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNS41IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6ZTEwOGRmZjctNjBlMS0xOTQ0LWIzNWItODUyZjNkZTUxZDZkIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjYwZWNiZmZkLTkzNTgtNTk0Yy1hMTY4LTZmNzIyNGJlZDQ1ZCIgc3RSZWY6b3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjYwZWNiZmZkLTkzNTgtNTk0Yy1hMTY4LTZmNzIyNGJlZDQ1ZCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8P3hwYWNrZXQgZW5kPSJ3Ij8+/9sAQwABAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECAgEBAgEBAQICAgICAgICAgECAgICAgICAgIC/9sAQwEBAQEBAQEBAQEBAgEBAQICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC/8AAEQgCWAJYAwERAAIRAQMRAf/EAB8AAQAABgMBAQAAAAAAAAAAAAABAgMEBQYHCAoJC//EAFEQAAECBAQDBQUGBQEEBgcJAAEAAgMEBREGByExEkFRCBNhcZEJFIGh8BUiMrHB4QojQtHxUhYXJGIzNENTcpIYJTVEc4KTGSZIVWNkZXSi/8QAHAEBAAMBAQEBAQAAAAAAAAAAAAECBAMFBgcI/8QAPhEBAAIBAQQFCgUDAwQDAQAAAAECEQMEEiExBUFRYXEGEyKBkaGx0eHwFDJCUsEHI0MzU/EVNGKCCJLSov/aAAwDAQACEQMRAD8A9/CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgxtYrFKw/S6hW65UJOk0ekycxUKnU6hMQ5WRkJGUhOjTM3NzMZwbAl4cJjnOc4gABB8S+0P7aTLHAjqhS8r8H4rxXMQosSTlKvEkaZKipzHeGDLfY1PqVUa95jxjDEDvoBc/vmXhAnhQfYbKr/bF2XODI2YMeaj42nMP06oYnZOytJk5qRq9SgioTVHjwaHLQZR0SRdNCSMSBCYyKaf3tuJ5JDkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQWNTqdPo1OnqtVp2VptLpkpMT9QqE9HhyslIyUpCdHmZubmYzgyBLw4LHue9xDWtaSSg8w/tGvaIR8249Qy5y4qExTcpKRNOEzNNdElpvMCoSj7wqnPwjZ0HDsOKzikpR+sRwbNzLe87mFADoP7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"
                  +
                 "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"
                  +
                 "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tYb29UCwI2tpt05/mgmQLWv46oCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWH16oIWFrW0QLa389efKyCXhF76jW/Lz+HNBGwvfTn5aaEnrugcI6emn5IJeEg6fpp6eZQA3qNfodLbIIcOuh6+o3Gm37oHDbS19Rz6ny02QR4NfD/Py0HqgcJB8L/Ifmgmt0GtugtuN/gghw6C/L9fjvdA4Ttfbw38wUEeHlpb63HPkgcI5aa/Xx28kDhHTla37oI2/T4W/e/qghwDX68d0Dh+A5/K36oI2H19eJ9UD6/dBGw6b7+KAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIP/9k=",
             fileName="modelica://DroneSimulation/dronepic.jpg")}));
   end Tests;

  annotation (uses(Modelica(version="3.2.3")));
end DroneSimulation;
