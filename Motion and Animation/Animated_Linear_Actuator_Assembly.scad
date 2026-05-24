
module nema_mount(center) {
    cube([42, 42, 42], center=center);
}
module guide_rods_and_screw(travel_dist) {
    cylinder(r=4, h=travel_dist);
}
module sliding_carriage(carriage_length, center) {
    cube([50, carriage_length, 20], center=center);
}

module linear_actuator(travel_dist, rod_spacing, carriage_length, is_assembly=true)
{
    assert(travel_dist>0 && rod_spacing>0 && carriage_length>0, "Negative Input");
    assert(travel_dist>carriage_length, "carriage can't be longer than travel distance");
    

    nema_mount(center=is_assembly);

    if (is_assembly)
    {
        translate([0,21,0]) // just simply cuz the nema_mount is 42. only example
        rotate([-90,0,0])
        guide_rods_and_screw(travel_dist);
    }

    _v = (is_assembly) ? [0,travel_dist / 2 * cos($t * 360) + 21 + travel_dist/2,0] : [rod_spacing, 0, 0];

    translate(_v)
    sliding_carriage(carriage_length, center=is_assembly);
}

linear_actuator(100, 50, 20);