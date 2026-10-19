// ====================================================================
// Integrated 3D Printable Hinge Module
// Pin-and-barrel knuckle hinge for French doors and top roof doors
// ====================================================================
include <../config.scad>

// Female Hinge Knuckle (mounted to frame pillar)
module hinge_female_knuckle(
    barrel_od = 10.0,
    pin_id = 5.0,
    height = 28.0,
    center_gap = 12.0
) {
    difference() {
        cylinder(d = barrel_od, h = height, center = true);
        
        // Center cutout for male knuckle
        cube([barrel_od + 2, barrel_od + 2, center_gap + 2*TOL_HINGE], center = true);
        
        // Through-hole for hinge pin
        cylinder(d = pin_id + TOL_HINGE, h = height + 4, center = true);
    }
}

// Male Hinge Knuckle (mounted to door frame)
module hinge_male_knuckle(
    barrel_od = 10.0,
    pin_id = 5.0,
    knuckle_h = 11.5
) {
    difference() {
        cylinder(d = barrel_od - 0.2, h = knuckle_h, center = true);
        
        // Through-hole for hinge pin
        cylinder(d = pin_id + TOL_HINGE, h = knuckle_h + 2, center = true);
    }
}

// Dedicated 3D Printable Hinge Pin with Retention Head
module hinge_pin(
    pin_id = 5.0,
    length = 32.0
) {
    union() {
        // Main pin shaft
        cylinder(d = pin_id - TOL_HINGE, h = length, center = true);
        
        // Chamfered tip for easy alignment insertion
        translate([0, 0, length/2])
        cylinder(r1 = (pin_id - TOL_HINGE)/2, r2 = (pin_id - TOL_HINGE)/2 - 0.8, h = 2, center = false);
        
        // Retention cap
        translate([0, 0, -length/2 - 2])
        cylinder(d = pin_id + 4, h = 2.5, center = false);
    }
}
