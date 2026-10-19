# 100% 3D Printable Bambu Lab A1 Modular Enclosure
### Built to Print on the Bambu Lab A1 (256 × 256 mm) • Zero Hardware • Reuses Factory Packaging Plastic

An ultra-clean, hardware-free modular 3D printable enclosure tailored specifically for the **Bambu Lab A1**. It reuses the transparent plastic cellophane bag from the printer's packaging as drum-tight wall panels, accommodates the **top-mounted rotating BMCU 370c mount and spool**, provides full clearance for the moving bed and right-side poop bucket, features a **dedicated 4-tube PTFE entry port**, and includes **dual proppable roof doors** for heat dissipation during PLA/PETG printing.

---

## Key Design Highlights

1. **Fits 100% on the Bambu Lab A1 Build Plate**:
   - Every single beam segment, corner node, door frame, and clip is $\le 237\text{ mm}$ (comfortably within the $256 \times 256 \times 256\text{ mm}$ build envelope).
2. **Peg-Free Self-Locking Joint System**:
   - Assembles with **dual-taper angled flap dovetails** and **tactile snap-detents**. No screws, no nuts, no glue, and **zero pins or pegs** required! Beams simply drop in from above and wedge rock-solid under friction.
3. **Packaging Cellophane Retention**:
   - Continuous U-channel grooves along every strut and door frame allow you to lay the packaging plastic flat and lock it taut using **snap-in spline clips** with zero tearing.
4. **Kinematic Clearances for Bed-Slinger A1**:
   - **Internal Dimensions**: $560\text{ mm (Width)} \times 580\text{ mm (Depth)} \times 710\text{ mm (Height)}$.
   - **Y-Axis Depth ($580\text{ mm}$)**: Fully clears the forward/backward travel of the bed plus the flexing rear heated bed cable relief loop.
   - **X-Axis Width ($560\text{ mm}$)**: Ample room on the right side for your existing poop bucket, accessible right through the front door.
   - **Z-Axis Height ($710\text{ mm}$)**: Full clearance for the gantry and rotating BMCU 370c top mount + filament spool.
5. **Dual French Front Doors**:
   - Two hinged doors opening outward from the center, saving swing space on your desktop and granting instant bed access.
6. **Dual Proppable Top Roof Doors**:
   - Gull-wing style roof doors matching the front doors, equipped with **integrated multi-angle prop legs (kickstands)** (30°, 60°, and 90° open) to vent chamber heat during PLA/PETG printing or close tightly for draft protection.
7. **Bottom-Side 4-Tube PTFE Route**:
   - Reversible entry module (can be placed on the left or right lower side beam) with 4 angled pass-through channels guiding Bowden tubes smoothly upward toward the toolhead and top BMCU.

---

## Directory Structure

```text
Bambulab A1 Enclosure/
├── cad/
│   ├── config.scad               # Global parameters, printer dims, tolerances
│   ├── assembly.scad             # Full digital 3D preview of assembled enclosure
│   ├── modules/
│   │   ├── dovetail.scad         # Tapered dovetail joints & locking wedge pins
│   │   ├── spline_profile.scad   # U-channel groove and snap-in clip profiles
│   │   ├── hinge.scad            # Integrated pin-and-barrel hinges
│   │   └── ptfe_mount.scad       # 4-tube angled filament entry port
│   ├── parts/
│   │   ├── corner_bottom.scad    # 3-way bottom corner junction blocks
│   │   ├── corner_top.scad       # Top corner blocks with door & roof hinge sockets
│   │   ├── beam_strut.scad       # Segmented horizontal & vertical frame struts
│   │   ├── front_door.scad       # Dual French door frames, handles & snap latches
│   │   ├── top_roof_door.scad    # Proppable roof doors with integrated kickstands
│   │   ├── spline_clip.scad      # Continuous cellophane tension clips
│   │   └── dovetail_pin.scad     # Batch plate of locking wedge pins
│   └── tests/
│       ├── dovetail_test_coupon.scad # Quick 25-min joint tolerance test coupon
│       └── spline_test_coupon.scad   # Quick 15-min cellophane clamping test coupon
├── scripts/
│   ├── validate_dimensions.py    # Kinematics & build plate size validator
│   └── export_stl.py             # Automated batch STL rendering script
├── BOM.md                        # Print matrix, part counts & plastic cutting sizes
└── README.md                     # Complete project documentation & assembly guide
```

