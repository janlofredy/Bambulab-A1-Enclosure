// ====================================================================
// Bambu Lab A1 Enclosure - Digital Twin Assembly Preview
// Ultra-Minimal 8-Part Kit (Face-Overlay Architecture)
// Composed exclusively from the 8 standardized parts:
//   Frame: corner_part, edge_standard, edge_hinge, edge_ptfe
//   Doors: door_corner, door_edge, door_edge_handle, door_edge_hinge
// ====================================================================
include <config.scad>
use <parts/corner_part.scad>
use <parts/edge_standard.scad>
use <parts/edge_hinge.scad>
use <parts/edge_ptfe.scad>
use <parts/door_corner.scad>
use <parts/door_edge.scad>
use <parts/door_edge_handle.scad>
use <parts/door_edge_hinge.scad>

// Palette
COLOR_FRAME    = [0.25, 0.28, 0.32, 1.0]; // Dark Slate Frame
COLOR_CORNERS  = [0.90, 0.45, 0.10, 1.0]; // Orange Corner Blocks
COLOR_PTFE     = [0.10, 0.75, 0.50, 1.0]; // Emerald PTFE Entry
COLOR_DOORS    = [0.20, 0.65, 0.90, 0.95]; // Cyan Face-Overlay Doors
COLOR_PLASTIC  = [0.85, 0.95, 1.00, 0.22]; // Translucent Cellophane
COLOR_PRINTER  = [0.50, 0.50, 0.50, 0.20]; // Ghosted Printer Volume
COLOR_SPOOL    = [0.90, 0.20, 0.20, 0.75]; // Red BMCU / Spool

OUTER_W = 2*CORNER_SIZE + 3*FRAME_EDGE_LEN; // ~627 mm
OUTER_D = 2*CORNER_SIZE + 3*FRAME_EDGE_LEN; // ~627 mm
OUTER_H = 2*CORNER_SIZE + 4*FRAME_EDGE_LEN; // ~812 mm

module full_enclosure_assembly() {
    
    // ----------------------------------------------------
    // 1. The 8 Corner Blocks (4 Bottom, 4 Top)
    // ----------------------------------------------------
    color(COLOR_CORNERS) {
        // Bottom-Front-Left
        translate([0, 0, 0]) corner_part();
        // Bottom-Front-Right
        translate([OUTER_W, 0, 0]) mirror([1, 0, 0]) corner_part();
        // Bottom-Rear-Left
        translate([0, OUTER_D, 0]) mirror([0, 1, 0]) corner_part();
        // Bottom-Rear-Right
        translate([OUTER_W, OUTER_D, 0]) mirror([1, 1, 0]) corner_part();
        
        // Top-Front-Left
        translate([0, 0, OUTER_H]) mirror([0, 0, 1]) corner_part();
        // Top-Front-Right
        translate([OUTER_W, 0, OUTER_H]) mirror([1, 0, 1]) corner_part();
        // Top-Rear-Left
        translate([0, OUTER_D, OUTER_H]) mirror([0, 1, 1]) corner_part();
        // Top-Rear-Right
        translate([OUTER_W, OUTER_D, OUTER_H]) mirror([1, 1, 1]) corner_part();
    }
    
