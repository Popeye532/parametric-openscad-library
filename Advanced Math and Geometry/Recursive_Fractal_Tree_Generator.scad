
module y_branch(radius, length, branch_angle, levels, _eps=0.01, _is_internal=false)
{
    if (!_is_internal)
    {
        assert(radius>0 && length>0 && branch_angle>0 && levels>0, "Negative Input!");
        assert(levels <= 8, "Max recursion depth exceeded");
    }
    if (levels > 0)
    {
        cylinder(r=radius, h=length, center=false);
        translate([0,0,length-_eps])
        {
            sphere(r=radius, $fn=30);
            rotate([0,branch_angle,0]) y_branch(radius*0.7,length*0.8,branch_angle,levels-1,_eps,true); 
            rotate([0,-branch_angle,0]) y_branch(radius*0.7,length*0.8,branch_angle,levels-1,_eps,true); 
        }
    }
}

y_branch(20,40,40,4);