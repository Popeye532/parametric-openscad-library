
module strut(p1, p2, r)
{
    assert(r>0, "Negative input");
    assert(p1!=p2, "p1 can't be same as p2");

    _v = p2 - p1;
    _length = norm(_v);
    _angle = acos(_v[2] / _length);
    _axis = cross([0, 0, 1], _v);

    _safe_axis = (_axis == [0,0,0]) ? [1,0,0] : _axis;

    translate(p1)
    rotate(a=_angle, v=_safe_axis)
    cylinder(r=r, h=_length);
}

function is_vec3(v) = 
    is_list(v) && 
    len(v) == 3 && 
    is_num(v[0]) && is_num(v[1]) && is_num(v[2]);

module wireframe(path, r)
{
    assert(r>0, "Negative input");
    assert(is_list(path) && len(path)>1, "path should be 3d coordinate of at least 2 points");

    for (i=[0:len(path)-1]) {
        assert(is_vec3(path[i]), "all items in path should be 3d coordinate points");
    }
    
    // for (i=[1:len(path)-1]) 
    // {
    //     translate(path[i-1]) sphere(r=r);
    //     strut(path[i-1], path[i], r);
    // }
    // // one more sphere at the end
    // translate(path[len(path)-1]) sphere(r=r);

    // if you want it to have spheres only at intersections:
    for (i=[0:len(path)-2])
    {
        if (i != len(path)-2)
        {
            translate(path[i+1]) sphere(r=r);
        }
        strut(path[i], path[i+1], r);
    }
}

wireframe([[0,0,0], [0,10,0], [0,10,10], [10,10,10]], 1, $fn=100);