// ====================================================================
// 4. Frame Edge with PTFE Pass-Through (Part 4 of 8)
// Standardized 185 mm structural beam with 4 angled filament guide channels
// Placed on lower side beam to route Bowden tubes toward toolhead and top BMCU
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>
use <edge_standard.scad>

module edge_ptfe(
    length = FRAME_EDGE_LEN,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    tube_count = PTFE_TUBE_CNT,
    tube_angle = PTFE_ANGLE
) {
    difference() {
        // Base edge body
        edge_standard(length = length, width = width, height = height, has_spline = true);
        
        // 4 Angled PTFE Tube Pass-through Channels
        spacing = 16.0;
        start_y = -((tube_count - 1) * spacing) / 2;
        
        for (i = [0 : tube_count - 1]) {
            y_pos = start_y + i * spacing;
            
            translate([0, y_pos, 0])
            rotate([0, -tube_angle, 0]) {
                // 4.3mm through-hole for 4mm OD PTFE tube
                cylinder(d = PTFE_HOLE_DIA, h = height * 3, center = true);
                
                // Funneled smooth entry chamfer (outside)
                translate([0, 0, -height])
                cylinder(r1 = 4.0, r2 = PTFE_HOLE_DIA/2, h = 4.0, center = true);
                
                // Funneled smooth exit chamfer (inside)
                translate([0, 0, height])
                cylinder(r1 = PTFE_HOLE_DIA/2, r2 = 3.5, h = 4.0, center = true);
            }
        }
    }
}

// Standalone preview
edge_ptfe();
