#var outerspace = setprop(/position/altitude-ft

var throttleAxis = myaxisHandler("/controls/engines/engine[", "]/throttle");


##
# arg[0] is the throttle increment
# arg[1] is the auto-throttle target speed increment
var incThrottle = func {
    var passive = getprop("/autopilot/locks/passive-mode");
    var locked = getprop("/autopilot/locks/speed");
    # Note: passive/locked may be nil on aircraft without A/P
    if ((passive == 0) and (locked))
    {
        var node = props.globals.getNode("/autopilot/settings/target-speed-kt", 1);
        if (node.getValue() == nil) {
            node.setValue(0.0);
        }
        node.setValue(node.getValue() + arg[1]);
        if (node.getValue() < 0.0) {
            node.setValue(0.0);
        }
    }
    else
    {
        foreach(var e; engines)
        {
            if(e.selected.getValue())
            {
                var node = e.controls.getNode("throttle", 1);
                var val = node.getValue() + arg[0];
                node.setValue(val < -1.0 ? -1.0 : val > 1.0 ? 1.0 : val);
            }
        }
    }
};

##
# Joystick axis handlers (use cmdarg).  Shouldn't be called from
# other contexts.  A non-null argument reverses the axis direction.
var myaxisHandler = func(pre, post) {
    func(invert = 0) {
        var val = cmdarg().getNode("setting").getValue();
        if(invert) val = -val;
        foreach(var e; engines)
            if(e.selected.getValue())
                setprop(pre ~ e.index ~ post, (1 - val) / 2);
    }
};