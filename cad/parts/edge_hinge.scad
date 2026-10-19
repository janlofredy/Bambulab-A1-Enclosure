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
    has_spline = true,
    is_left_pillar = undef
) {
    barrel_od = 10.0;
    pin_id = 5.0;
    knuckle_h = 28.0;
    center_gap = 12.0;
    tol = TOL_HINGE;
    
    // Knuckle sits at the corner between the +X and +Z spline slots
    kx = width/2;
    kz = height/2;
    
    difference() {
        union() {
            // Base strut with continuous spline slots
            edge_standard(length = length, width = width, height = height, has_spline = has_spline);
            
            // Solid female hinge knuckle at corner
            translate([kx, 0, kz])
            rotate([90, 0, 0])
            cylinder(d = barrel_od, h = knuckle_h, center = true, $fn = 32);
        }
        
        // Center pocket cutout for male knuckle
        translate([kx, 0, kz])
        cube([barrel_od + 4, center_gap + 2*tol, barrel_od + 4], center = true);
        
        // Pin hole along Y axis
        translate([kx, 0, kz])
        rotate([90, 0, 0])
        cylinder(d = pin_id + tol, h = knuckle_h + 4, center = true, $fn = 32);
    }
}

// Standalone preview
edge_hinge();
