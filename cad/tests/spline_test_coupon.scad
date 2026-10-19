// ====================================================================
// Cellophane Spline Fit Test Coupon (Multi-Grip Test Suite)
// Includes 1 frame groove block and 3 spring-clamp clip variants:
//   - Clip A: Standard (4.8mm dual-barb spring clamp)
//   - Clip B: Tight (+0.2mm heavy-tension spring clamp)
//   - Clip C: Extra-Tight (+0.4mm maximum-bite wedge clamp)
// Test all 3 with your packaging cellophane to choose your preferred grip!
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>

coupon_len = 50.0; // 50 mm test length

echo(str("=== SPLINE MULTI-GRIP TEST COUPON ==="));
echo(str("Frame Block : 24 x ", coupon_len, " x 24 mm with undercut spline groove"));
echo(str("Clip A (Std): 4.8 mm dual-barb spring clamp (Split-core compliant)"));
echo(str("Clip B (Tight): 5.0 mm heavy-tension spring clamp (+0.2 mm)"));
echo(str("Clip C (Extra): 5.2 mm ultra-bite spring clamp (+0.4 mm)"));

// ----------------------------------------------------
// 1. Frame Groove Block (Rests flat on print bed at Z=0)
// ----------------------------------------------------
translate([-22, 0, BEAM_HEIGHT/2])
difference() {
    cube([BEAM_WIDTH, coupon_len, BEAM_HEIGHT], center = true);
    
    // Spline groove running along the full 50 mm length (Y axis) on top face
    translate([0, 0, BEAM_HEIGHT/2])
    spline_groove_negative(length = coupon_len + 2, axis = "Y");
    
    // Label embossed on side
    translate([-BEAM_WIDTH/2 + 0.6, 0, 0])
    rotate([90, 0, -90])
    linear_extrude(height = 1)
    text("GROOVE", size = 4.0, halign = "center", valign = "center");
}

// ----------------------------------------------------
// 2. Clip A: Standard (4.8 mm barbs) - Laid flat at Z=0
// ----------------------------------------------------
translate([0, 0, 3.5])
rotate([0, 90, 0])
spline_clip(length = coupon_len, axis = "Y", width_offset = 0.0);

// ----------------------------------------------------
// 3. Clip B: Tight (+0.2 mm / 5.0 mm barbs) - Laid flat at Z=0
// ----------------------------------------------------
translate([12, 0, 3.5])
rotate([0, 90, 0])
spline_clip(length = coupon_len, axis = "Y", width_offset = 0.2);

// ----------------------------------------------------
// 4. Clip C: Extra-Tight (+0.4 mm / 5.2 mm barbs) - Laid flat at Z=0
// ----------------------------------------------------
translate([24, 0, 3.5])
rotate([0, 90, 0])
spline_clip(length = coupon_len, axis = "Y", width_offset = 0.4);
