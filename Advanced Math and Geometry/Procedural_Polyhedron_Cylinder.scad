
module alignment_wedge(base_x, base_y, top_x, top_y, height)
{
    assert(base_x>0 &&base_y>0 &&top_x>0 &&top_y>0 && height >0, "Negative Input");

    _points=
    [
        // bottom points
        [0,0,0],
        [base_x,0,0],
        [0,base_y,0],
        [base_x, base_y,0],
        // top points
        [0,0,height],
        [top_x,0,height],
        [0,top_y,height],
        [top_x,top_y,height],
    ];

    _faces=
    [
        // bottom face
        [0,2,3,1],
        // top face
        [4,5,7,6],
        // each side now
        [0,1,5,4],
        [1,3,7,5],
        [3,2,6,7],
        [0,4,6,2],
    ];

    polyhedron(points=_points, faces=_faces);
}

    for (i=[0:fn-1]) 
    {
        angle = i * 360 / fn;
        // the negative so that we go CCW
        point = [r * cos(-angle), r * sin(-angle)];
    }


// yes it could be optimized i just didn't have a better way in this time pressure
function procedural_circle(r, i, fn, CCW, _points = []) =
    (i == fn-1) ? _points :
    procedural_circle(r, i+1, fn, CCW, concat(_points, let(angle = i * 360 / fn, dir = (CCW) ? -1 : 1) [r * cos(dir * angle), r * sin(dir * angle)]))
;

function generate_sides(bottom, top, i, fn, _sides = []) = 
    (i == fn-1) ? _sides :
    generate_sides(bottom, top, i+1, fn, let (j=2*fn-i-1, k = (i==0)? fn : 2*fn-i) concat(_sides, [i,i+1, j, k]))
;

module procedural_cylinder(r, h, fn)
{
    assert(r>0 && h>0, "Negative Input");
    assert(fn>3, "fn at least 3");

    // we start by making the points
    // bottom is basically the bottom face.
    bottom = procedural_circle(r,0,fn, false);
    // top face
    top = procedural_circle(r,0,fn, true);

    all_points = concat(bottom, top);

    // for the sides
    sides = generate_sides(bottom, top, 0, fn);

    all_faces = concat(side,top,bottom);

    polyhedron(points=all_points, faces=all_faces);
}

// -------- CORRECTED -----------

module procedural_cylinder(r, h, fn) {
    assert(r > 0 && h > 0, "Dimensions must be positive");
    assert(fn >= 3, "fn must be >= 3");

    _points = [
        for (i=[0 : fn-1])[r * cos(i*360/fn), r * sin(i*360/fn), 0],   // Bottom (0 to fn-1)
        for (i=[0 : fn-1])[r * cos(i*360/fn), r * sin(i*360/fn), h]    // Top (fn to 2*fn-1)
    ];

    _bottom_face = [for (i=[fn-1 : -1 : 0]) i];

//    _top_face = [for (i=[0 : fn-1]) i + fn];

    _top_triangles =  [ for (i = [1 : 2*fn-1 ]) [ fn , fn+i, fn+i+1  ] ];

    _side_faces = [
        for (i=[0 : fn-1]) 
            let (
                next_i = (i + 1) % fn,
                top_offset = fn
            )
            [i, next_i, next_i + top_offset, i + top_offset]
    ];

    // 5. Concat and Render
    _all_faces = concat([_bottom_face], [_top_face], _side_faces);
    
    polyhedron(points=_points, faces=_all_faces);
}

procedural_cylinder(5, 10, 100);