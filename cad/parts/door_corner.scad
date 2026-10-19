// ====================================================================
// 5. Door L-Corner Block (Part 5 of 8)
// 90° Corner block for modular slim door leaves (18 x 16 mm profile)
// Features 1 mini male wedge dovetail tenon and 1 mini female open-top socket
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module door_corner() {
    cw = DOOR_CORNER_W; // 25 mm
    pw = DOOR_PROFILE_W; // 18 mm
    pt = DOOR_PROFILE_T; // 16 mm
    
    difference() {
        union() {
            // L-shaped corner body
            cube([cw, cw, pt], center = false);
            
            // Mini male wedge tenon on +X face (projects in +X direction)
            translate([cw, pw/2, pt/2])
            rotate([0, 0, -90])
            mini_male_dovetail(w = pw, h = pt);
        }
        
        // Inner corner cutout
        translate([pw, pw, -1])
        cube([cw, cw, pt + 2], center = false);
        
        // Mini female wedge socket on +Y face (recesses into -Y)
        translate([pw/2, cw, pt/2])
        mini_female_dovetail_pocket(w = pw, h = pt);
        
        // Spline groove on front (+Z) face around corner
        translate([pw/2, cw/2, pt])
        spline_groove_negative(length = cw + 2, axis = "Y");
        
        translate([cw/2, pw/2, pt])
        spline_groove_negative(length = cw + 2, axis = "X");
    }
}

// Standalone preview
door_corner();
