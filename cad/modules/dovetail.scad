// ====================================================================
// Dual-Taper Wedge Dovetail Module (Peg-Free, Self-Locking)
// Hardware-free, pin-free rigid joint system with angled wedge flaps
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

// 3D Male Wedge Dovetail Tenon (Projects in +Y direction)
// Dual-taper: Flared horizontally to prevent pull-out,
// angled vertically so it slides in easily and wedges rock-solid at the bottom.
module male_dovetail(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = 0
) {
    z_bot = -h/2 + 2.0 + tol; // 2mm bottom ledge
    z_top =  h/2 - tol;       // Flush at top of beam
    
    // Bottom dimensions (narrower for easy drop-in entry)
    b_root = 7.5 - 2*tol;
    b_tip  = 13.5 - 2*tol;
    
    // Top dimensions (wider for firm wedge lock)
    t_root = 9.5 - 2*tol;
    t_tip  = 16.5 - 2*tol;
    
    union() {
        // Continuous 3D dual-taper wedge body
        hull() {
            translate([0, 0, z_bot])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth);
            
            translate([0, 0, z_top - 0.5])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth);
        }
        
        // Small positive snap detent bead on the tip face at the bottom
        // Gives a tactile "click" when fully seated
        translate([0, depth, z_bot + 2.0])
        rotate([0, 90, 0])
        cylinder(r = 0.6, h = b_tip - 2, center = true);
    }
}

// 3D Female Wedge Dovetail Pocket (Recesses in -Y direction)
// Open at the top for effortless drop-in assembly
module female_dovetail_pocket(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = TOL_DOVETAIL
) {
    z_bot = -h/2 + 2.0 - tol;
    z_top =  h/2 + 2.0; // Open through top
    
    // Bottom pocket dimensions (with tolerance)
    b_root = 7.5 + 2*tol;
    b_tip  = 13.5 + 2*tol;
    
    // Top pocket dimensions (with tolerance)
    t_root = 9.5 + 2*tol;
    t_tip  = 16.5 + 2*tol;
    
    union() {
        // Dual-taper wedge pocket recessed into -Y
        mirror([0, 1, 0])
        hull() {
            translate([0, 0, z_bot])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(b_root, b_tip, depth + 0.6);
            
            translate([0, 0, z_top])
            linear_extrude(height = 0.5)
            dovetail_slice_2d(t_root, t_tip, depth + 0.6);
        }
        
        // Matching snap detent groove at the bottom of the pocket
        translate([0, -(depth), z_bot + 2.0])
        rotate([0, 90, 0])
        cylinder(r = 0.8, h = b_tip + 2, center = true);
    }
}
