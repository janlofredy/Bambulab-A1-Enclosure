// ====================================================================
// Modular Frame Beam Strut Segment
// Parametric segmented beam with dovetails, pin holes, and spline grooves
// Fits comfortably on Bambu Lab A1 printbed (<= 240 mm)
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

// Beam segment with selectable end joints
module beam_segment(
    length = SEG_LEN_X,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    end1_male = true,
    end2_male = false,
    has_spline_top = true,
    has_spline_outer = true
) {
    difference() {
        // Main solid beam body
        cube([width, length, height], center = true);
        
        // Outer face spline groove (along Y axis on +X face)
        if (has_spline_outer) {
            translate([width/2, 0, 0])
            rotate([0, 90, 0])
            spline_groove_negative(length = length + 2);
        }
        
        // Top/Bottom face spline groove (along Y axis on +Z face)
        if (has_spline_top) {
            translate([0, 0, height/2])
            spline_groove_negative(length = length + 2);
        }
        
        // Female Dovetail Socket at -Y end if not male
        if (!end1_male) {
            translate([0, -length/2, 0])
            rotate([0, 0, 90])
            female_dovetail_pocket(w = width, h = height);
        }
        
        // Female Dovetail Socket at +Y end if not male
        if (!end2_male) {
            translate([0, length/2, 0])
            rotate([0, 0, -90])
            female_dovetail_pocket(w = width, h = height);
        }
        
        // Internal weight reduction chamfers/channel through core
        rotate([90, 0, 0])
        cylinder(d = 10, h = length - (DOVETAIL_DEPTH * 2 + 10), center = true);
    }
    
    // Male Dovetail Tenon at -Y end
    if (end1_male) {
        translate([0, -length/2, 0])
        rotate([0, 0, 90])
        male_dovetail(w = width, h = height);
    }
    
    // Male Dovetail Tenon at +Y end
    if (end2_male) {
        translate([0, length/2, 0])
        rotate([0, 0, -90])
        male_dovetail(w = width, h = height);
    }
}

// Preset parts for easy slicing:

// Standard Male-Female Intermediate Segment
module beam_x_mid() {
    beam_segment(length = SEG_LEN_X, end1_male = true, end2_male = false);
}

// Male-Male End Segment (bridges into opposing female corner socket)
module beam_x_end() {
    beam_segment(length = SEG_LEN_X, end1_male = true, end2_male = true);
}

// Depth (Y) Intermediate Segment
module beam_y_mid() {
    beam_segment(length = SEG_LEN_Y, end1_male = true, end2_male = false);
}

// Depth (Y) End Segment
module beam_y_end() {
    beam_segment(length = SEG_LEN_Y, end1_male = true, end2_male = true);
}

// Vertical (Z) Intermediate Segment
module beam_z_mid() {
    beam_segment(length = SEG_LEN_Z, end1_male = true, end2_male = false);
}

// Vertical (Z) End Segment
module beam_z_end() {
    beam_segment(length = SEG_LEN_Z, end1_male = true, end2_male = true);
}

// Preview default
beam_x_mid();
