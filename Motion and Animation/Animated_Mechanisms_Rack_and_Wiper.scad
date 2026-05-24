

module wiper_assembly(arm_length, sweep_angle)
{
    assert(arm_length > 0 && sweep_angle > 0);

    _current_angle = -cos($t * 360) * sweep_angle/2;

        cylinder(r=5, h=10, center=true);

    rotate([0, 0, _current_angle])
    {
        cube([arm_length, 10, 5]);    
    }
    
}

PI = 3.14159;


module rack_and_pinion(pinion_r, rack_length, is_assembly=true)
{
    assert(pinion_r > 0 && rack_length > 0);

    // 0 to 360
    _angle = (is_assembly) ? $t * 360 : 0;

    // pinion
    rotate([0,0,-_angle])
    difference() 
    {    
        cylinder(r=pinion_r, h=5, center=is_assembly);
        translate([0,pinion_r*0.9,(is_assembly) ? 0 : -0.01])
            cylinder(r=pinion_r/10, h=5.02, center=is_assembly);
    }
    
    // to start at the beginning of the rack
    _offset = (is_assembly) ? rack_length/2 : 0;

    // rack
    translate([_angle * (PI/180) * pinion_r - _offset,(is_assembly) ? pinion_r : pinion_r * 2,0])
     cube(size=[rack_length, 5, 5], center=true);
}

rack_and_pinion(20,200);