$fn=100;
grow = 1.05;

module arm(l, h, w, screw_d, screw_l, nut_d, nut_h) {
    difference() {

        intersection() {
        
            /*union() {
                rotate([90, 0, 0])
                    cylinder(l, d=w*1.25, center=true);
                translate([h/2-w/2, -l/2, 0])
                    rotate([90, 0, 90])
                        cylinder(h, d=w*1.25, center=true);
                translate([h/2-w/2, l/2, 0])    
                    rotate([90, 0, 90])
                        cylinder(h, d=w*1.25, center=true);
            }*/

            union() {
                cube([w, l, w], center=true);
                translate([h/2-w/2, -l/2, 0])
                    cube([h, w, w], center=true);
                translate([h/2-w/2, l/2, 0])    
                    cube([h, w, w], center=true);
            }
            
        }
        
        translate([h-screw_l-w/2+0.1, -l/2, 0])
            rotate([0, 90, 0])
                cylinder(screw_l, d=screw_d*grow);
        translate([h-screw_l-w/2+0.1, l/2, 0])
            rotate([0, 90, 0])
                cylinder(screw_l, d=screw_d*grow);
        translate([h-screw_l/2-w/2, l/2, w/2-nut_d/2])
            cube([nut_h, nut_d, w], center=true);
        translate([h-screw_l/2-w/2, -l/2, w/2-nut_d/2])
            cube([nut_h, nut_d, w], center=true);
    }
}

module stopper(d, h, screw_d) {
    difference() {
        cylinder(h, d=d, center=true);
        cylinder(h*1.1, d=screw_d*grow, center=true);
    }
}

arm(120, 90, 7, 3, 20, 6, 3);
//stopper(20, 3, 3);