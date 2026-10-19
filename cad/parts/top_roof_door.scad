// ====================================================================
// Dual Top Roof Doors with Integrated Heat Dissipation Prop Legs
// Opens upward to vent heat during PLA/PETG printing or close for draft protection
// Fully modular and printable on Bambu Lab A1
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>

ROOF_DOOR_WIDTH = (INTERNAL_WIDTH / 2) - 4.0; // ~276 mm per door leaf
ROOF_DOOR_DEPTH = INTERNAL_DEPTH - 6.0;        // ~574 mm total depth
ROOF_FRAME_W = 16.0;
ROOF_FRAME_H = 16.0;

// 1. Roof Door Depth Stile Segment (Hinged to the top side frame beam)
// Depth split into 3 segments (~190 mm each)
module roof_stile_segment(length = ROOF_DOOR_DEPTH / 3, is_hinge = false) {
    difference() {
        union() {
            cube([ROOF_FRAME_W, length, ROOF_FRAME_H], center = true);
            
            // Integrated Male Hinge Knuckle on outer edge
            if (is_hinge) {
                translate([-ROOF_FRAME_W/2 - 4.5, 0, 0])
                rotate([90, 0, 0])
                hinge_male_knuckle();
            }
        }
        
        // Spline groove for top cellophane panel facing inward (+X)
        translate([ROOF_FRAME_W/2, 0, 0])
        rotate([0, 90, 0])
        spline_groove_negative(length = length + 2, axis = "Y");
        
        // Female joint at -Y end
        translate([0, -length/2, 0])
        rotate([0, 0, 90])
        female_dovetail_pocket(w = ROOF_FRAME_W, h = ROOF_FRAME_H, depth = 12);
    }
    
    // Male joint at +Y end
    translate([0, length/2, 0])
    rotate([0, 0, -90])
    male_dovetail(w = ROOF_FRAME_W, h = ROOF_FRAME_H, depth = 12);
}

// 2. Center Meeting Stile Segment with Prop-Leg Pivot & Detent Socket
module roof_center_stile(length = ROOF_DOOR_DEPTH / 3) {
    difference() {
        cube([ROOF_FRAME_W, length, ROOF_FRAME_H], center = true);
        
        // Spline groove facing inward (-X)
        translate([-ROOF_FRAME_W/2, 0, 0])
        rotate([0, -90, 0])
        spline_groove_negative(length = length + 2, axis = "Y");
        
        // Female joint at -Y end
        translate([0, -length/2, 0])
        rotate([0, 0, 90])
        female_dovetail_pocket(w = ROOF_FRAME_W, h = ROOF_FRAME_H, depth = 12);
        
        // Pivot socket for prop leg
        translate([0, 0, -ROOF_FRAME_H/2 + 3])
        rotate([0, 90, 0])
        cylinder(d = 4.5, h = ROOF_FRAME_W + 2, center = true);
    }
    
    // Male joint at +Y end
    translate([0, length/2, 0])
    rotate([0, 0, -90])
    male_dovetail(w = ROOF_FRAME_W, h = ROOF_FRAME_H, depth = 12);
}

// 3. Integrated Multi-Angle Prop Leg (Kickstand)
// Folds flat into the door frame when closed, props open at 30 deg, 60 deg, or 90 deg
module roof_prop_leg(length = 135) {
    leg_w = 12.0;
    leg_t = 6.0;
    
    union() {
        // Pivot head with detent cam
        difference() {
            cylinder(d = leg_w, h = leg_t, center = true);
            cylinder(d = 4.2, h = leg_t + 2, center = true); // Pivot pin hole
            
            // Angular detent notches (30 deg, 60 deg)
            for (ang = [30, 60]) {
                rotate([0, 0, ang])
                translate([leg_w/2, 0, 0])
                sphere(r = 1.2);
            }
        }
        
        // Strut body
        translate([0, length/2, 0])
        cube([leg_w, length, leg_t], center = true);
        
        // Non-slip foot with resting notch
        translate([0, length, 0])
        difference() {
            cylinder(d = leg_w + 4, h = leg_t, center = true);
            translate([0, 3, 0])
            cube([leg_w + 6, 4, leg_t + 2], center = true);
        }
    }
}

// Preview prop leg
roof_prop_leg();
