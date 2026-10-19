// ====================================================================
// Cellophane Spline Groove & Snap-in Locking Strip Module
// Retention mechanism to hold packaging plastic taut without screws
// ====================================================================
include <../config.scad>

// Negative volume for cutting the spline groove into any beam surface
// Oriented along X axis, cut into -Z face
module spline_groove_negative(length = 100) {
    translate([0, 0, -GROOVE_DEPTH / 2])
    union() {
        // Main channel
        cube([length, GROOVE_WIDTH, GROOVE_DEPTH], center = true);
        
        // Retention undercuts / wedge lip at depth
        translate([0, 0, -GROOVE_DEPTH / 4])
        cube([length, GROOVE_WIDTH + 0.6, GROOVE_DEPTH / 2], center = true);
    }
}

// 2D Profile of the snap-in locking spline clip
module spline_clip_profile_2d() {
    w = SPLINE_WIDTH;
    h = SPLINE_HEIGHT;
    union() {
        // Chamfered lead-in nose
        polygon(points=[
            [-w/2 + 0.8, 0],
            [ w/2 - 0.8, 0],
            [ w/2, 1.0],
            [ w/2, h - 1.0],
            [ w/2 + 0.5, h], // Outer retention lip
            [-w/2 - 0.5, h], // Outer retention lip
            [-w/2, h - 1.0],
            [-w/2, 1.0]
        ]);
        
        // Gripping top ridge for thumb pressing and removal
        translate([0, h + 1.0])
        circle(r = 1.6);
    }
}

// 3D Snap-in Locking Spline Clip (cut to specified length)
module spline_clip(length = 150) {
    rotate([0, 90, 0])
    linear_extrude(height = length, center = true) {
        spline_clip_profile_2d();
    }
}
