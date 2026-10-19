// ====================================================================
// Snap-in Cellophane Spline Clips
// Pre-sized locking spline clips for frame struts and door panels
// ====================================================================
include <../config.scad>
use <../modules/spline_profile.scad>

// Preset lengths matching the frame segments
module spline_clip_x() {
    spline_clip(length = SEG_LEN_X - 10);
}

module spline_clip_y() {
    spline_clip(length = SEG_LEN_Y - 10);
}

module spline_clip_z() {
    spline_clip(length = SEG_LEN_Z - 10);
}

module spline_clip_short() {
    spline_clip(length = 100);
}

// Print array of clips side-by-side on the build plate (Z=0)
module spline_clip_array(count = 4, length = 150) {
    for (i = [0 : count - 1]) {
        translate([i * 12 - ((count-1)*12)/2, 0, 3.4])
        rotate([0, 90, 0])
        spline_clip(length = length, axis = "Y");
    }
}

// Preview 4 clips array
spline_clip_array(count = 4, length = 170);
