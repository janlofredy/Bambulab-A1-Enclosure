// ====================================================================
// Bottom 3-Way Corner Junction Block
// Connects Bottom X-Beam, Bottom Y-Beam, and Vertical Z-Pillar
// 100% 3D Printable on Bambu Lab A1
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module bottom_corner(is_front = true, is_left = true) {
    cs = CORNER_BLOCK_SIZE;
    bw = BEAM_WIDTH;
    bh = BEAM_HEIGHT;
    
    difference() {
        // Main Corner Cubic Body with Filleted Outer Edge
        cube([cs, cs, cs], center = false);
        
        // Hollow / Chamfer inner corner for weight saving and clean clearance
        translate([bw, bw, bw])
        cube([cs, cs, cs], center = false);
        
        // Spline groove on bottom face (-Z)
        translate([cs/2, cs/2, 0])
        spline_groove_negative(length = cs + 2);
        
        // Spline groove on outer faces
        translate([0, cs/2, cs/2])
        rotate([0, 90, 0])
        spline_groove_negative(length = cs + 2);
        
        // Female Dovetail Socket for X Beam (+X face)
        translate([cs, bw/2, bh/2])
        rotate([0, 0, 180])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Female Dovetail Socket for Y Beam (+Y face)
        translate([bw/2, cs, bh/2])
        rotate([0, 0, -90])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Female Dovetail Socket for Vertical Z Pillar (+Z face)
        translate([bw/2, bh/2, cs])
        rotate([90, 0, 0])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Rubber bumper / foot recess on bottom face
        translate([bw/2, bw/2, 0])
        cylinder(d = 12, h = 3, center = true);
    }
}

// Standalone render
bottom_corner();
