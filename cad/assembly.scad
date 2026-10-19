// ====================================================================
// Bambu Lab A1 Enclosure - Full Digital 3D Assembly Preview
// Shows full frame, cellophane walls, front French doors, proppable roof,
// bottom 4-tube PTFE routing, and printer kinematics envelope
// ====================================================================
include <config.scad>
use <modules/dovetail.scad>
use <modules/spline_profile.scad>
use <modules/hinge.scad>
use <modules/ptfe_mount.scad>
use <parts/corner_bottom.scad>
use <parts/corner_top.scad>
use <parts/beam_strut.scad>
use <parts/front_door.scad>
use <parts/top_roof_door.scad>

// Color Palette for Visual Inspection
COLOR_FRAME    = [0.25, 0.28, 0.32, 1.0]; // Dark Industrial Gray
COLOR_CORNERS  = [0.85, 0.45, 0.10, 1.0]; // Bambu Orange accents
COLOR_DOORS    = [0.30, 0.65, 0.90, 0.9]; // Cyan Door Frames
COLOR_PLASTIC  = [0.85, 0.95, 1.00, 0.25]; // Translucent Cellophane Film
COLOR_PRINTER  = [0.50, 0.50, 0.50, 0.20]; // Ghosted Printer Volume
COLOR_SPOOL    = [0.90, 0.20, 0.20, 0.70]; // Red Filament Spool / BMCU

module full_enclosure_assembly() {
    
    // ----------------------------------------------------
    // 1. Bottom Corner Junctions (4x)
    // ----------------------------------------------------
    color(COLOR_CORNERS) {
        // Front-Left
        translate([0, 0, 0])
        bottom_corner(is_front = true, is_left = true);
        
        // Front-Right
        translate([OUTER_WIDTH, 0, 0])
        mirror([1, 0, 0])
        bottom_corner(is_front = true, is_left = false);
        
        // Rear-Left
        translate([0, OUTER_DEPTH, 0])
        mirror([0, 1, 0])
        bottom_corner(is_front = false, is_left = true);
        
        // Rear-Right
        translate([OUTER_WIDTH, OUTER_DEPTH, 0])
        mirror([1, 1, 0])
        bottom_corner(is_front = false, is_left = false);
    }
    
    // ----------------------------------------------------
    // 2. Top Corner Junctions (4x)
    // ----------------------------------------------------
    color(COLOR_CORNERS) {
        // Front-Left
        translate([0, 0, OUTER_HEIGHT - CORNER_BLOCK_SIZE])
        top_corner(is_front = true, is_left = true);
        
        // Front-Right
        translate([OUTER_WIDTH, 0, OUTER_HEIGHT - CORNER_BLOCK_SIZE])
        mirror([1, 0, 0])
        top_corner(is_front = true, is_left = false);
        
        // Rear-Left
        translate([0, OUTER_DEPTH, OUTER_HEIGHT - CORNER_BLOCK_SIZE])
        mirror([0, 1, 0])
        top_corner(is_front = false, is_left = true);
        
        // Rear-Right
        translate([OUTER_WIDTH, OUTER_DEPTH, OUTER_HEIGHT - CORNER_BLOCK_SIZE])
        mirror([1, 1, 0])
        top_corner(is_front = false, is_left = false);
    }
    
