// ====================================================================
// Tapered Locking Wedge Pin Array
// Zero-hardware locking pins to secure dovetail joints under tension
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>

// Single Pin
module single_pin() {
    locking_taper_pin();
}

// Print Bed Batch Array (e.g., 6 pins or 12 pins laid out on A1 bed)
module pin_batch(rows = 2, cols = 6, spacing = 18) {
    for (r = [0 : rows - 1]) {
        for (c = [0 : cols - 1]) {
            translate([c * spacing - ((cols-1)*spacing)/2, r * spacing - ((rows-1)*spacing)/2, (BEAM_WIDTH + 6)/2])
            single_pin();
        }
    }
}

// Default preview: batch of 12 pins
pin_batch();
