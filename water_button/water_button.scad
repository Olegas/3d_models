$fn=100;

h = 10;
w = 14;
hole = 2.7;
hole_max = 3.0;
pin_w = 2.5;
pin_h = 11.5;

module water_button() {
    difference() {
        union() {
            translate([0, -3, 0])
                union() {
                    cube([w, 42 - w/2, h]);
                    translate([w/2, 42 - w/2, 0])
                        cylinder(h=h, d=w);
                }
            translate([0, -3, -pin_h])    
                cube([pin_w, 9, pin_h]);
            translate([w-pin_w, -3, -pin_h])    
                cube([pin_w, 9, pin_h]);
            translate([w/2, 0, 0])    
                rotate([0, 90, 0])    
                    cylinder(h=w, r=3, center=true);    
        }
        translate([w/2, 0, 0])    
            rotate([0, 90, 0])
                cylinder(h=w+1, d=hole, center=true);         
        translate([w, 0, 0])    
            rotate([0, 90, 0])     
                cylinder(h=w*4/5, d=hole_max, center=true);  
        translate([0, 0, 0])    
            rotate([0, 90, 0])     
                cylinder(h=w*4/5, d=hole_max, center=true);  
        translate([w/2, -pin_h/2-1.5, -pin_h/2])  
            rotate([0, 90, 0])
                cylinder(h=w+1, d=pin_h, center=true);
        translate([w/2, pin_h/2+4, -pin_h/2])  
            rotate([0, 90, 0])
                cylinder(h=w+1, d=pin_h, center=true);

    }
}

water_button();