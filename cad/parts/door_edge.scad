// ====================================================================
// 6. Standard Door Edge Strut (Part 6 of 8)
// Standardized 138 mm slim door frame strut (18 x 16 mm profile)
// Features mini male wedge on +Y end, mini female open-top pocket on -Y end
// Front-facing spline groove for mounting cellophane directly on the door
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module door_edge(
    length = DOOR_EDGE_LEN,
    width  = DOOR_PROFILE_W,
    thick  = DOOR_PROFILE_T
) {
    difference() {
        // Main door frame strut body
        cube([width, length, thick], center = true);
        
        // Spline groove on FRONT (+Z) face along Y axis
        // Uses DOOR_SPLINE_LEN so mini-dovetails (8mm) do not reach the spline slots
        translate([0, 0, thick/2])
        spline_groove_negative(length = DOOR_SPLINE_LEN, axis = "Y");
        
        // Mini female open-top wedge pocket at -Y end
        translate([0, -length/2, 0])
        rotate([0, 0, 180])
        mini_female_dovetail_pocket(w = width, h = thick);
    }
    
    // Mini male wedge tenon at +Y end
    translate([0, length/2, 0])
    mini_male_dovetail(w = width, h = thick);
}

// Standalone preview
door_edge();
