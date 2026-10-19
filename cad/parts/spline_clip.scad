// ====================================================================
// 9. Snap-in Spring Spline Clips (Part 9)
// Compliant split-core spring clamp with dual sawtooth barb teeth
// Pre-sized for standardized frame edges (180 mm) and door edges (135 mm)
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>

// Pre-sized clips for standard edges (sized to match isolated spline slots)
// Oriented flat on the print bed for optimal layer strength and zero supports
module spline_clip_frame(length = FRAME_SPLINE_LEN) {
    translate([0, 0, 3.5])
    rotate([0, 90, 0])
    spline_clip(length = length, axis = "Y");
}

module spline_clip_door(length = DOOR_SPLINE_LEN) {
    translate([0, 0, 3.5])
    rotate([0, 90, 0])
    spline_clip(length = length, axis = "Y");
}

// Optional multi-clip batch plate for printing multiple clips in one job
module spline_clip_batch(count = 4, length = FRAME_SPLINE_LEN) {
    for (i = [0 : count - 1]) {
        translate([i * 12 - ((count-1)*12)/2, 0, 3.5])
        rotate([0, 90, 0])
        spline_clip(length = length, axis = "Y");
    }
}

// Default: 1 single standardized frame clip
spline_clip_frame();

