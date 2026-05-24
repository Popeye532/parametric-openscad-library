
module fast_rounded_plate(length, width, thickness, corner_radius, $fn=100)
{
    assert(length>0 && width>0 && thickness>0 && corner_radius>0 && $fn>0, "Negative Input");
    assert(corner_radius < width/2 && corner_radius<length/2, "Corner too big");

    linear_extrude(height=thickness, center=true)
    {
        minkowski() {
            square(size=[length - 2*corner_radius, width - corner_radius*2], center=true);
            circle(r=corner_radius, $fn=$fn);
        }    
    }
}

// parametrize the cube size
module planetary_layout(sun_r, planet_r, num_planets, thickness, cube_size = 2, _eps = 0.01)
{
    assert(sun_r>0 && planet_r>0 && num_planets>0 && thickness>0 && cube_size>0, "Negative Input");

    // sun gear
    cylinder(r=sun_r, h=thickness, center=true);    

    _deg_dis = 360 / num_planets;

    // planetary gears
    for (i=[0:num_planets-1]) 
    {
        _degree = _deg_dis * i;

        // rotate the notch to face outwards, around z axis, it will also rotate to its position
        rotate([0, 0, _degree])
        // tranlsate the gear away from the sun gear
        tranlsate([0,planet_r + sun_r + _eps, 0])
        // the planet gear
        difference() 
        {
            cylinder(r=planet_r, h=thickness, center=true);
            translate([0, planet_r + _eps, 0]) cube([cube_size, cube_size, thickness + 2 * _eps], center=true);
        }
    }
    
}