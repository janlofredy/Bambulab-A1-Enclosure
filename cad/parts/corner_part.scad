// ====================================================================
// 1. Universal Directional 3-Way Corner Block (Part 1 of 8)
// 100% 3D Printable on Bambu Lab A1
// Features 2 Female wedge sockets and 1 Male wedge tenon.
// Rotated at each vertex of the 8 enclosure corners for continuous daisy-chaining.
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module corner_part() {
    cs = CORNER_SIZE;
    bw = BEAM_WIDTH;
    bh = BEAM_HEIGHT;
    
    difference() {
        union() {
            // Main cubic body
            cube([cs, cs, cs], center = false);
            
            // Male wedge tenon on +Z face (projects in +Z direction)
            translate([bw/2, bh/2, cs])
            rotate([-90, 0, 0])
            male_dovetail(w = bw, h = bh);
        }
        
        // Inner corner clearance for weight reduction and clean interior
        translate([bw, bw, 0])
        cube([cs, cs, cs + 1], center = false);
        
        // Female wedge socket on +X face (recesses into -X)
        translate([cs, bw/2, bh/2])
        rotate([0, 0, -90])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Female wedge socket on +Y face (recesses into -Y)
        translate([bw/2, cs, bh/2])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Outer spline groove for static wall cellophane
        translate([0, cs/2, bh/2])
        rotate([0, -90, 0])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // Rubber bumper foot recess on bottom face
        translate([bw/2, bw/2, 0])
        cylinder(d = 12, h = 3, center = true);
    }
}

// Standalone preview
corner_part();
