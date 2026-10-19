// ====================================================================
// 1. Universal Directional 3-Way Corner Block (Part 1 of 8)
// 100% 3D Printable on Bambu Lab A1 (Support-Free)
// Features 2 open-top Female wedge sockets and 1 upright Male wedge tenon.
// Rotated at each vertex of the 8 enclosure corners for continuous daisy-chaining.
// ====================================================================
include <../config.scad>
use <../modules/dovetail.scad>
use <../modules/spline_profile.scad>

module corner_part() {
    cs = CORNER_SIZE;
    bw = BEAM_WIDTH;
    bh = BEAM_HEIGHT;
    
    difference() {
        union() {
            // Base corner junction block at [0, 0, 0]
            cube([bw, bw, bw], center = false);
            
            // Branch along +X (24x24 cross-section extending to cs)
            cube([cs, bw, bw], center = false);
            
            // Branch along +Y (24x24 cross-section extending to cs)
            cube([bw, cs, bw], center = false);
            
            // Branch along +Z (24x24 cross-section extending to cs)
            cube([bw, bw, cs], center = false);
            
            // Male wedge tenon on +Z arm (projects upright in +Z direction, inside quadrant)
            translate([bw/2, bh/2, cs])
            rotate([90, 0, 270])
            male_dovetail(w = bw, h = bh);
        }
        
        // Female open-top wedge pocket on +X arm (recesses into -X, open to inside +Z)
        translate([cs, bw/2, bh/2])
        rotate([0, 180, 90])
        female_dovetail_pocket(w = bw, h = bh);
        
        // Female open-top wedge pocket on +Y arm (recesses into -Y, open to inside +X)
        translate([bw/2, cs, bh/2])
        rotate([180, 90, 0])
        female_dovetail_pocket(w = bw, h = bh);
        
        // --- Continuous Spline Grooves on Outside Faces ---
        // 1. Arm +X: spline on Y=0 face (Front outside face)
        translate([cs/2, 0, bh/2])
        rotate([0, 90, 270])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // 2. Arm +X: spline on Z=0 face (Bottom outside face)
        translate([cs/2, bw/2, 0])
        rotate([0, 180, 270])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // 3. Arm +Y: spline on X=0 face (Left outside face)
        translate([0, cs/2, bh/2])
        rotate([0, 270, 0])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // 4. Arm +Y: spline on Z=0 face (Bottom outside face)
        translate([bw/2, cs/2, 0])
        rotate([0, 180, 0])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // 5. Arm +Z: spline on X=0 face (Left outside face)
        translate([0, bw/2, cs/2])
        rotate([90, 0, 270])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // 6. Arm +Z: spline on Y=0 face (Front outside face)
        translate([bw/2, 0, cs/2])
        rotate([90, 0, 0])
        spline_groove_negative(length = cs + 2, axis = "Y");
        
        // Rubber bumper foot recess on bottom face (-Z)
        translate([bw/2, bw/2, 0])
        cylinder(d = 12, h = 3, center = true);
    }
}

// Standalone preview
corner_part();

