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
// 1. Main Frame Dual-Taper Wedge Dovetail (24 x 24 mm Profile)
// ----------------------------------------------------
module male_dovetail(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = 0
) {
    z_bot = -h/2 + 2.0 + tol; // 2mm bottom ledge
    z_top =  h/2 - tol;       // Flush at top of beam
    
    b_root = FRAME_BOT_ROOT - 2*tol;
    b_tip  = FRAME_BOT_TIP  - 2*tol;
    t_root = FRAME_TOP_ROOT - 2*tol;
    t_tip  = FRAME_TOP_TIP  - 2*tol;
    
    union() {
        hull() {
            translate([0, 0, z_bot])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth);
            
            translate([0, 0, z_top - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth);
        }
        
        // Tactile snap detent bead on the tip face at the bottom
        translate([0, depth, z_bot + 2.0])
        rotate([0, 90, 0])
        cylinder(r = 0.6, h = b_tip - 2, center = true);
    }
}

module female_dovetail_pocket(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = TOL_DOVETAIL
) {
    z_bot = -h/2 + 2.0 - tol;
    z_top =  h/2 + 2.0; // Open through top
    
    b_root = FRAME_BOT_ROOT + 2*tol;
    b_tip  = FRAME_BOT_TIP  + 2*tol;
    t_root = FRAME_TOP_ROOT + 2*tol;
    t_tip  = FRAME_TOP_TIP  + 2*tol;
    
    union() {
        mirror([0, 1, 0])
        hull() {
            translate([0, 0, z_bot])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth + 0.6);
            
            translate([0, 0, z_top])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth + 0.6);
        }
        
        // Matching snap detent groove in the pocket floor
        translate([0, -depth, z_bot + 2.0])
        rotate([0, 90, 0])
        cylinder(r = 0.8, h = b_tip + 2, center = true);
    }
}

// ----------------------------------------------------
// 2. Mini Door Dual-Taper Wedge Dovetail (18 x 16 mm Profile)
// ----------------------------------------------------
module mini_male_dovetail(
    w = DOOR_PROFILE_W,
    h = DOOR_PROFILE_T,
    depth = DOOR_DEPTH,
    tol = 0
) {
    z_bot = -h/2 + 1.5 + tol;
    z_top =  h/2 - tol;
    
    b_root = DOOR_BOT_ROOT - 2*tol;
    b_tip  = DOOR_BOT_TIP  - 2*tol;
    t_root = DOOR_TOP_ROOT - 2*tol;
    t_tip  = DOOR_TOP_TIP  - 2*tol;
    
    union() {
        hull() {
            translate([0, 0, z_bot])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth);
            
            translate([0, 0, z_top - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth);
        }
        
        // Snap detent bead
        translate([0, depth, z_bot + 1.5])
        rotate([0, 90, 0])
        cylinder(r = 0.5, h = b_tip - 1.5, center = true);
    }
}

module mini_female_dovetail_pocket(
    w = DOOR_PROFILE_W,
    h = DOOR_PROFILE_T,
    depth = DOOR_DEPTH,
    tol = TOL_DOVETAIL
) {
    z_bot = -h/2 + 1.5 - tol;
    z_top =  h/2 + 2.0; // Open through top
    
    b_root = DOOR_BOT_ROOT + 2*tol;
    b_tip  = DOOR_BOT_TIP  + 2*tol;
    t_root = DOOR_TOP_ROOT + 2*tol;
    t_tip  = DOOR_TOP_TIP  + 2*tol;
    
    union() {
        mirror([0, 1, 0])
        hull() {
            translate([0, 0, z_bot])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth + 0.5);
            
            translate([0, 0, z_top])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth + 0.5);
        }
        
        // Matching detent groove
        translate([0, -depth, z_bot + 1.5])
        rotate([0, 90, 0])
        cylinder(r = 0.7, h = b_tip + 2, center = true);
    }
}
