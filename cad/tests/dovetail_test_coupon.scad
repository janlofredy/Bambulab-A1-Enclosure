// ====================================================================
// Peg-Free Wedge Dovetail Fit Test Coupon (Quick 15-minute test print)
// Print this first on your Bambu Lab A1 to verify the snap wedge fit
// No pins or pegs required - self-locking angled wedge flaps!
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>

test_len = 35.0; // 35 mm test block length

echo(str("=== PEG-FREE WEDGE DOVETAIL TEST COUPON ==="));
echo(str("Female Block : 24 x ", test_len, " x 24 mm with open-top dual-taper pocket"));
echo(str("Male Block   : 24 x ", test_len, " x 24 mm with self-locking angled dovetail tenon"));
echo(str("Fasteners    : ZERO PINS - 100% self-wedging snap fit"));

// ----------------------------------------------------
// 1. Female Test Block (Left side, pocket opens facing forward -Y)
// ----------------------------------------------------
translate([-BEAM_WIDTH/2 - 6, 0, BEAM_HEIGHT/2])
difference() {
    cube([BEAM_WIDTH, test_len, BEAM_HEIGHT], center = true);
    
    // Female pocket opens on -Y face and top (+Z)
    translate([0, -test_len/2, 0])
    rotate([0, 0, 180])
    female_dovetail_pocket(w = BEAM_WIDTH, h = BEAM_HEIGHT);
    
    // Label embossed on top
    translate([0, 6, BEAM_HEIGHT/2 - 0.6])
    linear_extrude(height = 1)
    text("FEMALE", size = 4.0, halign = "center", valign = "center");
}

// ----------------------------------------------------
// 2. Male Test Block (Right side, tenon projects forward -Y)
// ----------------------------------------------------
translate([BEAM_WIDTH/2 + 6, 0, BEAM_HEIGHT/2])
union() {
    cube([BEAM_WIDTH, test_len, BEAM_HEIGHT], center = true);
    
    // Male dovetail tenon starts at -Y face and projects forward in -Y
    translate([0, -test_len/2, 0])
    rotate([0, 0, 180])
    male_dovetail(w = BEAM_WIDTH, h = BEAM_HEIGHT);
    
    // Label embossed on top
    translate([0, 6, BEAM_HEIGHT/2 - 0.6])
    linear_extrude(height = 1)
    text("MALE", size = 4.0, halign = "center", valign = "center");
}
