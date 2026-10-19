// ====================================================================
// Bambu Lab A1 Enclosure - Digital Twin Assembly Preview
// Ultra-Minimal 8-Part Kit (Face-Overlay Architecture)
// Composed exclusively from the 8 standardized parts:
//   Frame: corner_part, edge_standard, edge_hinge, edge_ptfe
//   Doors: door_corner, door_edge, door_edge_handle, door_edge_hinge
//   Spline: spline_clip
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
use <modules/spline_profile.scad>

// Palette
COLOR_FRAME    = [0.28, 0.32, 0.36, 1.0]; // Slate Frame Beams
COLOR_CORNERS  = [0.90, 0.45, 0.10, 1.0]; // Orange Corner Blocks
COLOR_PTFE     = [0.10, 0.75, 0.50, 1.0]; // Emerald PTFE Entry
COLOR_DOORS    = [0.20, 0.65, 0.90, 0.95]; // Cyan Face-Overlay Doors
COLOR_SPLINE   = [0.12, 0.60, 0.95, 1.0]; // Cerulean Compliant Spline Clips
COLOR_PLASTIC  = [0.85, 0.95, 1.00, 0.28]; // Translucent Flexible Cellophane
COLOR_PRINTER  = [0.50, 0.50, 0.50, 0.18]; // Ghosted Printer Volume
COLOR_SPOOL    = [0.90, 0.20, 0.20, 0.75]; // Red BMCU / Spool

OUTER_W = 2*CORNER_SIZE + 3*FRAME_EDGE_LEN; // ~627 mm
OUTER_D = 2*CORNER_SIZE + 3*FRAME_EDGE_LEN; // ~627 mm
OUTER_H = 2*CORNER_SIZE + 4*FRAME_EDGE_LEN; // ~812 mm

// Modular Door Leaf assembled from the 4 modular door parts
module modular_door_leaf(is_left = true) {
    dw = OUTER_W / 2;
    dh = OUTER_H - 12;
    cw = DOOR_CORNER_W; // 25 mm
    pw = DOOR_PROFILE_W; // 18 mm
    pt = DOOR_PROFILE_T; // 16 mm
    
    union() {
        // 4 L-Corners
        // Bottom-Hinge
        translate([is_left ? 0 : dw, 0, 0])
        mirror([is_left ? 0 : 1, 0, 0])
        rotate([90, 0, 0])
        door_corner();
        
        // Top-Hinge
        translate([is_left ? 0 : dw, 0, dh])
        mirror([is_left ? 0 : 1, 0, 0])
        rotate([90, 0, 0])
        mirror([0, 1, 0])
        door_corner();
        
        // Bottom-Center
        translate([is_left ? dw : 0, 0, 0])
        mirror([is_left ? 1 : 0, 0, 0])
        rotate([90, 0, 0])
        door_corner();
        
        // Top-Center
        translate([is_left ? dw : 0, 0, dh])
        mirror([is_left ? 1 : 0, 0, 0])
        rotate([90, 0, 0])
        mirror([0, 1, 0])
        door_corner();
        
        // Horizontal top & bottom spans
        translate([dw/2, 0, pw/2])
        rotate([90, 90, 0])
        door_edge(length = dw - 2*cw);
        
        translate([dw/2, 0, dh - pw/2])
        rotate([90, 90, 0])
        door_edge(length = dw - 2*cw);
        
        // Outer vertical pillar (hinge side)
        hinge_x = is_left ? pw/2 : dw - pw/2;
        for (i = [0 : 2]) {
            translate([hinge_x, 0, cw + i*DOOR_EDGE_LEN + DOOR_EDGE_LEN/2])
            rotate([90, 0, 0])
            door_edge_hinge(is_left_door = is_left);
        }
        for (i = [3 : 4]) {
            translate([hinge_x, 0, cw + i*DOOR_EDGE_LEN + DOOR_EDGE_LEN/2])
            rotate([90, 0, 0])
            door_edge();
        }
        
        // Inner vertical pillar (handle side)
        center_x = is_left ? dw - pw/2 : pw/2;
        // Middle segment has handle
        translate([center_x, 0, cw + 2*DOOR_EDGE_LEN + DOOR_EDGE_LEN/2])
        rotate([90, 0, 0])
        door_edge_handle(is_left_door = is_left);
        
        for (i = [0, 1, 3, 4]) {
            translate([center_x, 0, cw + i*DOOR_EDGE_LEN + DOOR_EDGE_LEN/2])
            rotate([90, 0, 0])
            door_edge();
        }
        
        // Door cellophane pane
        color(COLOR_PLASTIC)
        translate([dw/2, 0, dh/2])
        cube([dw - 2*pw, 0.25, dh - 2*pw], center = true);
    }
}

module full_enclosure_assembly(show_splines = true, show_cellophane = true, show_doors = true) {
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
        // Bottom Front Beam (3 segments, clean face for door overlay)
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
        
        // Bottom Left Beam (Segments 0 & 2 standard)
        translate([BEAM_WIDTH/2, CORNER_SIZE + 0*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
        rotate([0, 0, 180])
        edge_standard(has_spline = true);
        
        translate([BEAM_WIDTH/2, CORNER_SIZE + 2*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
        rotate([0, 0, 180])
        edge_standard(has_spline = true);
        
        // Top Beams
        for (i = [0 : 2]) {
            // Top Front (Spline on top face only)
            translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_WIDTH/2, OUTER_H - BEAM_HEIGHT/2])
            rotate([0, 0, -90])
            edge_standard(has_spline_x = false, has_spline_z = true);
            
            // Top Rear
            translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_D - BEAM_WIDTH/2, OUTER_H - BEAM_HEIGHT/2])
            rotate([0, 0, 90])
            edge_standard(has_spline = true);
            
            // Top Left
            translate([BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H - BEAM_HEIGHT/2])
            rotate([0, 0, 180])
            edge_standard(has_spline = true);
            
            // Top Right
            translate([OUTER_W - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H - BEAM_HEIGHT/2])
            edge_standard(has_spline = true);
        }
        
