// ====================================================================
// Cellophane Spline Groove & Snap-in Locking Strip Module
// Retention mechanism to hold packaging plastic taut without screws
// ====================================================================
include <../config.scad>

// Negative volume for cutting the spline groove into any beam surface
// Cuts into the -Z direction from Z=0.
// Axis parameter: "Y" (default, aligned with beam length) or "X"
module spline_groove_negative(length = 100, axis = "Y") {
    gw = GROOVE_WIDTH;   // 4.5 mm
    gd = GROOVE_DEPTH;   // 5.0 mm
    
    // Cross-section profile of the groove (in X-Z plane, cuts down into -Z)
    // with 45-degree lead-in chamfer at the mouth to prevent tearing cellophane
    module groove_cross_section_2d() {
        polygon(points = [
            [-(gw/2 + 0.8),  0.05],  // Mouth chamfer outer left
            [-gw/2,         -0.80],  // Mouth chamfer inner left
            [-gw/2,         -gd],    // Bottom left
            [ gw/2,         -gd],    // Bottom right
            [ gw/2,         -0.80],  // Mouth chamfer inner right
            [ (gw/2 + 0.8),  0.05]   // Mouth chamfer outer right
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

// 2D Profile of the snap-in locking spline clip (X-Z plane)
// Designed for FDM printing with smooth entry, retention ridge, and thumb cap
module spline_clip_profile_2d() {
    w_cap   = 6.8; // Top thumb-press cap width (depth stop & grip)
    h_cap   = 1.8; // Cap thickness
    w_shaft = 3.9; // Shaft body width (sized for 4.5mm groove + cellophane)
    h_depth = 4.6; // Insertion depth into groove
    w_nose  = 2.8; // Tapered lead-in nose width
    w_ridge = 4.3; // Retention snap ridge width
    
    union() {
        // 1. Top Thumb-Press Cap / Flange (sits above groove as depth stop)
        translate([0, h_cap / 2])
        hull() {
            translate([-w_cap/2 + 0.8, -h_cap/2 + 0.4]) circle(r = 0.4, $fn=16);
            translate([ w_cap/2 - 0.8, -h_cap/2 + 0.4]) circle(r = 0.4, $fn=16);
            translate([-w_cap/2 + 1.2,  h_cap/2 - 0.4]) circle(r = 0.4, $fn=16);
            translate([ w_cap/2 - 1.2,  h_cap/2 - 0.4]) circle(r = 0.4, $fn=16);
        }
        
        // 2. Insertion Shaft with Retention Ridge & Chamfered Nose
        translate([0, 0])
        polygon(points = [
            [-w_shaft/2,        0.0],
            [-w_shaft/2,       -2.2],
            [-w_ridge/2,       -3.0], // Snap retention bead
            [-w_shaft/2,       -3.6],
            [-w_nose/2,        -h_depth], // Nose chamfer
            [ w_nose/2,        -h_depth],
            [ w_shaft/2,       -3.6],
            [ w_ridge/2,       -3.0], // Snap retention bead
            [ w_shaft/2,       -2.2],
            [ w_shaft/2,        0.0]
        ]);
    }
}

// 3D Snap-in Locking Spline Clip (oriented along Y axis by default)
// When placed at Z = 0 with oriented_for_print = true, lays flat on the bed
module spline_clip(length = 150, axis = "Y", oriented_for_print = false) {
    if (oriented_for_print) {
        // Lay flat on side for maximum layer strength and zero supports
        // Cap width (6.8mm) or shaft lays on build plate
        rotate([0, 90, 0])
        rotate([0, 0, 90])
        linear_extrude(height = length, center = true) {
            spline_clip_profile_2d();
        }
    } else {
        if (axis == "Y") {
            rotate([90, 0, 0])
            linear_extrude(height = length, center = true) {
                spline_clip_profile_2d();
            }
        } else {
            rotate([0, 90, 0])
            rotate([0, 0, 90])
            linear_extrude(height = length, center = true) {
                spline_clip_profile_2d();
            }
        }
    }
}
