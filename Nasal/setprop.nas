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
        setprop("/tu154/instrumentation/usvp/air_ground_speed_kt", getprop("/velocities/airspeed-kt"));
      }
  
  }
  );

#
#Setlistener for Booster and Tank visibility
#
#setlistener("/controls/shuttle/external-fuel-tank", func 
#
#  { if(getprop("/consumables/fuel/tank[0]/level-lbs") > 100)
#  {
#  setprop("/controls/shuttle/external-fuel-tank", 1 );
#      }
#      else
#      {
#        setprop("/controls/shuttle/external-fuel-tank", 0 );
#      }  
#  }
#  );
#    
#setlistener("/controls/shuttle/solid-rocket-boosters", func 
#
#  { if(getprop("/consumables/fuel/tank[1]/level-lbs") > 100)
#  {
#  setprop("/controls/shuttle/solid-rocket-boosters", 1 );
#      }
#      else
#      {
#        setprop("/controls/shuttle/solid-rocket-boosters", 0 );
#      }  
#  }
#  );
#  
  
  
if (getprop("/consumables/fuel/tank[0]/level-lbs") < 100)
  {
  setprop("/controls/shuttle/external-fuel-tank", 0 );
      }
      else
      {
        setprop("/controls/shuttle/external-fuel-tank", 1 );
      }
;
    
if (getprop("/consumables/fuel/tank[1]/level-lbs") < 100)
  {
  setprop("/controls/shuttle/solid-rocket-boosters", 0 );
      }
      else
      {
        setprop("/controls/shuttle/solid-rocket-boosters", 1 );
      }
;


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
# create timer with 0.1 second interval to st the reverser for YAW-Engine
var timer = maketimer(0.1, func

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
# start the timer (with 0.1 second inverval)
timer.start();
