// ====================================================================
// 2. Standard Frame Edge Strut (Part 2 of 8)
// Standardized 185 mm structural beam
// Features 2 spline slots on outside edges (+X and +Z faces)
// Features Male wedge on +Y end, Female open-top pocket on -Y end
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module edge_standard(
    length = FRAME_EDGE_LEN,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    has_spline = true,
    has_spline_x = undef,
    has_spline_z = undef
) {
    spline_x = is_undef(has_spline_x) ? has_spline : has_spline_x;
    spline_z = is_undef(has_spline_z) ? has_spline : has_spline_z;

    difference() {
        // Main solid beam body
        cube([width, length, height], center = true);
        
        // Spline slot 1 on outside edge (+X face)
        // Uses FRAME_SPLINE_LEN so dovetails (10mm) do not reach the spline slots
        if (spline_x) {
            translate([width/2, 0, 0])
            rotate([0, 90, 0])
            spline_groove_negative(length = FRAME_SPLINE_LEN, axis = "Y");
        }
        
        // Spline slot 2 on outside edge (+Z face)
        if (spline_z) {
            translate([0, 0, height/2])
            spline_groove_negative(length = FRAME_SPLINE_LEN, axis = "Y");
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
