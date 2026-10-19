// ====================================================================
// Bambu Lab A1 Enclosure - Global Configuration Parameters
// 100% 3D Printable, Hardware-Free Modular Enclosure
// ====================================================================

// --- Print Bed Limits ---
MAX_PRINT_X = 256;
MAX_PRINT_Y = 256;
MAX_PRINT_Z = 256;
SAFE_PART_MAX_LEN = 240; // Safety margin for brim and skirt

// --- Internal Enclosure Dimensions (mm) ---
// Sized for Bambu Lab A1 bed-slinger travel, right poop bucket, and top BMCU 370c
INTERNAL_WIDTH  = 560; // X axis clearance (A1 + toolhead + right poop bucket)
INTERNAL_DEPTH  = 580; // Y axis clearance (Bed travel + rear cable loop buffer)
INTERNAL_HEIGHT = 710; // Z axis clearance (Gantry + BMCU 370c rotating mount + spool)

// --- Frame Profile Dimensions ---
BEAM_WIDTH  = 24;  // Beam thickness X/Y (mm)
BEAM_HEIGHT = 24;  // Beam thickness Z (mm)
WALL_THICKNESS = 3.2; // Shell thickness for robust frame rigidity

// Outer Dimensions
OUTER_WIDTH  = INTERNAL_WIDTH  + 2 * BEAM_WIDTH;  // ~608 mm
OUTER_DEPTH  = INTERNAL_DEPTH  + 2 * BEAM_WIDTH;  // ~628 mm
OUTER_HEIGHT = INTERNAL_HEIGHT + 2 * BEAM_HEIGHT; // ~758 mm

// --- Tolerances (FDM 3D Printing tuned for Bambu Lab A1 0.4mm nozzle) ---
TOL_TIGHT    = 0.15; // Tight press fit (spline clips)
TOL_DOVETAIL = 0.20; // Sliding interlock fit (dovetails & taper pins)
TOL_HINGE    = 0.30; // Free rotating hinge pins
TOL_LOOSE    = 0.40; // Clearance gaps

// --- Cellophane Spline Groove Specifications ---
GROOVE_WIDTH  = 4.5; // Width of U-channel on outer beam faces
GROOVE_DEPTH  = 5.0; // Depth of U-channel
SPLINE_WIDTH  = 4.2; // Width of snap-in locking spline strip
SPLINE_HEIGHT = 4.8; // Height of locking spline strip
SPLINE_LIP_R  = 0.6; // Small retention bead radius to pinch cellophane

// --- Tapered Dovetail & Pin Specifications ---
DOVETAIL_DEPTH  = 16.0; // Length of dovetail insert (mm)
DOVETAIL_BASE_W = 14.0; // Width at base of male dovetail
DOVETAIL_TIP_W  = 8.0;  // Width at narrowest point of taper
PIN_HOLE_DIA    = 6.0;  // Transverse locking pin hole diameter (tapered)
PIN_TAPER_ANGLE = 4.0;  // Degrees taper on locking pin for wedge action

// --- Segmentation Calculations (All segments < SAFE_PART_MAX_LEN) ---
CORNER_BLOCK_SIZE = 36; // 3-way cubic corner junction dimension

// Beam span between corners:
SPAN_X = INTERNAL_WIDTH  + 2 * BEAM_WIDTH - 2 * CORNER_BLOCK_SIZE;  // 608 - 72 = 536 mm
SPAN_Y = INTERNAL_DEPTH  + 2 * BEAM_WIDTH - 2 * CORNER_BLOCK_SIZE;  // 628 - 72 = 556 mm
SPAN_Z = INTERNAL_HEIGHT + 2 * BEAM_HEIGHT - 2 * CORNER_BLOCK_SIZE; // 758 - 72 = 686 mm

// Number of segments per span:
NUM_SEGS_X = 3; // 536 / 3 = 178.67 mm per segment
NUM_SEGS_Y = 3; // 556 / 3 = 185.33 mm per segment
NUM_SEGS_Z = 3; // 686 / 3 = 228.67 mm per segment

SEG_LEN_X = SPAN_X / NUM_SEGS_X;
SEG_LEN_Y = SPAN_Y / NUM_SEGS_Y;
SEG_LEN_Z = SPAN_Z / NUM_SEGS_Z;

// --- Filament PTFE Tube Routing (Bottom Side Beam) ---
PTFE_TUBE_OD  = 4.0; // Standard PTFE bowden tube outer diameter (mm)
PTFE_HOLE_DIA = 4.3; // Slip-fit through-hole diameter with retention grip
PTFE_TUBE_CNT = 4;   // 4 dedicated filament tubes for multi-material / drybox
PTFE_ANGLE    = 35;  // Upward angle toward toolhead/BMCU (degrees)

// --- Render Quality ($fn) ---
$fn = $preview ? 24 : 64;
