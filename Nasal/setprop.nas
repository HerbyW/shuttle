#setprop("/instrumentation/altimeter/mmhg", getprop("/environment/config/interpolated/pressure-inhg") * 25.39999);
#setprop("/instrumentation/altimeter/inhg100", getprop("/environment/config/interpolated/pressure-inhg") * 100);

#
# Air and Groundspeed selector for USVP-Instrument
#
setlistener("/tu154/switches/usvp-selector-trans", func 

  { if(getprop("/tu154/switches/usvp-selector-trans") > 0.5)
      {
        setprop("/tu154/instrumentation/usvp/air_ground_speed_kt", getprop("/velocities/groundspeed-kt"));
      }
      else
      {
        setprop("/tu154/instrumentation/usvp/air_ground_speed_kt", getprop("/instrumentation/airspeed-indicator/true-speed-kt"));
      }  
  }
  );

#
# Booster and Tank visibility
#
# create timer with 0.5 second interval
var timerTank = maketimer(0.5, func

{ if(getprop("/consumables/fuel/tank[0]/level-lbs") > 0)
      {
        setprop("/controls/shuttle/external-fuel-tank", 1 );        
      }
      else
      {
        setprop("/controls/shuttle/external-fuel-tank", 0 );
      }  
  }
);

# start the timer (with 0.5 second inverval)
timerTank.start();

var timerBooster = maketimer(0.5, func

{ if(getprop("/consumables/fuel/tank[1]/level-lbs") > 0)
      {
        setprop("/controls/shuttle/solid-rocket-boosters", 1 );        
      }
      else
      {
        setprop("/controls/shuttle/solid-rocket-boosters", 0 );
      }  
  }
);

# start the timer (with 0.5 second inverval)
timerBooster.start();

setprop("fdm/jsbsim/propulsion/engine[2]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[3]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[4]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[5]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[6]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[7]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[8]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[9]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[10]/set-running", 1);
setprop("fdm/jsbsim/propulsion/engine[11]/set-running", 1);

#
# settimer(<function>, <time> [, <realtime=0>]);  0.78539816325  2.35619448975
#
# create timer with 0.05 second interval to set the reverser for YAW-Engine

var timerYAW = maketimer(0.05, func

  { if(getprop("/controls/flight/rudder") <= 0)
      {
        setprop("/fdm/jsbsim/propulsion/engine[11]/yaw-angle-rad", 1 );
        setprop("/controls/engines/engine[11]/reverser", 1 );
        setprop("/sim/input/selected/engine[11]", 1 );
        setprop("/engines/engine[11]/reverser-pos-norm", 1 );
      }
      else
      {
        setprop("/fdm/jsbsim/propulsion/engine[11]/yaw-angle-rad", -1 );
        setprop("/controls/engines/engine[11]/reverser", 0 );
        setprop("/sim/input/selected/engine[11]", 1 );
        setprop("/engines/engine[11]/reverser-pos-norm", 0 );
      }  
  }
);

# start the timer (with 0.05 second inverval)
timerYAW.start();

#
# create timer with 0.05 second interval to set the reverser for Roll-Engines

var timerROLL = maketimer(0.05, func

  { if(getprop("/controls/flight/aileron") <= 0)
      {
        setprop("/fdm/jsbsim/propulsion/engine[3]/pitch-angle-rad", -1 );
        setprop("/controls/engines/engine[3]/reverser", 1 );
        setprop("/sim/input/selected/engine[3]", 1 );
        setprop("/engines/engine[3]/reverser-pos-norm", 1 );
        setprop("/fdm/jsbsim/propulsion/engine[4]/pitch-angle-rad", 1 );
        setprop("/controls/engines/engine[4]/reverser", 0 );
        setprop("/sim/input/selected/engine[4]", 1 );
        setprop("/engines/engine[4]/reverser-pos-norm", 0 );
      }
      else
      {
        setprop("/fdm/jsbsim/propulsion/engine[3]/pitch-angle-rad", 1 );
        setprop("/controls/engines/engine[3]/reverser", 0 );
        setprop("/sim/input/selected/engine[3]", 1 );
        setprop("/engines/engine[3]/reverser-pos-norm", 0 );
        setprop("/fdm/jsbsim/propulsion/engine[4]/pitch-angle-rad", -1 );
        setprop("/controls/engines/engine[4]/reverser", 1 );
        setprop("/sim/input/selected/engine[4]", 1 );
        setprop("/engines/engine[4]/reverser-pos-norm", 1 );
      }  
  }
);

