
// removed the modified hull

module gasket(thickness, R=1) 
{
    linear_extrude(height=thickness) {
        difference() {
            // Main Body
            //fillet
            
            offset(r=-R)
            offset(r=R)
            offset(r=R)
            offset(r=-R)
            offset(r=5) 
            union()
            {
                for(i=[1:$children-1])
                {
                    hull() {
                        children(i-1);
                        children(i);
                    }
                }
            }
            // Subtraction
            children();
        }
    }
}

gasket(3, R=5, $fn=150)
{
    circle(r=2);
    translate([10, 10]) circle(r=2);
    translate([20, 20]) circle(r=2);
    translate([30, 40]) circle(r=2);
    translate([0, 40]) circle(r=2);
}