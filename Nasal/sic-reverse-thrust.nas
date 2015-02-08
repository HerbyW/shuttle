 
togglereverser = func {
  r1 = props.globals.getNode("/fdm/jsbsim/propulsion/engine[11]");

  r3 = props.globals.getNode("/controls/engines/engine[11]");

  r5 = props.globals.getNode("/sim/input/selected");
  rv1 = props.globals.getNode("/engines/engine[11]/reverser-pos-norm");


  val = rv1.getValue();
  if (val == 0 or val == nil) {
    interpolate(rv1.getPath(), 1.0, 0.01); 
 
    r1.getChild("yaw-angle-rad").setValue(4.712385);

    r3.getChild("reverser").setBoolValue(1);

    r5.getChild("engine[11]").setBoolValue(1);

  } else {
    if (val == 1.0){
      interpolate(rv1.getPath(), 0.0, 0.01); 

      r1.getChild("yaw-angle-rad").setValue(1.570795);

      r3.getChild("reverser").setBoolValue(0);

      r5.getChild("engine[11]").setBoolValue(1);

    }  
  }
}
;