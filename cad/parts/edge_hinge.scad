// ====================================================================
// 3. Frame Edge with Door Hinge (Part 3 of 8)
// Standardized 185 mm structural beam with integrated female hinge knuckle
// Replaces 1 spline side (+Z) with the hinge knuckle.
// Side wall cellophane spline is on +X; door side is on opposite side (-X).
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>
use <edge_standard.scad>

module edge_hinge(
    length = FRAME_EDGE_LEN,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    is_left_pillar = true
) {
    knuckle_x = is_left_pillar ? (-width/2 + 4.0) : (width/2 - 4.0);
    union() {
        // Base edge body:
        // has_spline_x = true (side wall cellophane)
        // has_spline_z = false (replaced by hinge)
        edge_standard(
            length = length,
            width  = width,
            height = height,
            has_spline_x = true,
            has_spline_z = false
        );
        
        // Female hinge knuckle on +Z face (replacing 1 spline side)
        // Positioned toward the door side (-X on left pillar, +X on right pillar)
        // Offset forward so the overlay door swings 180° flat against the side
        translate([knuckle_x, 0, height/2 + 2.0])
        rotate([90, 0, 0])
        hinge_female_knuckle();
    }
}

// Standalone preview
edge_hinge();
