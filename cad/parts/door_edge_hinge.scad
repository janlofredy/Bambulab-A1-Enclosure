// ====================================================================
// 8. Door Edge with Hinge Knuckle (Part 8 of 8)
// Standardized 138 mm slim door strut with integrated male hinge knuckle
// Interlocks directly with the frame's edge_hinge.scad for face-overlay doors
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>
use <door_edge.scad>

module door_edge_hinge(
    length = DOOR_EDGE_LEN,
    width  = DOOR_PROFILE_W,
    thick  = DOOR_PROFILE_T,
    is_left_door = true
) {
    union() {
        // Base door edge body
        door_edge(length = length, width = width, thick = thick);
        
        // Offset male hinge knuckle
        offset_x = is_left_door ? -width/2 - 4.5 : width/2 + 4.5;
        translate([offset_x, 0, 0])
        rotate([90, 0, 0])
        hinge_male_knuckle();
    }
}

// Standalone preview
door_edge_hinge();
