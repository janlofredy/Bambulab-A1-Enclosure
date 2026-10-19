// ====================================================================
// 3. Frame Edge with Door Hinge (Part 3 of 8)
// Standardized 185 mm structural beam with integrated female hinge knuckle
// Replaces 1 spline side (+Z) with the hinge knuckle.
// Side wall cellophane spline is on +X; door side is on opposite side (-X).
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <../modules/hinge.scad>
use <edge_standard.scad>

module edge_hinge(
    length = FRAME_EDGE_LEN,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    is_left_pillar = true
) {
    union() {
        if (is_left_pillar) {
            // Left pillar:
            // Side wall spline is on +Z face (maps to global -X)
            // Front door face is on +X face (maps to global -Y)
            edge_standard(
                length = length,
                width  = width,
                height = height,
                has_spline_x = false,
                has_spline_z = true
            );
            
            // Female hinge knuckle on +X face (facing front -Y)
            // Offset towards the inside door side (-Z face in local, +X in global)
            translate([width/2 + 2.0, 0, -height/2 + 4.0])
            rotate([90, 0, 0])
            hinge_female_knuckle();
        } else {
            // Right pillar:
            // Side wall spline is on +X face (maps to global +X)
            // Front door face is on +Z face (maps to global -Y)
            edge_standard(
                length = length,
                width  = width,
                height = height,
                has_spline_x = true,
                has_spline_z = false
            );
            
            // Female hinge knuckle on +Z face (facing front -Y)
            // Offset towards the inside door side (-X face in local, -X in global)
            translate([-width/2 + 4.0, 0, height/2 + 2.0])
            rotate([90, 0, 0])
            hinge_female_knuckle();
        }
    }
}

// Standalone preview
edge_hinge();
