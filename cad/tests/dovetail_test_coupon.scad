// ====================================================================
// Dovetail Fit Test Coupon (Quick 25-minute test print)
// Print this first on your Bambu Lab A1 to verify joint tolerances
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>

test_len = 35.0;

// Female Test Block
translate([-BEAM_WIDTH - 10, 0, BEAM_HEIGHT/2])
difference() {
    cube([BEAM_WIDTH, test_len, BEAM_HEIGHT], center = true);
    
    translate([0, test_len/2, 0])
    rotate([0, 0, -90])
    female_dovetail_pocket(w = BEAM_WIDTH, h = BEAM_HEIGHT);
}

// Male Test Block
translate([BEAM_WIDTH + 10, 0, BEAM_HEIGHT/2])
union() {
    cube([BEAM_WIDTH, test_len, BEAM_HEIGHT], center = true);
    
    translate([0, -test_len/2, 0])
    rotate([0, 0, 90])
    male_dovetail(w = BEAM_WIDTH, h = BEAM_HEIGHT);
}

// Locking Wedge Pin
translate([0, 0, (BEAM_WIDTH + 6)/2])
locking_taper_pin();