    // ----------------------------------------------------
    // 3. Horizontal Bottom & Top Beams
    // ----------------------------------------------------
    color(COLOR_FRAME) {
        // Front Bottom Beam (Door sill)
        translate([OUTER_WIDTH/2, BEAM_WIDTH/2, BEAM_HEIGHT/2])
        cube([SPAN_X, BEAM_WIDTH, BEAM_HEIGHT], center = true);
        
        // Rear Bottom Beam
        translate([OUTER_WIDTH/2, OUTER_DEPTH - BEAM_WIDTH/2, BEAM_HEIGHT/2])
        cube([SPAN_X, BEAM_WIDTH, BEAM_HEIGHT], center = true);
        
        // Front Top Beam
        translate([OUTER_WIDTH/2, BEAM_WIDTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        cube([SPAN_X, BEAM_WIDTH, BEAM_HEIGHT], center = true);
        
        // Rear Top Beam
        translate([OUTER_WIDTH/2, OUTER_DEPTH - BEAM_WIDTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        cube([SPAN_X, BEAM_WIDTH, BEAM_HEIGHT], center = true);
        
        // Left Top Beam
        translate([BEAM_WIDTH/2, OUTER_DEPTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        cube([BEAM_WIDTH, SPAN_Y, BEAM_HEIGHT], center = true);
        
        // Right Top Beam
        translate([OUTER_WIDTH - BEAM_WIDTH/2, OUTER_DEPTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        cube([BEAM_WIDTH, SPAN_Y, BEAM_HEIGHT], center = true);
        
        // Right Bottom Beam
        translate([OUTER_WIDTH - BEAM_WIDTH/2, OUTER_DEPTH/2, BEAM_HEIGHT/2])
        cube([BEAM_WIDTH, SPAN_Y, BEAM_HEIGHT], center = true);
    }
    
    // ----------------------------------------------------
    // 4. Dedicated 4-Tube PTFE Bottom Side Entry Port (Left lower beam)
    // ----------------------------------------------------
    color(COLOR_CORNERS) {
        translate([BEAM_WIDTH/2, OUTER_DEPTH/2, BEAM_HEIGHT/2])
        ptfe_entry_beam(length = SPAN_Y);
    }
    
    // ----------------------------------------------------
    // 5. Vertical Corner Pillars (4x)
    // ----------------------------------------------------
    color(COLOR_FRAME) {
        // Front-Left
        translate([BEAM_WIDTH/2, BEAM_WIDTH/2, OUTER_HEIGHT/2])
        cube([BEAM_WIDTH, BEAM_WIDTH, SPAN_Z], center = true);
        
        // Front-Right
        translate([OUTER_WIDTH - BEAM_WIDTH/2, BEAM_WIDTH/2, OUTER_HEIGHT/2])
        cube([BEAM_WIDTH, BEAM_WIDTH, SPAN_Z], center = true);
        
        // Rear-Left
        translate([BEAM_WIDTH/2, OUTER_DEPTH - BEAM_WIDTH/2, OUTER_HEIGHT/2])
        cube([BEAM_WIDTH, BEAM_WIDTH, SPAN_Z], center = true);
        
        // Rear-Right
        translate([OUTER_WIDTH - BEAM_WIDTH/2, OUTER_DEPTH - BEAM_WIDTH/2, OUTER_HEIGHT/2])
        cube([BEAM_WIDTH, BEAM_WIDTH, SPAN_Z], center = true);
    }
    
    // ----------------------------------------------------
    // 6. Dual French Front Doors (Left & Right)
    // ----------------------------------------------------
    color(COLOR_DOORS) {
        // Left Door Leaf (Shown slightly ajar at 15 deg)
        translate([BEAM_WIDTH, BEAM_WIDTH/2, OUTER_HEIGHT/2])
        rotate([0, 0, -15])
        translate([DOOR_WIDTH/2, 0, 0])
        difference() {
            cube([DOOR_WIDTH, 12, DOOR_HEIGHT], center = true);
            cube([DOOR_WIDTH - 36, 16, DOOR_HEIGHT - 36], center = true);
        }
        
        // Right Door Leaf (Shown closed)
        translate([OUTER_WIDTH - BEAM_WIDTH, BEAM_WIDTH/2, OUTER_HEIGHT/2])
        translate([-DOOR_WIDTH/2, 0, 0])
        difference() {
            cube([DOOR_WIDTH, 12, DOOR_HEIGHT], center = true);
            cube([DOOR_WIDTH - 36, 16, DOOR_HEIGHT - 36], center = true);
        }
    }
    
    // ----------------------------------------------------
    // 7. Dual Top Roof Doors + Heat Dissipation Prop Legs
    // ----------------------------------------------------
    color(COLOR_DOORS) {
        // Left Roof Door (Propped open at 35 deg for ventilation)
        translate([BEAM_WIDTH, OUTER_DEPTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        rotate([0, -35, 0])
        translate([ROOF_DOOR_WIDTH/2, 0, 0]) {
            difference() {
                cube([ROOF_DOOR_WIDTH, ROOF_DOOR_DEPTH, 12], center = true);
                cube([ROOF_DOOR_WIDTH - 32, ROOF_DOOR_DEPTH - 32, 16], center = true);
            }
            
            // Integrated Prop Leg holding it up
            translate([ROOF_DOOR_WIDTH/2 - 10, 0, -6])
            rotate([0, 75, 0])
            roof_prop_leg(length = 120);
        }
        
        // Right Roof Door (Closed position)
        translate([OUTER_WIDTH - BEAM_WIDTH, OUTER_DEPTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        translate([-ROOF_DOOR_WIDTH/2, 0, 0])
        difference() {
            cube([ROOF_DOOR_WIDTH, ROOF_DOOR_DEPTH, 12], center = true);
            cube([ROOF_DOOR_WIDTH - 32, ROOF_DOOR_DEPTH - 32, 16], center = true);
        }
    }
    
    // ----------------------------------------------------
    // 8. Cellophane Packaging Film Sheets (Translucent preview)
    // ----------------------------------------------------
    color(COLOR_PLASTIC) {
        // Left Wall Cellophane Sheet
        translate([BEAM_WIDTH/2, OUTER_DEPTH/2, OUTER_HEIGHT/2])
        cube([0.5, INTERNAL_DEPTH, INTERNAL_HEIGHT], center = true);
        
        // Right Wall Cellophane Sheet
        translate([OUTER_WIDTH - BEAM_WIDTH/2, OUTER_DEPTH/2, OUTER_HEIGHT/2])
        cube([0.5, INTERNAL_DEPTH, INTERNAL_HEIGHT], center = true);
        
        // Rear Wall Cellophane Sheet
        translate([OUTER_WIDTH/2, OUTER_DEPTH - BEAM_WIDTH/2, OUTER_HEIGHT/2])
        cube([INTERNAL_WIDTH, 0.5, INTERNAL_HEIGHT], center = true);
        
        // Right Door Pane
        translate([OUTER_WIDTH - BEAM_WIDTH - DOOR_WIDTH/2, BEAM_WIDTH/2, OUTER_HEIGHT/2])
        cube([DOOR_WIDTH - 30, 0.5, DOOR_HEIGHT - 30], center = true);
        
        // Right Roof Door Pane
        translate([OUTER_WIDTH - BEAM_WIDTH - ROOF_DOOR_WIDTH/2, OUTER_DEPTH/2, OUTER_HEIGHT - BEAM_HEIGHT/2])
        cube([ROOF_DOOR_WIDTH - 30, ROOF_DOOR_DEPTH - 30, 0.5], center = true);
    }
    
    // ----------------------------------------------------
    // 9. Bambu Lab A1 Ghost Envelope & Spool / BMCU Clearances
    // ----------------------------------------------------
    color(COLOR_PRINTER) {
        // A1 Base & Gantry
        translate([OUTER_WIDTH/2 - 20, OUTER_DEPTH/2, 230])
        cube([385, 410, 465], center = true);
        
        // Y Bed Travel Envelope (Full forward & backward bed movement)
        translate([OUTER_WIDTH/2 - 20, OUTER_DEPTH/2, 70])
        cube([270, 540, 20], center = true);
        
        // Right Poop Bucket Area
        translate([OUTER_WIDTH - BEAM_WIDTH - 60, OUTER_DEPTH/2 - 40, 60])
        cube([80, 140, 100], center = true);
    }
    
    // Top BMCU 370c + Spool Envelope
    color(COLOR_SPOOL) {
        translate([OUTER_WIDTH/2 - 20, OUTER_DEPTH/2, 590])
        rotate([0, 90, 0])
        cylinder(d = 200, h = 65, center = true);
    }
}

// Render the complete digital twin assembly
full_enclosure_assembly();
