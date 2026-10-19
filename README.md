# Bambu Lab A1 Enclosure: Ultra-Minimal 8-Part Modular Kit
### 100% 3D Printable on the Bambu Lab A1 (256 × 256 mm) • Zero Hardware • Zero Pegs • Reuses Factory Packaging Plastic

An ultra-streamlined, LEGO-like modular 3D printable enclosure tailored specifically for the **Bambu Lab A1**. Built from only **8 unique core printable parts**, it reuses the transparent plastic cellophane bag from the printer's packaging as drum-tight wall panels, accommodates the **top-mounted rotating BMCU 370c mount and spool**, provides full clearance for the moving bed and right-side poop bucket, features a **dedicated 4-tube PTFE entry port**, and introduces a **face-overlay French door system** that naturally prevents doors from swinging inside without separate stoppers.

---

## The 8 Core Parts

Every single part is $\le 185\text{ mm}$ and prints without supports flat on the A1:

### Main Frame (4 Parts - 24 × 24 mm Profile)
1. **`1_corner_part.stl` (Corner Part)**: Directional 3-way cubic corner (2 Female sockets, 1 Male tenon). Rotated at each vertex to daisy-chain the entire frame without couplers.
2. **`2_edge_standard.stl` (Edge Standard)**: Standardized 185 mm structural beam with Male/Female wedge dovetails and outer spline groove.
3. **`3_edge_hinge.stl` (Edge with Hinge)**: Standard 185 mm beam with integrated front-offset female door hinge knuckle.
4. **`4_edge_ptfe.stl` (Edge with PTFE)**: Standard 185 mm beam with 4 angled (35°) Bowden tube pass-through channels.

### Doors & Roof (4 Parts - Slim 18 × 16 mm Profile)
5. **`5_door_corner.stl` (Door Corner)**: 90° L-corner block with mini female wedge dovetails.
6. **`6_door_edge.stl` (Door Edge)**: Standardized 138 mm door strut with front-facing cellophane spline groove.
7. **`7_door_edge_handle.stl` (Door Edge with Handle)**: 138 mm door strut with integrated ergonomic pull handle and draft-stop overlap lip.
8. **`8_door_edge_hinge.stl` (Door Edge with Hinge)**: 138 mm door strut with matching male hinge knuckle.

### Cellophane Retention
9. **`9_spline_clip_batch.stl` (Spline Clip Batch)**: Compliant split-core spring clamps with dual sawtooth barb teeth.

---

## Assembly Guide

### Step 1: Print Test Coupons First (~15 min each)
Before mass printing, slice and print the two test coupons in `stl_exports/` (or `cad/tests/`):
- `test_dovetail_coupon.stl`: Verifies the drop-in wedge dovetail and tactile snap-fit on your A1.
- `test_spline_coupon.stl`: Test clamping a scrap of your shipping plastic bag into the groove.

### Step 2: Assemble the Bottom Base Perimeter
1. Place 4 **Corner Parts** (#1) on your desk.
2. Connect the **Front & Rear X-Beams** by dropping 3 **Standard Edges** (#2) into the sockets along each span.
3. Connect the **Right Y-Beam** using 3 Standard Edges (#2).
4. Connect the **Left Y-Beam** using 2 Standard Edges (#2) and 1 **Edge with PTFE** (#4) in the center.
5. Press each joint down firmly with your thumb. The angled wedge flaps will self-center and snap rock-solid into place!

### Step 3: Erect Vertical Pillars & Top Ring
1. Slot 4 vertical edge segments into each of the 4 corner sockets:
   - **Rear-Left & Rear-Right Pillars**: 4 × Standard Edges (#2) each.
   - **Front-Left & Front-Right Pillars**: 3 × **Edge with Hinge** (#3) near bottom, middle, and top, plus 1 × Standard Edge (#2).
2. Seat 4 **Corner Parts** (#1) on top of the pillars.
3. Bridge the top perimeter with 3 Standard Edges (#2) along each side (Front, Rear, Left, Right).

### Step 4: Install Packaging Cellophane on Walls
1. Cut your printer's plastic shipping bag to size according to [BOM.md](BOM.md).
2. For the Left, Right, and Rear static walls:
   - Hold the cellophane sheet against the outer frame face.
   - Press the **Spline Clips** (#9) into the continuous U-grooves along the top, bottom, and side beams.
   - The spring prongs compress during entry and continuously push outward, while the dual sawtooth teeth bite into the plastic, holding it drum-tight!
   - Trim any excess plastic flush with the beams.

### Step 5: Assemble & Mount the Face-Overlay French Doors
1. Assemble each door leaf using 4 **Door Corners** (#5), **Door Edges** (#6), the **Door Edge with Handle** (#7) on the inner meeting edge, and **Door Edges with Hinge** (#8) on the outer edge.
2. Lay a sheet of cellophane over the door leaf frame, press the spline clips into the door's front U-groove, and trim the border.
3. Hang the doors onto the front corner pillars by sliding the hinge knuckles together and dropping in a printed pin.
4. When closed, the doors rest directly against the front face of the 24 mm frame beams — the frame itself naturally stops them from swinging inward with zero separate door stop parts!
