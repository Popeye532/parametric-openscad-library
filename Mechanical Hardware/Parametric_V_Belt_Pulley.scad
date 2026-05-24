
module copy_mirror(axis=[0,1,0]) {
    union() {
        children();
        mirror(axis) children();
    }
}

/*
    returns a trapezoid, non-centered, used for pulley_profile_2d(), should be mirrored to get the whole profile
*/
module _pulley_profile_2d_cutting_tool(groove_depth, groove_width, groove_angle, _eps = 0.01) 
{
    // double check because if we used it somewhere else.
    assert(groove_depth>0 && groove_width>0 && groove_angle>0, "Negative parameter");
    
    // divided by 2 so i don't divide later
    groove_width_bottom = (groove_width - 2 * groove_depth * tan(groove_angle/2)) / 2;

    polygon(points=[
        [0,-_eps], // to prevent colinear Edges when mirrored
        [groove_depth + _eps, -_eps], // to prevent colinear Edges when mirrored and at the top
        [groove_depth + _eps, groove_width/2],
        [0, groove_width_bottom]
    ]);
}

// i added groove_angle because it is required for the 2d profile
module pulley_profile_2d(outer_radius, bore_radius, width, groove_depth, groove_width, groove_angle, fillet_r=1, _eps = 0.01) 
{
    assert(outer_radius>0 && bore_radius>0 && width>0 && groove_depth>0 && groove_width>0 && groove_angle>0 && fillet_r>0, "Negative parameter");
    assert(outer_radius > bore_radius, "Outer radius must be bigger than bore radius");
    assert(groove_depth < outer_radius-bore_radius, "Groove depth cannot reach the bore hole");
    assert(groove_width < width, "Groove can't be wider than the entire width");

    // i added the copy mirror according to your requirements
    copy_mirror()
    {
            offset(r=-fillet_r)
            offset(r=fillet_r)
        // we differentiate between a square and the cutting tool
        difference()
        {
            // half of the shaft
            translate([bore_radius,-_eps]) square(size=[outer_radius-bore_radius, width/2 + _eps]); // the eps so we don't have colinear edges after copy mirror
            
            // cutting tool
            translate([outer_radius-groove_depth,0]) 
            _pulley_profile_2d_cutting_tool(groove_depth, groove_width, groove_angle, _eps);
        }
    }
}

module pulley_3d(outer_radius, bore_radius, width, groove_depth, groove_width, groove_angle, fillet_r=1, _eps = 0.01, $fn=150)
{
    assert(outer_radius>0 && bore_radius>0 && width>0 && groove_depth>0 && groove_width>0 && groove_angle>0 && fillet_r>0, "Negative parameter");
    assert(outer_radius > bore_radius, "Outer radius must be bigger than bore radius");
    assert(groove_depth < outer_radius-bore_radius, "Groove depth cannot reach the bore hole");
    assert(groove_width < width, "Groove can't be wider than the entire width");

    rotate_extrude($fn=$fn)
    {
        pulley_profile_2d(outer_radius, bore_radius, width, groove_depth, groove_width, groove_angle, fillet_r, _eps, $fn=$fn);
    }
}

pulley_3d(95, 15, 36, 22, 26, 40, 3);