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
    is_left_door = undef
) {
    barrel_od = 10.0;
    pin_id = 5.0;
    knuckle_h = 11.5;
    tol = TOL_HINGE;
    
    // Male knuckle sits at corner (-width/2, -thick/2)
    kx = -width/2;
    kz = -thick/2;
    
    difference() {
        union() {
            // Base door edge body
            door_edge(length = length, width = width, thick = thick);
            
            // Integrated male knuckle barrel
            translate([kx, 0, kz])
            rotate([90, 0, 0])
            cylinder(d = barrel_od - 0.2, h = knuckle_h, center = true, $fn = 32);
        }
        
        // Pin through-hole along Y axis
        translate([kx, 0, kz])
        rotate([90, 0, 0])
        cylinder(d = pin_id + tol, h = knuckle_h + 4, center = true, $fn = 32);
    }
}

// Standalone preview
door_edge_hinge();
