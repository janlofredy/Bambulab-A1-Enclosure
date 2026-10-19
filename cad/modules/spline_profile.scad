// ====================================================================
// Cellophane Spline Groove & Compliant Spring Clamping Strip Module
// High-tension retention system with compliant split-core spring prongs
// and directional grip teeth to hold cellophane drum-tight without slipping
// ====================================================================
include <../config.scad>

// Negative volume for cutting the spline groove into any beam surface
// Cuts into the -Z direction from Z=0.
// Axis parameter: "Y" (default) or "X"
module spline_groove_negative(length = 100, axis = "Y") {
    gw = GROOVE_WIDTH; // 4.5 mm
    gd = GROOVE_DEPTH; // 5.0 mm
    
    // Cross-section profile of the groove (in X-Z plane)
    // Features a 45° lead-in chamfer at the mouth and internal retention undercuts
    module groove_cross_section_2d() {
        polygon(points = [
            [-(gw/2 + 0.6),  0.05], // Mouth chamfer outer left
            [-gw/2,         -0.80], // Mouth chamfer inner left
            [-gw/2 - 0.15,  -2.50], // Mid retention undercut left
            [-gw/2,         -gd],   // Bottom left
            [ gw/2,         -gd],   // Bottom right
            [ gw/2 + 0.15,  -2.50], // Mid retention undercut right
            [ gw/2,         -0.80], // Mouth chamfer inner right
            [ (gw/2 + 0.6),  0.05]  // Mouth chamfer outer right
        ]);
    }
    
    if (axis == "Y") {
        rotate([90, 0, 0])
        linear_extrude(height = length, center = true) {
            groove_cross_section_2d();
        }
    } else {
        rotate([0, 90, 0])
        rotate([0, 0, 90])
        linear_extrude(height = length, center = true) {
            groove_cross_section_2d();
        }
    }
}

// 2D Profile of the Compliant Spring-Wedge Spline Clip (X-Z plane)
// Has a central vertical expansion slot that allows the two prongs to flex inward
// during insertion and exert continuous outward spring pressure against the cellophane.
module spline_clip_profile_2d(width_offset = 0) {
    w_cap   = 7.0; // Top thumb-press cap width
    h_cap   = 1.8; // Cap thickness
    h_depth = 4.6; // Insertion depth
    
    // Base dimensions + user/grip offset
    w_shaft = 4.3 + width_offset; // Base shaft (tight fit in 4.5mm groove)
    w_barb1 = 4.7 + width_offset; // Upper retention barb (interferes with groove)
    w_barb2 = 4.8 + width_offset; // Lower primary clamping barb
    w_nose  = 3.2;                // Lead-in nose
    
    difference() {
        union() {
            // 1. Top Thumb-Press Cap (acts as depth stop & pry lip)
            translate([0, h_cap / 2])
            hull() {
                translate([-w_cap/2 + 0.8, -h_cap/2 + 0.4]) circle(r = 0.4, $fn=16);
                translate([ w_cap/2 - 0.8, -h_cap/2 + 0.4]) circle(r = 0.4, $fn=16);
                translate([-w_cap/2 + 1.2,  h_cap/2 - 0.4]) circle(r = 0.4, $fn=16);
                translate([ w_cap/2 - 1.2,  h_cap/2 - 0.4]) circle(r = 0.4, $fn=16);
            }
            
            // 2. Dual-Barb Clamping Prongs
            polygon(points = [
                [-w_shaft/2,        0.0],
                [-w_shaft/2,       -1.2],
                [-w_barb1/2,       -1.9], // Upper barb tooth
                [-w_shaft/2,       -2.1],
                [-w_shaft/2,       -2.8],
                [-w_barb2/2,       -3.5], // Lower primary clamping tooth
                [-w_nose/2,        -h_depth], // Tapered nose
                [ w_nose/2,        -h_depth],
                [ w_barb2/2,       -3.5],
                [ w_shaft/2,       -2.8],
                [ w_shaft/2,       -2.1],
                [ w_barb1/2,       -1.9],
                [ w_shaft/2,       -1.2],
                [ w_shaft/2,        0.0]
            ]);
        }
        
        // 3. Central Vertical Expansion Kerf (0.9 mm compliant flex slot)
        // Splits the shaft into two spring prongs that flex inward upon insertion
        translate([0, -h_depth/2 - 0.6])
        hull() {
            translate([0,  h_depth/2 - 1.2]) circle(r = 0.45, $fn=16);
            translate([0, -h_depth/2 + 0.5]) circle(r = 0.45, $fn=16);
        }
    }
}

// 3D Snap-in Locking Spline Clip (oriented along Y axis by default)
module spline_clip(length = 150, axis = "Y", width_offset = 0) {
    if (axis == "Y") {
        rotate([90, 0, 0])
        linear_extrude(height = length, center = true) {
            spline_clip_profile_2d(width_offset = width_offset);
        }
    } else {
        rotate([0, 90, 0])
        rotate([0, 0, 90])
        linear_extrude(height = length, center = true) {
            spline_clip_profile_2d(width_offset = width_offset);
        }
    }
}
