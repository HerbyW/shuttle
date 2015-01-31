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