    // ----------------------------------------------------
    // 2. Standardized Horizontal & Vertical Frame Edges
    // ----------------------------------------------------
    color(COLOR_FRAME) {
        // Bottom Front Beam (3 segments)
        for (i = [0 : 2]) {
            translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_WIDTH/2, BEAM_HEIGHT/2])
            rotate([0, 0, -90])
            edge_standard(has_spline = false);
        }
        
        // Bottom Rear Beam (3 segments)
        for (i = [0 : 2]) {
            translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_D - BEAM_WIDTH/2, BEAM_HEIGHT/2])
            rotate([0, 0, 90])
            edge_standard(has_spline = true);
        }
        
        // Bottom Right Beam (3 segments)
        for (i = [0 : 2]) {
            translate([OUTER_W - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
            edge_standard(has_spline = true);
        }
        
        // Top Beams (Front, Rear, Left, Right - 3 segments each)
        for (i = [0 : 2]) {
            // Top Front
            translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_WIDTH/2, OUTER_H - BEAM_HEIGHT/2])
            rotate([0, 0, -90])
            edge_standard(has_spline = false);
            
            // Top Rear
            translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_D - BEAM_WIDTH/2, OUTER_H - BEAM_HEIGHT/2])
            rotate([0, 0, 90])
            edge_standard(has_spline = true);
            
            // Top Left
            translate([BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H - BEAM_HEIGHT/2])
            edge_standard(has_spline = true);
            
            // Top Right
            translate([OUTER_W - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H - BEAM_HEIGHT/2])
            edge_standard(has_spline = true);
        }
        
        // Rear Vertical Pillars (2 corners x 4 segments each)
        for (i = [0 : 3]) {
            translate([BEAM_WIDTH/2, OUTER_D - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 0])
            edge_standard(has_spline = true);
            
            translate([OUTER_W - BEAM_WIDTH/2, OUTER_D - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 0])
            edge_standard(has_spline = true);
        }
    }
    
    // ----------------------------------------------------
    // 3. Bottom Side Beam with 4-Tube PTFE Route
    // ----------------------------------------------------
    color(COLOR_FRAME) {
        translate([BEAM_WIDTH/2, CORNER_SIZE + 0*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
        edge_standard(has_spline = true);
        
        translate([BEAM_WIDTH/2, CORNER_SIZE + 2*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
        edge_standard(has_spline = true);
    }
    color(COLOR_PTFE) {
        // Middle segment on lower left beam is the PTFE port!
        translate([BEAM_WIDTH/2, CORNER_SIZE + 1*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
        edge_ptfe();
    }
    
    // ----------------------------------------------------
    // 4. Front Vertical Corner Pillars with Integrated Hinges
    // ----------------------------------------------------
    color(COLOR_FRAME) {
        // Left Front Pillar (Segments 0, 1, 2 have hinges; segment 3 standard)
        for (i = [0 : 2]) {
            translate([BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 0])
            edge_hinge(is_left_pillar = true);
        }
        translate([BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + 3*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
        rotate([90, 0, 0])
        edge_standard(has_spline = false);
        
        // Right Front Pillar
        for (i = [0 : 2]) {
            translate([OUTER_W - BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 0])
            edge_hinge(is_left_pillar = false);
        }
        translate([OUTER_W - BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + 3*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
        rotate([90, 0, 0])
        edge_standard(has_spline = false);
    }
    
    // ----------------------------------------------------
    // 5. Dual Face-Overlay French Doors (Left & Right)
    // Resting directly against the front face of the 24mm frame beams
    // ----------------------------------------------------
    color(COLOR_DOORS) {
        door_w = OUTER_W / 2;
        door_h = OUTER_H;
        
        // Left Door Leaf (Shown slightly open at 18 deg)
        translate([BEAM_WIDTH/2 - 2, 0, 0])
        rotate([0, 0, -18])
        translate([door_w/2, -DOOR_PROFILE_T/2, door_h/2])
        difference() {
            cube([door_w, DOOR_PROFILE_T, door_h - 12], center = true);
            cube([door_w - 2*DOOR_PROFILE_W, DOOR_PROFILE_T + 4, door_h - 12 - 2*DOOR_PROFILE_W], center = true);
        }
        
        // Right Door Leaf (Closed position, resting flush against frame face)
        translate([OUTER_W - BEAM_WIDTH/2 + 2, 0, 0])
        translate([-door_w/2, -DOOR_PROFILE_T/2, door_h/2])
        difference() {
            cube([door_w, DOOR_PROFILE_T, door_h - 12], center = true);
            cube([door_w - 2*DOOR_PROFILE_W, DOOR_PROFILE_T + 4, door_h - 12 - 2*DOOR_PROFILE_W], center = true);
        }
    }
    
    // ----------------------------------------------------
    // 6. Cellophane Panels (Mounted on doors and static walls)
    // ----------------------------------------------------
    color(COLOR_PLASTIC) {
        // Left Static Wall
        translate([BEAM_WIDTH/2, OUTER_D/2, OUTER_H/2])
        cube([0.5, OUTER_D - 2*CORNER_SIZE, OUTER_H - 2*CORNER_SIZE], center = true);
        // Right Static Wall
        translate([OUTER_W - BEAM_WIDTH/2, OUTER_D/2, OUTER_H/2])
        cube([0.5, OUTER_D - 2*CORNER_SIZE, OUTER_H - 2*CORNER_SIZE], center = true);
        // Rear Static Wall
        translate([OUTER_W/2, OUTER_D - BEAM_WIDTH/2, OUTER_H/2])
        cube([OUTER_W - 2*CORNER_SIZE, 0.5, OUTER_H - 2*CORNER_SIZE], center = true);
        
        // Right Door Cellophane Pane (moves with door)
        translate([OUTER_W/4 * 3, -DOOR_PROFILE_T/2, OUTER_H/2])
        cube([OUTER_W/2 - 2*DOOR_PROFILE_W, 0.5, OUTER_H - 12 - 2*DOOR_PROFILE_W], center = true);
    }
    
    // ----------------------------------------------------
    // 7. Bambu Lab A1 Printer Envelope & Poop Bucket
    // ----------------------------------------------------
    color(COLOR_PRINTER) {
        // Base
        translate([OUTER_W/2 - 20, OUTER_D/2, 35])
        cube([385, 340, 50], center = true);
        // Gantry
        translate([OUTER_W/2 - 20, OUTER_D/2, 260])
        cube([410, 50, 465], center = true);
        // Moving Bed
        translate([OUTER_W/2 - 20, OUTER_D/2, 70])
        cube([256, 256, 14], center = true);
        // Right Poop Bucket
        translate([OUTER_W - BEAM_WIDTH - 60, OUTER_D/2 - 40, 60])
        cube([80, 140, 100], center = true);
    }
    
    // Top BMCU & Spool
    color(COLOR_SPOOL) {
        translate([OUTER_W/2 - 20, OUTER_D/2, 590])
        rotate([0, 90, 0])
        cylinder(d = 200, h = 65, center = true);
    }
}

// Standalone render
full_enclosure_assembly();
