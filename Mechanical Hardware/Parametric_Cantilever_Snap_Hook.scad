
module snap_hook(length, width, thickness, hook_depth, hook_length, fillet_r, base_hole_r)
{
    assert(length>0 && width>0 && thickness>0 && hook_depth>0 && hook_length>0 && fillet_r>0 && base_hole_r>0, "Negative Input");
    assert(hook_length<length, "hook length must be shorter than the whole length");
    assert(base_hole_r<thickness && base_hole_r<length, "base hole must be smaller than thickness and length"); // if it was greater than or equal to thickness we remove the base or the length
    

    _points=[
        [0,0],
        [length,0],
        [length,thickness],
        [length - (hook_length * 4/5), thickness + hook_depth],
        [length - (hook_length), thickness + hook_depth],
        [length - hook_length, thickness], 
        [0,thickness]
    ];
    linear_extrude(height=width, center=true, convexity=10)
    {
        difference()
        {
            offset(r=-fillet_r, $fn = 100) offset(r=fillet_r, $fn = 100) polygon(points=_points);
            translate([0,thickness]) circle(r=base_hole_r, $fn = 100);
        }   
    }
}

snap_hook(15,5,5,3,5,1.5,1);