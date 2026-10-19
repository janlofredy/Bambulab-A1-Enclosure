// ====================================================================
// Dedicated 4-Tube PTFE Filament Entry Port Module
// Bottom-side reversible filament feed routing for multi-material / drybox
// ====================================================================
include <../config.scad>
use <dovetail.scad>
use <spline_profile.scad>

module ptfe_entry_beam(
    length = SEG_LEN_Y,
    width  = BEAM_WIDTH,
    height = BEAM_HEIGHT,
    tube_count = PTFE_TUBE_CNT,
    tube_angle = PTFE_ANGLE
) {
    difference() {
        // Base Beam Body
        cube([width, length, height], center = true);
        
        // Spline groove on bottom & outer side
        translate([0, 0, -height/2])
        spline_groove_negative(length = length + 2);
        
        translate([width/2, 0, 0])
        rotate([0, 90, 0])
        spline_groove_negative(length = length + 2);
        
        // Female dovetail pocket at -Y end
        translate([0, -length/2, 0])
        rotate([0, 0, 90])
        female_dovetail_pocket(w = width, h = height);
        
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
    
    // Male Dovetail Tenon at +Y end
    translate([0, length/2, 0])
    rotate([0, 0, -90])
    male_dovetail(w = width, h = height);
}

// Preview standalone when opened directly
ptfe_entry_beam();
