# Bill of Materials (BOM) & Print Matrix
## Ultra-Minimal 8-Part Modular Kit for Bambu Lab A1 Enclosure

The entire enclosure is built using only **8 unique 3D printable parts** (+ 1 spring spline clip).
Every piece is $\le 185\text{ mm}$ and prints without supports on the **Bambu Lab A1 (256 × 256 mm)**. Zero metal screws, zero separate pegs/pins, and zero complex sub-assemblies.

---

## 1. 3D Print Manifest (The 8 Parts)

### Recommended Slicer Settings (Bambu Studio / OrcaSlicer)
- **Filament**: PETG (Recommended for thermal resistance & spring compliance) or PLA+
- **Nozzle**: 0.4 mm
- **Layer Height**: 0.20 mm Standard
- **Wall Loops**: 3 to 4 (Provides high stiffness for frame and door struts)
- **Infill**: 15% to 20% (Gyroid)
- **Support**: None required (All overhangs and pockets designed within 45° FDM rules)

### Complete Parts Table

| # | Part Name | STL File | Source File | Qty | Purpose & Notes |
| :-: | :--- | :--- | :--- | :---: | :--- |
| **1** | **Corner Part** | `1_corner_part.stl` | `cad/parts/corner_part.scad` | **8** | Universal directional 3-way corner (4 bottom, 4 top) |
| **2** | **Edge Standard** | `2_edge_standard.stl` | `cad/parts/edge_standard.scad` | **25** | Standard 185 mm structural beam (X, Y, Z spans) |
| **3** | **Edge with Hinge** | `3_edge_hinge.stl` | `cad/parts/edge_hinge.scad` | **6** | Front pillar uprights with offset female door hinges |
| **4** | **Edge with PTFE** | `4_edge_ptfe.stl` | `cad/parts/edge_ptfe.scad` | **1** | Lower side beam with 4 angled Bowden guide channels |
| **5** | **Door Corner** | `5_door_corner.stl` | `cad/parts/door_corner.scad` | **8** | 90° L-corners for the two French door leaves |
| **6** | **Door Edge** | `6_door_edge.stl` | `cad/parts/door_edge.scad` | **10** | Standard 138 mm slim door strut (top/bottom rails & stiles)|
| **7** | **Door Edge Handle**| `7_door_edge_handle.stl`| `cad/parts/door_edge_handle.scad`| **2** | Meeting stiles with pull handle & draft-stop overlap lip |
| **8** | **Door Edge Hinge** | `8_door_edge_hinge.stl` | `cad/parts/door_edge_hinge.scad` | **6** | Outer door stiles with male hinge knuckles |
| **9** | **Spline Clip Batch**| `9_spline_clip_batch.stl`| `cad/parts/spline_clip.scad` | **~25** | Compliant split-core spring clamps for cellophane |

*Note: For proppable top roof doors, simply print an additional set of door parts (#5, #6, #8).*

---

## 2. Cellophane Packaging Plastic Cutting Matrix

Cut the original clear plastic packaging bag that came wrapped around your Bambu Lab A1 using standard scissors or a craft knife. Add **15–20 mm extra margin on each side** so the film seats fully down into the U-grooves when the spring clip is pressed into place.

| Panel Position | Width (mm) | Height / Depth (mm) | Finished Panel Cut Size (with margins) |
| :--- | :---: | :---: | :--- |
| **Left Static Wall** | 580 mm | 760 mm | Cut sheet: **620 × 800 mm** |
| **Right Static Wall**| 580 mm | 760 mm | Cut sheet: **620 × 800 mm** |
| **Rear Static Wall** | 580 mm | 760 mm | Cut sheet: **620 × 800 mm** |
| **Left French Door** | 280 mm | 750 mm | Cut sheet: **320 × 790 mm** (Mounts directly on door frame) |
| **Right French Door**| 280 mm | 750 mm | Cut sheet: **320 × 790 mm** (Mounts directly on door frame) |

---

## 3. Fasteners & Hardware

- **Screws**: 0 (Zero)
- **Nuts**: 0 (Zero)
- **Glue**: 0 (Zero)
- **Pins / Pegs**: 0 (Zero! 100% self-wedging dual-taper joints)
