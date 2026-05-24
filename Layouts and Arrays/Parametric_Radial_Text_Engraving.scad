
PI = 3.14159;

module engraved_ring(msg, r, h, cut_depth,char_spacing, _eps=0.01)
{
    assert(r>0 && h>0 && cut_depth>0 && char_spacing>0, "Negative Input");
    assert(is_string(msg), "msg must be string");

    _P = 2 * PI * r;
    _size = h*0.8;
    // this is an approximate way to calculate the length, is is basically for each
    // 1 character, we have the size of the character(_size) and 1 spacing (char_spacing)
    // although _size is for the height of the text, idk how to get the total width honestly
    _text_length = len(msg) * (_size + char_spacing); 

    // one more assert for overflow, or in other words so that words don't wrap
    // on top of each other.
    assert(_text_length < _P, "Overflow!");

    difference()
    {
        // cylinder
        cylinder(r=r, h=h, center=true);
        // text
        for (i=[0:len(msg)-1]) 
        {

            // _angle = i * (360 / len(msg)); old angle
            // _angle_step = (i * char_spacing / r) * (180 / PI);
            _step_dist = _size + char_spacing;
            _total_angle_span = ((len(msg) - 1) * _step_dist / r) * (180 / PI);
            _start_angle = -(_total_angle_span / 2);

            // Inside loop:
            _current_angle = _start_angle + (i * (_step_dist / r) * (180/PI));

            rotate([0,0,_current_angle]) // rotate around cylinder
            translate([0, -r+cut_depth-_eps, 0]) // push it to the end
            rotate([90,0,0]) // make it stand
            linear_extrude(height = cut_depth + _eps, center=false)
            {
                text(text=msg[i], size=_size, halign="center", valign="center");
            }
        }
        
    }
}

engraved_ring("Hello World", 100, 20, 2, 20);

module centered_radial_array(num_holes, radius, angular_spacing, hole_r, depth)
{
    assert(num_holes>0 && radius>0 && angular_spacing>0 && hole_r>0 && depth>0, "Negative Input");
    assert(angular_spacing * (num_holes - 1) < 360, "Holes overlap (Repeating)");
    assert(hole_r < radius, "hole radius must be smaller than radius");
    assert(angular_spacing*(PI/180)*radius > hole_r * 2, "Holes overlap (Small angular distance/large hole radius)");


    _total_angle_span = ((num_holes - 1) * angular_spacing);
    _start_angle = -(_total_angle_span / 2);

    for (i=[0:num_holes-1]) 
    {
        _cur = _start_angle + (i * angular_spacing);

        // we could also replace those 2 commands by single translate command which uses cos/sin for the x and y
        rotate([0,0,_cur])
        translate([0,radius,0])
        // while we didn't include _eps, the user should include it in his original prompt
        cylinder(r=hole_r, h=depth, center=true);
    }
}

centered_radial_array(8, 40, 30, 5, 10);