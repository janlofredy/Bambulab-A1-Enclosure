// ====================================================================
// 7. Door Edge with Handle & Draft Flange (Part 7 of 8)
// Standardized 138 mm slim door strut with integrated ergonomic pull handle
// and 8 mm draft-stop overlap lip for the center meeting seam
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <door_edge.scad>

module door_edge_handle(
    length = DOOR_EDGE_LEN,
    width  = DOOR_PROFILE_W,
    thick  = DOOR_PROFILE_T,
    is_left_door = true
) {
    union() {
        // Base door edge body
        door_edge(length = length, width = width, thick = thick);
        
        // Ergonomic curved pull handle (protrudes forward in +Z)
        translate([is_left_door ? -width/4 : width/4, 0, thick/2 + 10])
        hull() {
            translate([0, -18, 0]) sphere(r = 5);
            translate([0,  18, 0]) sphere(r = 5);
            translate([is_left_door ? -8 : 8, 0, 4]) sphere(r = 6);
        }
        
        // Draft-stop overlap lip (seals center seam between French doors)
        if (is_left_door) {
            translate([width/2 + 4.0, 0, -thick/4])
            cube([8.0, length, thick/2], center = true);
        }
    }
}

// Standalone preview
door_edge_handle();
