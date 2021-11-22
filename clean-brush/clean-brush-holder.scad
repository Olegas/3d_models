wall_width = 2;
guide_width = 1;
guide_height = 2.5;
mount_width = 8;
mount_offset = 0;
mount_len = 16 + wall_width;
middle_width = 17 - mount_width/2;
middle_len = wall_width;
holder_width = 11;
holder_length = 25 + guide_width*2;

rail_height = 20;
rail_width = 8;
rail_offset = 3;
rail_wall = 3;
rail_support = 1.2;
rail_support_height = 1;


nut_size = 3;
nut_h = 2.2;
nut_outer_d = 6;

module holder() {
    union() {
        cube([holder_length, holder_width, wall_width]);
        // walls
        translate([0, 0, wall_width])
            cube([holder_length, guide_width, 0.7]);
        translate([0, holder_width-guide_width, wall_width])
            cube([holder_length, guide_width, 0.7]);
        translate([0, 0, wall_width])
            cube([guide_width, holder_width, guide_height]);
        translate([holder_length-guide_width, 0, wall_width])
            cube([guide_width, holder_width, guide_height]);
        // cap
        translate([0, 0, wall_width+guide_height])
            cube([guide_width*2, holder_width, guide_width]);
        translate([holder_length-guide_width*2, 0, wall_width+guide_height])
            cube([guide_width*2, holder_width, guide_width]);
        
        translate([holder_length/2-rail_width/2, rail_offset, -rail_height])
            rail();
    }
}

module rail() {
    difference() {
        union() {
            cube([rail_width, rail_wall, rail_height]);
            translate([
                    (rail_width*(1-rail_support)/2),
                    (rail_wall*(1-rail_support)/2), 
                    rail_height-rail_support_height])
                cube([rail_width*rail_support, rail_wall*rail_support, rail_support_height]);
        }
        for(a=[nut_size:0.5:rail_height-nut_size]) {
                translate([rail_width/2, rail_wall+0.1, a])
                    rotate([90, 0, 0])
                        cylinder(rail_wall+0.2, r=nut_size/2*1.1, $fn=100);    
        }
    }
}

module bed_bracket() {
    difference() {
        cube([mount_len, mount_width, wall_width]);
//        linear_extrude([10, 0, 0])
        for(a=[nut_size+wall_width+1:0.5:mount_len-nut_size])
                translate([a, mount_width/2, -0.1])
                    cylinder(wall_width+0.2, r=nut_size/2*1.05, $fn=100);
    }
}

module mount_plate() {
        difference() {

            union() {
                translate([wall_width, 0, wall_width])
                    rotate([0, -90, 0])
                        cube([guide_height, middle_width, wall_width]);
                cube([middle_len, middle_width, wall_width]);
                translate([mount_offset, middle_width, 0])
                    bed_bracket();                    
                translate([mount_offset, -mount_width, 0])
                    bed_bracket();
                translate([-guide_width, 0, 0])
                    cube([guide_width, guide_width*0.95, guide_height+wall_width]);
                translate([-guide_width, middle_width-guide_width*0.95, 0])
                    cube([guide_width, guide_width*0.95, guide_height+wall_width]);
            }
            
            translate([wall_width+0.1, middle_width/2, wall_width + guide_height/2])
                rotate([0, -90, 0])
                    cylinder(nut_h, r=nut_outer_d/2*1.05, $fn=6); 

            translate([wall_width+0.1, middle_width/2, wall_width + guide_height/2])
                rotate([0, -90, 0])
                    cylinder(wall_width+0.2, r=nut_size/2*1.05, $fn=100); 

                   
        }

}

//holder();

 mount_plate();