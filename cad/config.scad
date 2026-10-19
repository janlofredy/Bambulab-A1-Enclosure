// ====================================================================
// Bambu Lab A1 Enclosure - Global Configuration Parameters
// Ultra-Minimal 8-Part Modular Kit (Face-Overlay Architecture)
// ====================================================================

// --- Print Bed Limits ---
MAX_PRINT_X = 256;
MAX_PRINT_Y = 256;
MAX_PRINT_Z = 256;
SAFE_PART_MAX_LEN = 240; // Conservative safety margin for brims

// --- Internal Enclosure Dimensions (mm) ---
// Sized for Bambu Lab A1 bed-slinger travel, right poop bucket, and top BMCU 370c
INTERNAL_WIDTH  = 560; // X axis clearance (A1 + toolhead + right poop bucket)
INTERNAL_DEPTH  = 580; // Y axis clearance (Bed travel + rear cable loop buffer)
INTERNAL_HEIGHT = 710; // Z axis clearance (Gantry + BMCU 370c rotating mount + spool)

// --- Standardized Modular Grid Lengths ---
FRAME_EDGE_LEN  = 185.0; // Standardized length for ALL frame edge segments
DOOR_EDGE_LEN   = 138.0; // Standardized length for ALL door/roof edge segments

// --- Frame Profile Dimensions ---
BEAM_WIDTH   = 24.0;  // Frame beam width X/Y (mm)
BEAM_HEIGHT  = 24.0;  // Frame beam height Z (mm)
CORNER_SIZE  = 36.0;  // 3-way cubic corner junction dimension

// --- Door Profile Dimensions (Slim Face-Overlay) ---
DOOR_PROFILE_W = 18.0; // Width across door frame face (mm)
DOOR_PROFILE_T = 16.0; // Thickness of door frame (mm)
DOOR_CORNER_W  = 25.0; // L-shaped door corner block dimension (mm)

// --- Tolerances (FDM 3D Printing tuned for Bambu Lab A1 0.4mm nozzle) ---
TOL_TIGHT    = 0.15; // Tight press fit (spline clips)
TOL_DOVETAIL = 0.20; // Sliding interlock fit (wedge dovetails)
TOL_HINGE    = 0.30; // Free rotating hinge pins
TOL_LOOSE    = 0.40; // Clearance gaps

// --- Cellophane Spline Groove Specifications ---
GROOVE_WIDTH      = 4.5;  // Width of U-channel
GROOVE_DEPTH      = 4.5;  // Depth of U-channel
SPLINE_END_MARGIN = 13.0; // Margin from beam ends so dovetails (10mm) never reach spline slots
FRAME_SPLINE_LEN  = FRAME_EDGE_LEN - 2 * SPLINE_END_MARGIN; // 159 mm central slot
DOOR_SPLINE_LEN   = DOOR_EDGE_LEN - 2 * 10.0; // 118 mm central slot

// --- Peg-Free Dual-Taper Wedge Dovetail Dimensions ---
// Sized so dovetails do not reach or intersect the spline slots
DOVETAIL_DEPTH = 10.0; // Length of wedge insert (mm) - stays clear of spline slots

// Main Frame Wedge Dovetail
FRAME_BOT_ROOT = 6.5;  // Bottom root width (narrow entry)
FRAME_BOT_TIP  = 10.5; // Bottom tip width
FRAME_TOP_ROOT = 8.0;  // Top root width (wide wedge lock)
FRAME_TOP_TIP  = 12.5; // Top tip width (half-width 6.25mm < 7.5mm spline boundary)

// Mini Door Wedge Dovetail (scaled for 18x16 mm door profile)
DOOR_BOT_ROOT  = 5.0;
DOOR_BOT_TIP   = 8.5;
DOOR_TOP_ROOT  = 6.5;
DOOR_TOP_TIP   = 10.5;
DOOR_DEPTH     = 8.0;

// --- Filament PTFE Tube Routing (Bottom Side Beam) ---
PTFE_TUBE_OD  = 4.0; // Standard PTFE bowden tube outer diameter (mm)
PTFE_HOLE_DIA = 4.3; // Slip-fit through-hole diameter with retention grip
PTFE_TUBE_CNT = 4;   // 4 dedicated filament tubes for multi-material / drybox
PTFE_ANGLE    = 35;  // Upward angle toward toolhead/BMCU (degrees)

// --- Render Quality ($fn) ---
$fn = $preview ? 24 : 64;
