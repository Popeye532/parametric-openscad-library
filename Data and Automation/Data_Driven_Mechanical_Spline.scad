// [ "Standard_Name", _num_teeth, _tooth_width ]
_spline_standards = [
    ["ANSI_A", 6, 2.0],
    ["ANSI_B", 8, 3.0],
    ["ISO_1", 12, 1.5],
    ["ISO_2", 5, 3.0]
];

// [ Load_kg, _base_radius ]
_load_table = [
    [10, 5.0],
    [50, 10.0],
    [100, 18.0]
];

module smart_spline(standard, load, length)
{
    assert(length > 0, "Negative input");
    // assert(standard == "ANSI_A" || standard == "ANSI_B" || standard == "ISO_1", "Not a standard");
    assert(load > 10 && load < 100, "Load limited to [10,100]"); // i chose this so we can interpolate, i don't know if exrapolation is possible but this is safer.

    index = search([standard], _spline_standards);
    assert(len(index) > 0, "Standard not found in database!");

    _num_teeth = _spline_standards[index[0]][1];
    _tooth_width = _spline_standards[index[0]][2];

    _base_radius = lookup(load, _load_table);


    linear_extrude(height=length, center=true) 
    {
        // shaft
        circle(r=_base_radius, $fn=60);

        // teeth, i chose the half so we don't have duplicates
        _angle_inc = 360 / _num_teeth;
        _is_odd = _num_teeth % 2;
        
        
        _tooth_length = (_is_odd) ? 4 : 2 * (_base_radius + 2); // twice the teeth height
        _interval = (_is_odd) ? _num_teeth - 1 : (_num_teeth)/2 - 1;
        _tr = (_is_odd) ? _base_radius : 0;

        for (i=[0:_interval]) 
        {
            _angle = i * _angle_inc;

            rotate([0,0,_angle])
            translate([_tr, 0])
            square(size=[_tooth_length, _tooth_width], center=true);
        }
    }

}

smart_spline("ISO_2", 40, 100);