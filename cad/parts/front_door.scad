// ====================================================================
// Dual French Front Doors (Left & Right)
// Modular rigid door leaves with perimeter cellophane spline grooves
// Every piece <= 240 mm (comfortably printable on Bambu Lab A1)
// Cellophane is mounted directly ON THE DOORS, not the front frame!
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>

DOOR_LEAF_W = (INTERNAL_WIDTH / 2) - 4.0; // ~276 mm per door leaf
DOOR_LEAF_H = INTERNAL_HEIGHT - 6.0;      // ~704 mm total height
D_PROFILE_W = 18.0; // Width of door frame strut across face
D_PROFILE_T = 16.0; // Thickness of door frame strut

// ----------------------------------------------------
// 1. Rigid Corner Mortise Joint (Connects rails to stiles)
// ----------------------------------------------------
module door_corner_tenon() {
    // 10mm wide x 12mm deep tongue centered in profile
    translate([0, 6, 0])
    cube([D_PROFILE_W - 6, 12, D_PROFILE_T - 4], center = true);
}

module door_corner_mortise() {
    translate([0, 6, 0])
    cube([D_PROFILE_W - 6 + 2*TOL_DOVETAIL, 12.5, D_PROFILE_T - 4 + 2*TOL_DOVETAIL], center = true);
}

// ----------------------------------------------------
// 2. Door Horizontal Rail (Top or Bottom Crossbar)
// Fits diagonally on A1 bed (276mm < 362mm diagonal),
// or can be split into two 138mm halves.
// ----------------------------------------------------
module door_rail(length = DOOR_LEAF_W, is_top = true) {
    difference() {
        cube([length, D_PROFILE_W, D_PROFILE_T], center = true);
        
        // Spline groove on FRONT (+Z) face along X axis
        translate([0, 0, D_PROFILE_T/2])
        spline_groove_negative(length = length - 2*D_PROFILE_W + 2, axis = "X");
        
        // Corner mortise pockets at both ends (to receive stiles)
        translate([-length/2, 0, 0])
        rotate([0, 0, -90])
        door_corner_mortise();
        
        translate([length/2, 0, 0])
        rotate([0, 0, 90])
        door_corner_mortise();
    }
}

// ----------------------------------------------------
// 3. Door Vertical Stile Segment (Outer Hinge Stile or Inner Meeting Stile)
// Split into 3 segments (~234 mm each) to easily print straight on A1 bed
// ----------------------------------------------------
module door_stile_segment(
    length = DOOR_LEAF_H / 3,
    is_outer_hinge = true,
    is_left_door = true,
    has_hinge = true,
    is_top_segment = false,
    is_bottom_segment = false
) {
    difference() {
        union() {
            // Main stile beam body
            cube([D_PROFILE_W, length, D_PROFILE_T], center = true);
            
            // Integrated Male Hinge Knuckle on outer edge
            if (is_outer_hinge && has_hinge) {
                // Knuckle projects from outer edge
                translate([-D_PROFILE_W/2 - 4.5, 0, 0])
                rotate([90, 0, 0])
                hinge_male_knuckle();
            }
            
            // Overlap draft baffle flange on inner meeting stile (Left door only)
            if (!is_outer_hinge && is_left_door) {
                translate([D_PROFILE_W/2 + 4.0, 0, -D_PROFILE_T/4])
                cube([8.0, length, D_PROFILE_T/2], center = true);
            }
            
            // Tenons at top and bottom ends for corner connections
            if (is_top_segment) {
                translate([0, length/2, 0])
                rotate([0, 0, 180])
                door_corner_tenon();
            }
            if (is_bottom_segment) {
                translate([0, -length/2, 0])
                door_corner_tenon();
            }
        }
        
        // Spline groove on FRONT (+Z) face along Y axis
        translate([0, 0, D_PROFILE_T/2])
        spline_groove_negative(length = length + 2, axis = "Y");
        
        // Segment-to-segment alignment mortise at joint ends
        if (!is_bottom_segment) {
            translate([0, -length/2, 0])
            door_corner_mortise();
        }
    }
    
    // Segment-to-segment alignment tenon
    if (!is_top_segment) {
        translate([0, length/2, 0])
        rotate([0, 0, 180])
        door_corner_tenon();
    }
}

// ----------------------------------------------------
// 4. Ergonomic Handle & Magnetic/Ball Latch
// ----------------------------------------------------
module door_handle_latch() {
    difference() {
        union() {
            // Sleeve body to slide over inner door stile
            cube([D_PROFILE_W + 3, 50, D_PROFILE_T + 3], center = true);
            
            // Ergonomic pull handle
            translate([18, 0, 0])
            hull() {
                translate([0, -16, 0]) sphere(r = 5);
                translate([0,  16, 0]) sphere(r = 5);
                translate([10,  0, 0]) sphere(r = 6);
            }
            
            // Spring snap ball detent on latch edge
            translate([-D_PROFILE_W/2 - 4, 0, 0])
            sphere(r = 3.5);
        }
        
        // Center hollow slot for stile
        cube([D_PROFILE_W + TOL_TIGHT, 50.2, D_PROFILE_T + TOL_TIGHT], center = true);
    }
}

// ----------------------------------------------------
// 5. Complete Door Leaf Assembly Preview
// ----------------------------------------------------
module full_door_leaf_preview(is_left = true) {
    color([0.2, 0.6, 0.85, 0.9]) {
        // Top Rail
        translate([DOOR_LEAF_W/2, DOOR_LEAF_H/2 - D_PROFILE_W/2, 0])
        door_rail(length = DOOR_LEAF_W, is_top = true);
        
        // Bottom Rail
        translate([DOOR_LEAF_W/2, -DOOR_LEAF_H/2 + D_PROFILE_W/2, 0])
        door_rail(length = DOOR_LEAF_W, is_top = false);
        
        // Outer Hinge Stile (3 segments)
        seg_h = DOOR_LEAF_H / 3;
        for (i = [-1 : 1]) {
            translate([D_PROFILE_W/2, i * seg_h, 0])
            door_stile_segment(
                length = seg_h,
                is_outer_hinge = true,
                is_left_door = is_left,
                has_hinge = true,
                is_top_segment = (i == 1),
                is_bottom_segment = (i == -1)
            );
        }
        
        // Inner Meeting Stile (3 segments)
        for (i = [-1 : 1]) {
            translate([DOOR_LEAF_W - D_PROFILE_W/2, i * seg_h, 0])
            door_stile_segment(
                length = seg_h,
                is_outer_hinge = false,
                is_left_door = is_left,
                has_hinge = false,
                is_top_segment = (i == 1),
                is_bottom_segment = (i == -1)
            );
        }
        
        // Handle
        translate([DOOR_LEAF_W - D_PROFILE_W/2, 0, 0])
        door_handle_latch();
    }
}

// Default preview: single printable stile segment with hinge
door_stile_segment(is_outer_hinge = true, has_hinge = true);
