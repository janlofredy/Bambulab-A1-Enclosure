// ====================================================================
// 3. Frame Edge with Door Hinge (Part 3 of 8)
// Standardized 185 mm structural beam with front-offset female hinge knuckle
// Placed on front vertical pillars to hang the face-overlay French doors
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
    union() {
        // Base edge body (smooth front face, outer spline groove for side wall)
        edge_standard(length = length, width = width, height = height, has_spline = true);
        
        // Front-offset female hinge barrel
        // Offset forward so the overlay door swings 180° flat against the side
        offset_x = is_left_pillar ? -width/2 - 2.0 : width/2 + 2.0;
        translate([offset_x, 0, height/2 + 2.0])
        rotate([90, 0, 0])
        hinge_female_knuckle();
    }
}

// Standalone preview
edge_hinge();
