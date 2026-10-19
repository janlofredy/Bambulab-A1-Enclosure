// ====================================================================
// Top 3-Way Corner Junction Block
// Connects Top X-Beam, Top Y-Beam, Vertical Z-Pillar, and Door Hinges
// 100% 3D Printable on Bambu Lab A1
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>

module top_corner(is_front = true, is_left = true) {
    cs = CORNER_BLOCK_SIZE;
    bw = BEAM_WIDTH;
    bh = BEAM_HEIGHT;
    
    difference() {
        union() {
            // Main Corner Cubic Body
            cube([cs, cs, cs], center = false);
            
            // Integrated Top Roof Hinge Knuckle (along Y rail)
            translate([is_left ? bw/4 : cs - bw/4, cs/2, cs])
            rotate([90, 0, 0])
            hinge_female_knuckle();
            
            // If Front Corner: Integrated Front French Door Hinge Knuckle
            if (is_front) {
                translate([is_left ? 0 : cs, cs/4, cs/2])
                rotate([0, 0, 0])
                hinge_female_knuckle();
            }
        }
        
        // Inner clearance
        translate([bw, bw, 0])
        cube([cs, cs, cs - bh], center = false);
        
        // Spline groove on top face (+Z)
        translate([cs/2, cs/2, cs])
        spline_groove_negative(length = cs + 2);
        
        // Female Dovetail Socket for X Beam (+X face)
        translate([cs, bw/2, cs - bh/2])
        rotate([0, 0, 180])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Female Dovetail Socket for Y Beam (+Y face)
        translate([bw/2, cs, cs - bh/2])
        rotate([0, 0, -90])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Female Dovetail Socket for Vertical Z Pillar (-Z face)
        translate([bw/2, bh/2, 0])
        rotate([-90, 0, 0])
        female_dovetail_pocket(w = bw, h = bh);
    }
}

// Standalone render
top_corner(is_front = true, is_left = true);