        // Vertical Rear Pillars
        for (i = [0 : 3]) {
            translate([BEAM_WIDTH/2, OUTER_D - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 180])
            edge_standard(has_spline = true);
            
            translate([OUTER_W - BEAM_WIDTH/2, OUTER_D - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 90])
            edge_standard(has_spline = true);
        }
        
        // Vertical Front Pillars (Hinges on segments 0, 1, 2)
        for (i = [0 : 2]) {
            translate([BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 0])
            edge_hinge(is_left_pillar = true);
            
            translate([OUTER_W - BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
            rotate([90, 0, 0])
            edge_hinge(is_left_pillar = false);
        }
        translate([BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + 3*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
        rotate([90, 0, 0])
        edge_standard(has_spline = false);
        
        translate([OUTER_W - BEAM_WIDTH/2, BEAM_WIDTH/2, CORNER_SIZE + 3*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
        rotate([90, 0, 0])
        edge_standard(has_spline = false);
    }
    
    // Bottom Side Beam PTFE Entry Port (Middle segment)
    color(COLOR_PTFE) {
        translate([BEAM_WIDTH/2, CORNER_SIZE + 1*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
        rotate([0, 0, 180])
        edge_ptfe();
    }
    
    // ----------------------------------------------------
    // 3. Flexible Cellophane Membrane on All Faces (Except Faces with Doors)
    // ----------------------------------------------------
    if (show_cellophane) {
        color(COLOR_PLASTIC) {
            // Left Wall
            translate([0, OUTER_D/2, OUTER_H/2])
            cube([0.25, OUTER_D - 24, OUTER_H - 24], center = true);
            
            // Right Wall
            translate([OUTER_W, OUTER_D/2, OUTER_H/2])
            cube([0.25, OUTER_D - 24, OUTER_H - 24], center = true);
            
            // Rear Wall
            translate([OUTER_W/2, OUTER_D, OUTER_H/2])
            cube([OUTER_W - 24, 0.25, OUTER_H - 24], center = true);
            
            // Top Roof
            translate([OUTER_W/2, OUTER_D/2, OUTER_H])
            cube([OUTER_W - 24, OUTER_D - 24, 0.25], center = true);
        }
    }
    
    // ----------------------------------------------------
    // 4. Snapped-In Compliant Spring Spline Clips (All Faces Except Doors)
    // ----------------------------------------------------
    if (show_splines) {
        color(COLOR_SPLINE) {
            // --- Left Face (14 clips) ---
            for (i = [0 : 2]) {
                translate([0, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
                rotate([0, -90, 0]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([0, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H - BEAM_HEIGHT/2])
                rotate([0, -90, 0]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
            for (i = [0 : 3]) {
                translate([0, BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
                rotate([90, 0, -90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([0, OUTER_D - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
                rotate([90, 0, -90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
            
            // --- Right Face (14 clips) ---
            for (i = [0 : 2]) {
                translate([OUTER_W, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_HEIGHT/2])
                rotate([0, 90, 0]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([OUTER_W, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H - BEAM_HEIGHT/2])
                rotate([0, 90, 0]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
            for (i = [0 : 3]) {
                translate([OUTER_W, BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
                rotate([90, 0, 90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([OUTER_W, OUTER_D - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
                rotate([90, 0, 90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
            
            // --- Rear Face (14 clips) ---
            for (i = [0 : 2]) {
                translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_D, BEAM_HEIGHT/2])
                rotate([0, -90, -90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_D, OUTER_H - BEAM_HEIGHT/2])
                rotate([0, -90, -90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
            for (i = [0 : 3]) {
                translate([BEAM_WIDTH/2, OUTER_D, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
                rotate([90, 0, 180]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([OUTER_W - BEAM_WIDTH/2, OUTER_D, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2])
                rotate([90, 0, 180]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
            
            // --- Top Roof Face (12 clips) ---
            for (i = [0 : 2]) {
                translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, BEAM_WIDTH/2, OUTER_H])
                rotate([0, 0, -90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_D - BEAM_WIDTH/2, OUTER_H])
                rotate([0, 0, -90]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H])
                rotate([0, 0, 0]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
                
                translate([OUTER_W - BEAM_WIDTH/2, CORNER_SIZE + i*FRAME_EDGE_LEN + FRAME_EDGE_LEN/2, OUTER_H])
                rotate([0, 0, 0]) spline_clip(length = FRAME_SPLINE_LEN, axis = "Y");
            }
        }
    }
    
    // ----------------------------------------------------
    // 5. Dual Face-Overlay Modular Doors (Front Face Only)
    // ----------------------------------------------------
    if (show_doors) {
        color(COLOR_DOORS) {
            // Left Door (swung open 25 degrees)
            translate([BEAM_WIDTH/2 - 2, 0, 6])
            rotate([0, 0, -25])
            translate([-(BEAM_WIDTH/2 - 2), -DOOR_PROFILE_T, 0])
            modular_door_leaf(is_left = true);
            
            // Right Door (closed flush against front 24mm frame face)
            translate([0, -DOOR_PROFILE_T, 6])
            modular_door_leaf(is_left = false);
        }
    }
    
    // ----------------------------------------------------
    // 6. Bambu Lab A1 Printer Envelope & Poop Bucket
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
