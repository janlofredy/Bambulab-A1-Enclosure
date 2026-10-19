# Bill of Materials (BOM) & Print Matrix
## 100% 3D Printable Bambu Lab A1 Enclosure

All components are designed to print without supports on a standard **Bambu Lab A1 (256 × 256 mm)** build plate. Zero metal hardware, screws, or nuts required.

---

## 1. 3D Print Manifest

### Recommended Slicer Settings (Bambu Studio / OrcaSlicer)
- **Filament**: PETG (Recommended for thermal resistance & clip flexibility) or PLA+ / Tough PLA
- **Nozzle**: 0.4 mm
- **Layer Height**: 0.20 mm Standard
- **Wall Loops / Perimeters**: 3 to 4 (Provides rigid structural strength for frame beams)
- **Top / Bottom Shells**: 4 layers
- **Infill**: 15% to 20% (Gyroid or Grid)
- **Brim**: Recommended 5 mm inner/outer brim on tall vertical pillar segments if bed adhesion needs support.

### Print Matrix & Plate Allocation

| Part Name | Source File | Qty | Est. Print Time (A1 Standard) | Notes |
| :--- | :--- | :---: | :---: | :--- |
| **Dovetail Test Coupon** | `cad/tests/dovetail_test_coupon.scad` | 1 | 25 min | **Print 1st**: Verifies dovetail slide & pin tightness |
| **Spline Test Coupon** | `cad/tests/spline_test_coupon.scad` | 1 | 15 min | **Print 2nd**: Tests cellophane clamping with shipping bag |
| **Bottom Corner Blocks** | `cad/parts/corner_bottom.scad` | 4 | ~1 hr 40 min | 4 corner nodes (print together on 1 plate) |
| **Top Corner Blocks** | `cad/parts/corner_top.scad` | 4 | ~1 hr 50 min | With door and roof hinge knuckles |
| **X-Span Beams (Front/Back)** | `cad/parts/beam_strut.scad` | 8 | ~3 hr 30 min | 4x `beam_x_mid`, 4x `beam_x_end` (width span) |
| **Y-Span Beams (Sides)** | `cad/parts/beam_strut.scad` | 7 | ~3 hr 15 min | 3x `beam_y_mid`, 4x `beam_y_end` (depth span) |
| **4-Tube PTFE Bottom Beam** | `cad/modules/ptfe_mount.scad` | 1 | ~50 min | Replaces 1 bottom side Y-beam segment |
| **Z-Span Vertical Pillars** | `cad/parts/beam_strut.scad` | 12 | ~5 hr 20 min | 4 corners × 3 vertical segments (height span) |
| **Locking Taper Pins** | `cad/parts/dovetail_pin.scad` | 36 | ~1 hr 10 min | Printed in 3 batch plates of 12 |
| **Front Door Frames** | `cad/parts/front_door.scad` | 2 sets | ~3 hr 45 min | 6 vertical stiles, 4 horizontal rail halves |
| **Door Handle & Latches** | `cad/parts/front_door.scad` | 2 | ~35 min | Dual snap-latches and pull handles |
| **Top Roof Doors** | `cad/parts/top_roof_door.scad` | 2 sets | ~3 hr 20 min | 6 depth stiles, 4 cross rails |
| **Roof Prop Legs (Kickstands)**| `cad/parts/top_roof_door.scad` | 2 | ~40 min | Multi-angle heat dissipation prop legs |
| **Snap-in Spline Clips** | `cad/parts/spline_clip.scad` | ~30 | ~2 hr 30 min | Tension clips for cellophane sheets |

---

## 2. Cellophane / Packaging Plastic Cutting Matrix

Cut the original clear plastic packaging bag that came wrapped around your Bambu Lab A1 using standard scissors or a craft knife. Add **15–20 mm extra margin on each side** so the film seats fully down into the U-grooves when the spline clip is snapped into place.

| Panel Position | Width (mm) | Height / Depth (mm) | Finished Panel Cut Size (with margins) |
| :--- | :---: | :---: | :--- |
| **Left Wall** | 580 mm | 710 mm | Cut sheet: **620 × 750 mm** |
| **Right Wall** | 580 mm | 710 mm | Cut sheet: **620 × 750 mm** |
| **Rear Wall** | 560 mm | 710 mm | Cut sheet: **600 × 750 mm** |
| **Left Front Door** | 275 mm | 704 mm | Cut sheet: **310 × 740 mm** |
| **Right Front Door** | 275 mm | 704 mm | Cut sheet: **310 × 740 mm** |
| **Left Top Roof Door** | 276 mm | 574 mm | Cut sheet: **310 × 610 mm** |
| **Right Top Roof Door**| 276 mm | 574 mm | Cut sheet: **310 × 610 mm** |

---

## 3. Hardware Requirements

- **Screws**: 0 (Zero)
- **Nuts**: 0 (Zero)
- **Glue**: 0 (Zero required; joints are tension-locked via wedge pins)
- **PTFE Tube**: Standard 4 mm OD Bowden tube (from AMS Lite, drybox, or external spool holder)
