// ====================================================================
// Cellophane Spline Fit Test Coupon (Quick 15-minute test print)
// Print this first with a scrap of packaging cellophane to test snap tension
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>

coupon_len = 50.0;

// Frame Groove Block
translate([0, -15, BEAM_HEIGHT/2])
difference() {
    cube([BEAM_WIDTH, coupon_len, BEAM_HEIGHT], center = true);
    
    // Spline groove on top face
    translate([0, 0, BEAM_HEIGHT/2])
    spline_groove_negative(length = coupon_len + 2);
}

// Matching Snap-in Spline Clip
translate([0, 15, SPLINE_HEIGHT/2])
spline_clip(length = coupon_len);
