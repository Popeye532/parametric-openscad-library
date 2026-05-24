
/*
    cols: number of columns (integer)
    rows: number of rows (integer)
    spacing_x: x spacing between holes 
    spacing_y: y spacing between holes
*/
module grid_array(cols, rows, spacing_x, spacing_y, center=false)
{
    assert($children > 0, "Children Required");
    assert(cols>0 && rows>0 && spacing_x>0 && spacing_y>0, "cols, rows, spacing_x, spacing_y should be positive");
    assert(floor(cols) == cols && floor(rows) == rows, "Rows and columns should be positive");

    _start_y = (center) ? ((rows-1) * spacing_y) / 2 : 0;

    _start_x = (center) ? ((cols-1) * spacing_x) / 2 : 0;

    for (col=[0:cols-1])
    {
        _x_pos = col * spacing_x - _start_x;
        for (row=[0:rows-1]) 
        {
            _y_pos = row * spacing_y - _start_y;
            translate([_x_pos, _y_pos, 0])
                children();
        }
    }
}


/*
    cols: number of columns (integer)
    rows: number of rows (integer)
    spacing_x: x spacing between holes 
    spacing_y: y spacing between holes
*/
module staggered_grid(cols, rows, spacing_x, spacing_y, center=false)
{
    assert($children > 0, "Children Required");
    assert(cols>0 && rows>0 && spacing_x>0 && spacing_y>0, "cols, rows, spacing_x, spacing_y should be positive");
    assert(floor(cols) == cols && floor(rows) == rows, "Rows and columns should be positive");

    _start_y = (center) ? ((rows-1) * spacing_y) / 2 : 0;
    _start_x = (center) ? ((cols-1) * spacing_x) / 2 : 0;

    // we use staggering logic if we have more than 1 child
    _staggered = ($children > 1);

    for (col=[0:cols-1]) {
        _x_pos = col * spacing_x - _start_x;
        for (row=[0:rows-1]) {
            _y_pos = row * spacing_y - _start_y;
            
            // Calculate the ideal alternating index (0 or 1)
            _ideal_index = (col + row) % 2;
            
            // Bound the index safely against what the user actually provided
            _safe_index = min(_ideal_index, $children - 1);
            
            translate([_x_pos, _y_pos, 0])
                children(_safe_index);            
        }
    }
}

// we used 'use' so we don't get EPS as well
use <mechanical_algorithms.scad>

staggered_grid(3, 3, 10, 10, center=true)
{
    cylinder(r=2, h=5, center=true);
    cube(size=[3, 3, 5], center=true);
}