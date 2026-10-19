// ====================================================================
// Dual-Taper Wedge Dovetail Module (Peg-Free, Self-Locking)
// Main Frame Wedge & Mini Door Wedge Systems
// ====================================================================
include <../config.scad>

// 2D Profile of Dovetail Slice in X-Y plane
module dovetail_slice_2d(root_w, tip_w, depth) {
    w_r = root_w / 2;
    w_t = tip_w / 2;
    polygon(points = [
        [-w_r, 0],
        [-w_t, depth],
        [ w_t, depth],
        [ w_r, 0]
    ]);
}

// ----------------------------------------------------
// ----------------------------------------------------
// 1. Main Frame Dual-Taper Wedge Dovetail (24 x 24 mm Profile)
// Starts at flat side (0%) and spans 60% through the frame square
// Leaves the outer 40% (which carries the 30% slot & spline) completely solid
// ----------------------------------------------------
module male_dovetail(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = 0
) {
    // Starts at flat inside face (-h/2) and goes 60% through
    z_start = -h/2 + tol;
    z_end   = -h/2 + 0.60 * h - tol;
    
    // Shift toward inside face in X (-w/2) away from +X spline slot
    x_off = -4.5;
    
    b_root = 6.0 - 2*tol;
    b_tip  = 9.5 - 2*tol;
    t_root = 7.5 - 2*tol;
    t_tip  = 11.0 - 2*tol;
    
    translate([x_off, 0, 0])
    union() {
        hull() {
            translate([0, 0, z_start])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth);
            
            translate([0, 0, z_end - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth);
        }
        
        // Tactile snap detent bead near the 60% internal shoulder
        translate([0, depth, z_end - 2.5])
        rotate([0, 90, 0])
        cylinder(r = 0.6, h = t_tip - 2, center = true, $fn=16);
    }
}

module female_dovetail_pocket(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = TOL_DOVETAIL
) {
    // Starts at flat inside face (-h/2, open) and goes 60% through
    z_start = -h/2 - 1.0;
    z_end   = -h/2 + 0.60 * h + tol;
    
    // Shift toward inside face in X (-w/2) away from +X spline slot, matching male_dovetail
    x_off = -4.5;
    
    b_root = 6.0 + 2*tol;
    b_tip  = 9.5 + 2*tol;
    t_root = 7.5 + 2*tol;
    t_tip  = 11.0 + 2*tol;
    
    translate([x_off, 0, 0])
    union() {
        hull() {
            translate([0, 0, z_start])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth + 0.6);
            
            translate([0, 0, z_end - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth + 0.6);
        }
        
        // Matching snap detent groove in pocket floor near 60% ceiling
        translate([0, depth, z_end - 2.5])
        rotate([0, 90, 0])
        cylinder(r = 0.8, h = t_tip + 2, center = true, $fn=16);
    }
}

// ----------------------------------------------------
// 2. Mini Door Dual-Taper Wedge Dovetail (18 x 16 mm Profile)
// Starts at flat side (0%) and spans 60% through
// ----------------------------------------------------
module mini_male_dovetail(
    w = DOOR_PROFILE_W,
    h = DOOR_PROFILE_T,
    depth = DOOR_DEPTH,
    tol = 0
) {
    z_start = -h/2 + tol;
    z_end   = -h/2 + 0.60 * h - tol;
    
    b_root = 5.0 - 2*tol;
    b_tip  = 8.0 - 2*tol;
    t_root = 6.5 - 2*tol;
    t_tip  = 10.0 - 2*tol;
    
    union() {
        hull() {
            translate([0, 0, z_start])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth);
            
            translate([0, 0, z_end - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth);
        }
        
        // Snap detent bead near 60% shoulder
        translate([0, depth, z_end - 2.0])
        rotate([0, 90, 0])
        cylinder(r = 0.5, h = t_tip - 1.5, center = true, $fn=16);
    }
}

module mini_female_dovetail_pocket(
    w = DOOR_PROFILE_W,
    h = DOOR_PROFILE_T,
    depth = DOOR_DEPTH,
    tol = TOL_DOVETAIL
) {
    z_start = -h/2 - 1.0;
    z_end   = -h/2 + 0.60 * h + tol;
    
    b_root = 5.0 + 2*tol;
    b_tip  = 8.0 + 2*tol;
    t_root = 6.5 + 2*tol;
    t_tip  = 10.0 + 2*tol;
    
    union() {
        mirror([0, 1, 0])
        hull() {
            translate([0, 0, z_start])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth + 0.5);
            
            translate([0, 0, z_end - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth + 0.5);
        }
        
        // Matching detent groove
        translate([0, -depth, z_end - 2.0])
        rotate([0, 90, 0])
        cylinder(r = 0.7, h = t_tip + 2, center = true, $fn=16);
    }
}
