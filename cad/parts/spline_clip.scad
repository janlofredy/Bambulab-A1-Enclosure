// ====================================================================
// 9. Snap-in Spring Spline Clips (Part 9)
// Compliant split-core spring clamp with dual sawtooth barb teeth
// Pre-sized for standardized frame edges (180 mm) and door edges (135 mm)
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>

// Pre-sized clips for standard edges (sized to match isolated spline slots)
module spline_clip_frame() {
    spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
}

module spline_clip_door() {
    spline_clip(length = DOOR_SPLINE_LEN, axis = "Y");
}

// Print bed batch plate (4 clips laid flat on bed at Z=0)
module spline_clip_batch(count = 4, length = FRAME_SPLINE_LEN) {
    for (i = [0 : count - 1]) {
        translate([i * 12 - ((count-1)*12)/2, 0, 3.5])
        rotate([0, 90, 0])
        spline_clip(length = length, axis = "Y");
    }
}

// Default preview: 4 frame clips
spline_clip_batch();
