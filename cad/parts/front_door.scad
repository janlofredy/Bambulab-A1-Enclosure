// ====================================================================
// Dual French Front Doors (Left & Right)
// Modular 4-piece door leaf frame with spline grooves, hinges, & latches
// Every piece <= 240 mm (comfortably fits on Bambu Lab A1)
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>

DOOR_WIDTH = (INTERNAL_WIDTH / 2) - 3.0; // ~277 mm per door leaf
DOOR_HEIGHT = INTERNAL_HEIGHT - 6.0;     // ~704 mm total height
FRAME_THICK = 16.0; // Profile thickness
FRAME_DEPTH = 16.0;

// Corner Joint for Door Sub-assembly (Miter dovetail)
module door_corner_joint(is_male = true) {
    if (is_male) {
        translate([0, 0, 0])
        rotate([0, 0, 90])
        male_dovetail(w = FRAME_THICK, h = FRAME_DEPTH, depth = 12);
    } else {
        translate([0, 0, 0])
        rotate([0, 0, -90])
        female_dovetail_pocket(w = FRAME_THICK, h = FRAME_DEPTH, depth = 12);
    }
}

// 1. Door Horizontal Rail (Top or Bottom Segment)
// Split into 2 interlocking segments (~125 mm each) to easily print on A1 bed
module door_rail(length = (DOOR_WIDTH - 2*FRAME_THICK) / 2) {
    difference() {
        cube([length, FRAME_THICK, FRAME_DEPTH], center = true);
        
        // Spline groove facing inward for cellophane panel
        translate([0, 0, 0])
        rotate([0, 90, 0])
        spline_groove_negative(length = length + 2);
        
        // Female joint at one end
        translate([-length/2, 0, 0])
        door_corner_joint(is_male = false);
    }
    
    // Male joint at other end
    translate([length/2, 0, 0])
    door_corner_joint(is_male = true);
}

// 2. Door Vertical Stile Segment (Interlocking to form 704 mm height)
// Height split into 3 segments (~230 mm each)
module door_stile_segment(length = DOOR_HEIGHT / 3, is_hinge_segment = false) {
    difference() {
        union() {
            cube([FRAME_THICK, length, FRAME_DEPTH], center = true);
            
            // Integrated Male Hinge Knuckle if selected
            if (is_hinge_segment) {
                translate([-FRAME_THICK/2 - 4.5, 0, 0])
                rotate([0, 0, 90])
                hinge_male_knuckle();
            }
        }
        
        // Spline groove facing inward
        translate([FRAME_THICK/2, 0, 0])
        rotate([90, 0, 0])
        spline_groove_negative(length = length + 2);
        
        // Female joint at bottom
        translate([0, -length/2, 0])
        rotate([0, 0, 90])
        female_dovetail_pocket(w = FRAME_THICK, h = FRAME_DEPTH, depth = 12);
    }
    
    // Male joint at top
    translate([0, length/2, 0])
    rotate([0, 0, -90])
    male_dovetail(w = FRAME_THICK, h = FRAME_DEPTH, depth = 12);
}

// 3. Ergonomic Door Handle with Snap Latch
module door_handle_latch() {
    difference() {
        union() {
            // Mounting plate (clips or pins to door stile)
            cube([FRAME_THICK + 2, 45, FRAME_DEPTH + 2], center = true);
            
            // Ergonomic Curved Pull Handle
            translate([18, 0, 0])
            hull() {
                translate([0, -15, 0]) sphere(r = 5);
                translate([0,  15, 0]) sphere(r = 5);
                translate([8,   0, 0]) sphere(r = 6);
            }
            
            // Spring Snap Detent Ball
            translate([-FRAME_THICK/2 - 3, 0, 0])
            sphere(r = 3.5);
        }
        
        // Center slot to slip over door stile
        cube([FRAME_THICK + TOL_TIGHT, 45 + 0.2, FRAME_DEPTH + TOL_TIGHT], center = true);
    }
}

// Preview door stile segment with hinge
door_stile_segment(is_hinge_segment = true);
