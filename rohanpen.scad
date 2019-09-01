$fs = 0.25;
$fa = 1.0;

width         = 10.0;
height        = 25.0;
thick         = 15.0;

kakumaru      = 1.0;

cir_d         = 1.0;
center_len    = 12.0;
bar           = 6.0;
side          = -2.5;

module pen_outer() {
    h = 0.0001;
    minkowski() {
        difference() {
            cube([width - kakumaru*2, height - kakumaru*2, thick - h], center = true);
            translate([-6.5, 10, 0]) {
                rotate([0, 0, 70]) {
                    linear_extrude(height = thick * 2, center = true) {
                        resize([30,10])circle(d=20);
                    }
                }
            }
            translate([6.5, 10, 0]) {
                rotate([0, 0, -70]) {
                    linear_extrude(height = thick * 2, center = true) {
                        resize([30,10])circle(d=20);
                    }
                }
            }
        }
        cylinder(r=kakumaru,h=h, $fs = 0.25, $fa = 1);
    }

}

module decoration() {
    translate([0, 2.5, 0]) {
        cylinder(r = cir_d, h = thick * 2, center = true, $fs = 0.01, $fa = 0.25);
    }
    translate([0, -10.5, 0]) {
        cylinder(r = 1.0, h = thick * 2, center = true, $fs = 0.01, $fa = 0.25);
    }
    translate([0, 2.5 + (center_len/2), 0]) {
        cube([0.75, center_len, thick * 2], center = true);
    }
    translate([3.0, -3.5, 0]) {
        deco_bar();
    }
    translate([-3.0, -3.5, 0]) {
        deco_bar();
    }
    translate([6.0, -3.5, 0]) {
        cube([5.0, 1.0, thick * 2], center = true);
    }
    translate([-6.0, -3.5, 0]) {
        cube([5.0, 1.0, thick * 2], center = true);
    }
}

module deco_bar() {
    linear_extrude(height = thick * 2, center = true) {
        union() {
            square([1.0, bar - 1.0], center = true);
            translate([0, 2.5, 0]) {
                circle(r = 0.5);
            }
            translate([0, -2.5, 0]) {
                circle(r = 0.5);
            }
        }
    }
}

enko = 100;

difference() {
    intersection() {
        difference() {
            pen_outer();
            decoration();

            translate([0, -5.0, -1/4 * enko]) {
                resize([enko/3, enko, enko/2])sphere(r = enko);
            }
        }
        translate([0, -5.0, -1/4 * enko + (thick/10)]) {
            resize([enko/3, enko, enko/2])sphere(r = enko);
        }
    }
}