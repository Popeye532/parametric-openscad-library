
$fn = 50;

module star_knob(radius, points, height, nut_width_across_flats, nut_depth, clearance) 
{
    assert(radius>0 && points>0 && height>0 && nut_width_across_flats>0 && nut_depth>0 && clearance>0, "negative input");
    assert(radius*2 > nut_width_across_flats,"nut must be smaller than overall radius");
    assert(nut_depth < height, "nut can't reach both ends"); // this one is critical depends on the application, might be removed if it is okay
    angel_inc = 360/points;
    // assert to max point number but timer out

    difference()
    {
        // The outer star body
        linear_extrude(height=height, center=true) {
            for(i=[0:points-1]) {
                rotate([0, 0, i * angel_inc])
                translate([radius/2, 0, 0])
                circle(r=radius/2);
            }
            circle(r=radius/2);
        }

        // The Hex Nut Trap (M5 nut = approx 8mm flat-to-flat)
        translate([0,0, -height/2-0.01]) {
            cylinder(r=(nut_width_across_flats / 2) / cos(30) - clearance, h=nut_depth, $fn=6); 
        }
    }
}
 
// example usage
star_knob(20, 5, 10, 8, 3, 0.05);