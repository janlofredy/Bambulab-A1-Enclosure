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
        
        // Solidly anchored ergonomic pull handle with tactile finger hook
        // Rooted directly into door surface at Z = thick/2, offset clear of spline slot
        handle_x = is_left_door ? -width/2 + 2.5 : width/2 - 2.5;
        
        difference() {
            translate([handle_x, 0, thick/2])
            hull() {
                // Anchored directly into door surface (Z=thick/2)
                translate([0, -20, 0]) cube([4.0, 10, 1], center = true);
                translate([0,  20, 0]) cube([4.0, 10, 1], center = true);
                
                // Outer contoured pull wing
                translate([is_left_door ? -4 : 4, -14, 15]) sphere(r = 4.0);
                translate([is_left_door ? -4 : 4,  14, 15]) sphere(r = 4.0);
                translate([is_left_door ? -7 : 7,   0, 17]) sphere(r = 5.0);
            }
            
            // Subtle concave finger-grip scallop on the pulling side
            translate([is_left_door ? -width/2 - 5 : width/2 + 5, 0, thick/2 + 10])
            cylinder(r = 7.5, h = 32, center = true);
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
