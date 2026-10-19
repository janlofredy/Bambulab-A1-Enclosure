// ====================================================================
// Dovetail Interlock & Tapered Locking Pin Module
// Hardware-free rigid joint system for modular 3D printed beams
// ====================================================================
include <../config.scad>

// 2D Profile of Tapered Dovetail (centered at origin, extending in +Y direction)
module dovetail_profile_2d(base_w, tip_w, depth, offset_val=0) {
    w1 = (base_w / 2) + offset_val;
    w2 = (tip_w / 2) + offset_val;
    polygon(points=[
        [-w2, 0],
        [-w1, depth],
        [ w1, depth],
        [ w2, 0]
    ]);
}

// 3D Male Dovetail Tenon (extruded along Z, projects in +X or +Z depending on usage)
module male_dovetail(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = 0
) {
    difference() {
        translate([0, -depth, 0])
        rotate([0, 0, 90])
        linear_extrude(height = h - 2*tol, center = true) {
            dovetail_profile_2d(
                base_w = DOVETAIL_BASE_W - 2*tol,
                tip_w  = DOVETAIL_TIP_W  - 2*tol,
                depth  = depth
            );
        }
        
        // Transverse locking pin hole (tapered)
        translate([0, -depth/2, 0])
        rotate([90, 0, 0])
        cylinder(
            r1 = (PIN_HOLE_DIA / 2) - 0.2,
            r2 = (PIN_HOLE_DIA / 2) + 0.2,
            h  = w + 10,
            center = true
        );
    }
}

// 3D Female Dovetail Pocket (cut into beam end)
module female_dovetail_pocket(
    w = BEAM_WIDTH,
    h = BEAM_HEIGHT,
    depth = DOVETAIL_DEPTH,
    tol = TOL_DOVETAIL
) {
    union() {
        translate([0, -0.01, 0])
        rotate([0, 0, 90])
        linear_extrude(height = h + 2*tol, center = true) {
            dovetail_profile_2d(
                base_w = DOVETAIL_BASE_W + 2*tol,
                tip_w  = DOVETAIL_TIP_W  + 2*tol,
                depth  = depth + 0.5
            );
        }
        
        // Transverse locking pin hole through the surrounding walls
        translate([0, depth/2, 0])
        rotate([90, 0, 0])
        cylinder(
            r1 = (PIN_HOLE_DIA / 2) - 0.2,
            r2 = (PIN_HOLE_DIA / 2) + 0.2,
            h  = w + 10,
            center = true
        );
    }
}

// Tapered Locking Wedge Pin
module locking_taper_pin(
    pin_len = BEAM_WIDTH + 6,
    dia = PIN_HOLE_DIA,
    taper = PIN_TAPER_ANGLE
) {
    r_mid = dia / 2 - TOL_DOVETAIL;
    delta_r = (pin_len / 2) * tan(taper / 2);
    r1 = r_mid - delta_r;
    r2 = r_mid + delta_r;
    
    union() {
        // Tapered locking shaft
        cylinder(r1 = r1, r2 = r2, h = pin_len, center = true);
        
        // Ergonomic pull-tab head for tool-free insertion & removal
        translate([0, 0, pin_len / 2])
        hull() {
            cylinder(r = r2 + 2.5, h = 3.5, center = false);
            translate([0, 0, 5])
            cube([2.5, (r2 + 2.5)*2, 0.1], center = true);
        }
    }
}
