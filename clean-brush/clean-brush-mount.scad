wall_width = 3;
guide_width = 2;
guide_height = 15;
mount_width = 8;
mount_offset = 0;
mount_len = 20;
middle_width = 17 - mount_width/2;

echo(middle_width);

nut_size = 3;
nut_h = 2.2;
nut_outer_d = 6;

module bed_bracket() {
    difference() {
        cube([mount_len, mount_width, wall_width]);
//        linear_extrude([10, 0, 0])
        for(a=[7:0.5:mount_len-nut_size])
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
                cube([20, middle_width, wall_width]);
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

mount_plate();