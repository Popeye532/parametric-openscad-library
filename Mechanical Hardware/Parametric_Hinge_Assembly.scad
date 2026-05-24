
module hinge_assembly(pin_r, outer_r, knuckle_w, fork_w, clearance, is_assembly=true)
{
    assert(pin_r > 0 && outer_r > 0 && knuckle_w > 0 && fork_w > 0 && clearance > 0, "Negative Input");

    _pos_fork = (is_assembly) ? [0, 0, (fork_w + knuckle_w)/2 + clearance] : [0, outer_r * 3, 0];
    // don't need knuckle position any more

    rotate([0, 90, 0] * ((is_assembly) ? 1 : 0)) 
    {
        // pin
        if (is_assembly)
        {
            %cylinder(r=pin_r, h= knuckle_w + 2 * (fork_w + clearance), center=is_assembly);
        }

        // knuckle
        translate((is_assembly) ? [0,-3*outer_r+0.01,0] : [-outer_r/2, outer_r-0.01, 0])
        { 
            cube(size=[outer_r, outer_r*4, fork_w], center=is_assembly);
        }
        difference()
        {
            cylinder(r=outer_r, h=knuckle_w, center=is_assembly);
            translate([0,0,-0.01] * ((is_assembly) ? 0 : 1)) 
                cylinder(r=pin_r+clearance, h=knuckle_w+0.02, center=is_assembly);
        }

        // both forks
        for (dir = [1,-1])
        {
            translate(_pos_fork * dir)
            {
                translate((is_assembly) ? [0,3*outer_r-0.01,0] : [-outer_r/2, outer_r-0.01, 0])
                { 
                    cube(size=[outer_r, outer_r*4, fork_w], center=is_assembly);
                }
            
                difference()
                {
                    cylinder(r=outer_r, h=fork_w, center=is_assembly);
                    translate([0,0,-0.01] * ((is_assembly) ? 0 : 1)) 
                        cylinder(r=pin_r, h=fork_w+0.02, center=is_assembly);
                }
            }
        }
    }
}