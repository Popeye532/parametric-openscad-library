
module conformal_tray(wall_thickness, base_thickness, tray_height, clearance, vacuum_r)
{
    assert($children==1, "Exactly 1 child allowed");
    assert(wall_thickness>0 && base_thickness>0 && tray_height>0 && clearance>0 && vacuum_r>0,"Negative Input");

    // simple way to get infinite length, may not be robust but we can't know for sure the size of children
    _length = (vacuum_r + wall_thickness + clearance) * 1000;

    difference() {
        difference()
        {
            // base
            linear_extrude(height=tray_height, center=true)
            {
                offset(r=wall_thickness + clearance)
                projection(cut=false) { children(); }
            }

            // vaccum bottom cyl
            translate([0,0,-base_thickness])
            cylinder(r=vacuum_r, h=base_thickness+0.02, center=true);
            
            // crosshair 
            translate([0,0,-base_thickness/2])
            intersection()
            {
                linear_extrude(height=tray_height, center=true)
                projection(cut=false) { children(); }
                
                union()
                {
                    cube([_length, vacuum_r*2, base_thickness/2+0.01], center=true);
                    
                    cube([vacuum_r*2, _length, base_thickness/2+0.01], center=true);
                }
            }
        }
        //cutting tool
        translate([0,0,base_thickness])
        {
            hull()
            {
                render(convexity=10) 
                minkowski() 
                {
                    children();
                    sphere(r=clearance, $fn=15);
                }
                
                translate([0,0,tray_height])
                render(convexity=10) 
                minkowski() 
                {
                    children();
                    sphere(r=clearance, $fn=15);
                }
            }
        }
        
    }
}

conformal_tray(2, 5, 15, 2,1)
{
    cube(10, center=true);
}