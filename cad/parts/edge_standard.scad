// ====================================================================
// 2. Standard Frame Edge Strut (Part 2 of 8)
// Standardized 185 mm structural beam
// Features Male wedge on +Y end, Female open-top pocket on -Y end
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module edge_standard(
    length = FRAME_EDGE_LEN,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    has_spline = true
) {
    difference() {
        // Main solid beam body
        cube([width, length, height], center = true);
        
        // Outer face spline groove (along Y axis on +X face)
        if (has_spline) {
            translate([width/2, 0, 0])
            rotate([0, 90, 0])
            spline_groove_negative(length = length + 2, axis = "Y");
        }
        
        // Female open-top wedge pocket at -Y end
        translate([0, -length/2, 0])
        rotate([0, 0, 180])
        female_dovetail_pocket(w = width, h = height);
        
        // Internal weight reduction channel
        rotate([90, 0, 0])
        cylinder(d = 10, h = length - (DOVETAIL_DEPTH * 2 + 6), center = true);
    }
    
    // Male wedge tenon at +Y end
    translate([0, length/2, 0])
    male_dovetail(w = width, h = height);
}

// Standalone preview
edge_standard();