---

## Assembly Guide

### Step 1: Test Print Coupons (Verify Fit & Tolerances)
Before printing full beams, print the two small test coupons on your A1:
1. `cad/tests/dovetail_test_coupon.scad` (~15 min):
   - Drop the male tenon into the female open-top pocket.
   - Press down with your thumb. The angled flaps should wedge tightly, and the bottom bead should snap into the floor groove with a positive click.
2. `cad/tests/spline_test_coupon.scad` (~15 min):
   - Place a piece of your printer's packaging cellophane over the groove.
   - Press the spline clip down into the groove with your thumbs. The plastic should snap in and stretch drum-tight.

### Step 2: Assemble the Bottom Base Perimeter
1. Lay out the 4 **Bottom Corner Blocks** (`cad/parts/corner_bottom.scad`) on your desk.
2. Connect the **Front & Rear X-Beams** by dropping the male wedge dovetails into the corner and intermediate sockets.
3. Connect the **Left & Right Y-Beams** into their sockets.
   - *Note*: Insert the **4-Tube PTFE Entry Beam** (`cad/modules/ptfe_mount.scad`) on your preferred side (left or right lower side beam).
4. Press each joint down firmly until the angled flaps wedge flush and the bottom detents snap in tight. Zero pins needed!

### Step 3: Erect Vertical Pillars & Top Ring
1. Slot 3 vertical beam segments together into each of the 4 corner sockets to form the 4 corner pillars.
2. Secure each segment with a locking wedge pin.
3. Seat the 4 **Top Corner Blocks** (`cad/parts/corner_top.scad`) onto the pillar tops.
4. Bridge the top perimeter with the 4 Top Horizontal Beams (Front, Rear, Left, Right) and pin them tight.

### Step 4: Install Packaging Cellophane Walls
1. Cut the original plastic packaging film according to the dimensions in [BOM.md](BOM.md).
2. Starting with the Left and Right side walls:
   - Hold the cellophane sheet against the outer frame face.
   - Align a **Snap-in Spline Clip** (`cad/parts/spline_clip.scad`) along the top groove and press it in.
   - Pull the bottom of the plastic gently downwards and press in the bottom spline clip.
   - Press in the side vertical spline clips. The sheet will automatically pull flat and taut.
3. Repeat for the rear wall. Trim any excess plastic flush with the beam edge.

### Step 5: Assemble & Mount the Front French Doors
1. Assemble each door leaf from the vertical stiles and segmented horizontal rails.
2. Stretch and snap cellophane into the door leaf's internal perimeter grooves using spline clips.
3. Mount the doors onto the front corner pillars by sliding the integrated hinge knuckles together and dropping in the printed hinge pins.
4. Slide the ergonomic **Door Handles / Ball Latches** onto the center meeting stiles.

### Step 6: Assemble Top Roof Doors & Kickstand Legs
1. Assemble the two top roof door leaves with cellophane panes.
2. Snap the **Multi-Angle Prop Legs** (`cad/parts/top_roof_door.scad`) into the center stile pivot sockets.
3. Mount the roof doors to the top side rails using hinge pins.
4. When printing PLA or PETG, prop the doors open at 30° or 60° using the legs to allow warm air to exhaust. When printing high-temperature or draft-sensitive filaments, fold the legs flat and close the roof doors.

### Step 7: Filament Routing
1. Insert 4 mm OD PTFE Bowden tubes through the angled holes in the bottom side beam.
2. Route them inside along the frame upright toward the toolhead and your top BMCU 370c rotating rail mount.

---

## Digital Twin & Preview

To preview the complete digital model:
1. Open `cad/assembly.scad` in OpenSCAD.
2. Press `F5` to render the digital preview showing the frame, doors, cellophane walls, and printer kinematics envelope!
