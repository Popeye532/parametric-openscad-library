
/*
returns an array for NEMA Motors 17 and 23:
[Face Size, Hole Spacing, Pilot Boss Dia, Bolt Dia]
*/
function get_nema_specs(nema_size) = 
    (nema_size == 17) ? [42.3, 31.0, 22.0, 3.2] : ((nema_size == 23) ? [56.4, 47.1, 38.1, 5.2] : undef);


module nema_bolt_pattern(nema_size, depth, _eps=0.01)
{
    specs = get_nema_specs(nema_size);
    assert(specs != undef, "Unknown NEMA size!");
    assert(depth > 0, "Depth must be positive");

    face_size    = specs[0];
    hole_spacing = specs[1];
    pilot_dia    = specs[2];
    bolt_dia     = specs[3];

    _offset = hole_spacing / 2;

    for (x = [-1, 1], y =[-1, 1]) 
    {
        // center it instead of having -_eps in z
        translate([x * _offset, y * _offset, 0])
            cylinder(r=bolt_dia/2, h=depth + 2*_eps, center=true, $fn=60);
    }    
}

module nema_mount_plate(nema_size, plate_thickness, mount_type = "rectangular", _eps = 0.01) 
{
    specs = get_nema_specs(nema_size);
    assert(specs != undef, "Unknown NEMA size!");
    assert(plate_thickness > 0, "Plate thickness must be positive");

    assert(mount_type == "round" || mount_type == "rectangular", "only rectangular and round mount types supported");

    face_size = specs[0];
    spacing   = specs[1];
    pilot_dia = specs[2];
    bolt_dia  = specs[3];

    difference() 
    {
        if (mount_type == "rectangular")
        {
            cube(size=[face_size + 10, face_size + 10, plate_thickness], center=true);
        }
        else
        {
            cylinder(d=face_size + 10, h=plate_thickness, center=true);
        }

        cylinder(d=pilot_dia, h=plate_thickness + 2 * _eps, center=true, $fn=60);

        nema_bolt_pattern(nema_size, plate_thickness, _eps);
    }
}

nema_mount_plate(17, 2);