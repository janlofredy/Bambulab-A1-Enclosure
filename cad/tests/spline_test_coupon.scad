// ====================================================================
// Cellophane Spline Fit Test Coupon (Quick 15-minute test print)
// Print this first with a scrap of packaging cellophane to test snap tension
// Both parts are placed flat on the print bed (Z=0) running along Y axis
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>

coupon_len = 50.0; // 50 mm test length

echo(str("=== SPLINE TEST COUPON DIMENSIONS ==="));
echo(str("Frame Block : Width(X) = ", BEAM_WIDTH, " mm, Length(Y) = ", coupon_len, " mm, Height(Z) = ", BEAM_HEIGHT, " mm"));
echo(str("Groove      : Width = ", GROOVE_WIDTH, " mm, Depth = ", GROOVE_DEPTH, " mm (Runs along 50mm Y)"));
echo(str("Spline Clip : Width = 6.8 mm (cap) / 3.9 mm (shaft), Length(Y) = ", coupon_len, " mm, Height = 6.4 mm"));

// ----------------------------------------------------
// 1. Frame Groove Block (Rests on print bed at Z=0)
// ----------------------------------------------------
translate([-BEAM_WIDTH/2 - 8, 0, BEAM_HEIGHT/2])
difference() {
    // 24 x 50 x 24 mm block
    cube([BEAM_WIDTH, coupon_len, BEAM_HEIGHT], center = true);
    
    // Spline groove running along the full 50 mm length (Y axis) on top face
    translate([0, 0, BEAM_HEIGHT/2])
    spline_groove_negative(length = coupon_len + 2, axis = "Y");
    
    // Label embossed on side for quick identification
    translate([BEAM_WIDTH/2 - 0.6, 0, 0])
    rotate([90, 0, 90])
    linear_extrude(height = 1)
    text("SPLINE TEST", size = 4.5, halign = "center", valign = "center");
}

// ----------------------------------------------------
// 2. Matching Snap-in Spline Clip (Rests flat on print bed at Z=0)
// Oriented parallel along Y axis with flat side down for clean printing
// ----------------------------------------------------
translate([BEAM_WIDTH/2 + 8, 0, 3.4])
rotate([0, 90, 0]) // Lay on flat side for clean, strong layer orientation
spline_clip(length = coupon_len, axis = "Y");