# start the timer (with 0.05 second inverval)
timerROLL.start();

#
# create timer with 0.05 second interval to set the reverser for Pitch-Engines

var timerPITCH = maketimer(0.05, func

  { if(getprop("/controls/flight/elevator-trim") <= 0)
      {
        setprop("/fdm/jsbsim/propulsion/engine[6]/pitch-angle-rad", 1 );
        setprop("/controls/engines/engine[6]/reverser", 0 );
        setprop("/sim/input/selected/engine[6]", 1 );
	setprop("/engines/engine[6]/reverser-pos-norm", 0 );
	setprop("/fdm/jsbsim/propulsion/engine[10]/pitch-angle-rad", -1 );
        setprop("/controls/engines/engine[10]/reverser", 1 );
        setprop("/sim/input/selected/engine[10]", 1 );
	setprop("/engines/engine[10]/reverser-pos-norm", 1 );
      }
      else
      {
        setprop("/fdm/jsbsim/propulsion/engine[6]/pitch-angle-rad", -1 );
	setprop("/controls/engines/engine[6]/reverser", 1 );
	setprop("/sim/input/selected/engine[6]", 1 );
	setprop("/engines/engine[6]/reverser-pos-norm", 1 );
	setprop("/fdm/jsbsim/propulsion/engine[10]/pitch-angle-rad", 1 );
	setprop("/controls/engines/engine[10]/reverser", 0 );
	setprop("/sim/input/selected/engine[10]", 1 );
	setprop("/engines/engine[10]/reverser-pos-norm", 0 );
      }  
  }
);

# start the timer (with 0.05 second inverval)
timerPITCH.start();

#
# create timer with 0.05 second interval to set the reverser for Pitch-Engines

var timerOMS = maketimer(0.05, func

  { if(getprop("/controls/engines/engine[2]/propeller-pitch") >= 0)
      {
        setprop("/fdm/jsbsim/propulsion/engine[2]/pitch-angle-rad", (getprop("/controls/engines/engine[2]/propeller-pitch") * 2 -1)* 0.2 );
        setprop("/controls/engines/engine[2]/reverser", 0 );
        setprop("/sim/input/selected/engine[2]", 1 );
	setprop("/engines/engine[2]/reverser-pos-norm", 0 );
	setprop("/fdm/jsbsim/propulsion/engine[5]/pitch-angle-rad", (getprop("/controls/engines/engine[5]/propeller-pitch") * 2 -1)* 0.2 );
        setprop("/controls/engines/engine[5]/reverser", 0 );
        setprop("/sim/input/selected/engine[5]", 1 );
	setprop("/engines/engine[5]/reverser-pos-norm", 0 );
      }
  }
);

# start the timer (with 0.05 second inverval)
timerOMS.start();



#
# create timer with 0.4 second interval to check the parachute

var timerChute = maketimer(0.4, func

  {  if(getprop("/controls/shuttle/parachute") < 1)
     {
        setprop("/fcs/parachute_reef_pos_norm", 0);
	setprop("/fdm/jsbsim/fcs/parachute_reef_pos_norm", 0);
      }
      else
      {
        setprop("/fcs/parachute_reef_pos_norm", 1);
	setprop("/fdm/jsbsim/fcs/parachute_reef_pos_norm", 1);
      }
   }
);
timerChute.start();

########################################################################################

var gearstate = 0;

setlistener("gear/gear/position-norm", func
  { if (getprop("gear/gear/position-norm") == 1)
    { gearstate = 0 ;}
    if (getprop("gear/gear/position-norm") < 1)
    { gearstate = 1 ;}
    if (getprop("gear/gear/position-norm") == 0)
    { gearstate = 0 ;}
    setprop("gear/state", gearstate)
  }
);

setprop("gear/warning", 0);


var gearwarning = maketimer(0.5, func { 

if ((getprop("gear/gear/position-norm") == 0) and (getprop("/position/altitude-agl-ft") < 350) and (getprop("fdm/jsbsim/environment/terrain-solid") == 1))
    {setprop("gear/warning", 1);}
      else setprop("gear/warning", 0)
 });

gearwarning.start();