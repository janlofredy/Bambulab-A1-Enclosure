#!/usr/bin/env python3
"""
Batch STL & 3MF Export Script for Bambu Lab A1 Enclosure
Compiles all OpenSCAD modular parts into printable STLs organized by build plate.
"""

import os
import sys
import subprocess
import shutil

PARTS_MANIFEST = [
    # (Output STL name, Source SCAD file, Optional OpenSCAD module/override)
    ("corner_bottom.stl", "cad/parts/corner_bottom.scad", None),
    ("corner_top.stl", "cad/parts/corner_top.scad", None),
    ("beam_x_mid.stl", "cad/parts/beam_strut.scad", "beam_x_mid()"),
    ("beam_x_end.stl", "cad/parts/beam_strut.scad", "beam_x_end()"),
    ("beam_y_mid.stl", "cad/parts/beam_strut.scad", "beam_y_mid()"),
    ("beam_y_end.stl", "cad/parts/beam_strut.scad", "beam_y_end()"),
    ("beam_z_mid.stl", "cad/parts/beam_strut.scad", "beam_z_mid()"),
    ("beam_z_end.stl", "cad/parts/beam_strut.scad", "beam_z_end()"),
    ("ptfe_entry_beam.stl", "cad/modules/ptfe_mount.scad", None),
    ("door_stile_segment.stl", "cad/parts/front_door.scad", "door_stile_segment(is_hinge_segment=true)"),
    ("door_rail.stl", "cad/parts/front_door.scad", "door_rail()"),
    ("door_handle_latch.stl", "cad/parts/front_door.scad", "door_handle_latch()"),
    ("roof_stile_segment.stl", "cad/parts/top_roof_door.scad", "roof_stile_segment(is_hinge=true)"),
    ("roof_prop_leg.stl", "cad/parts/top_roof_door.scad", "roof_prop_leg()"),
    ("spline_clip_array.stl", "cad/parts/spline_clip.scad", "spline_clip_array(count=4, length=170)"),
    ("dovetail_pin_batch.stl", "cad/parts/dovetail_pin.scad", "pin_batch(rows=2, cols=6)"),
    ("dovetail_test_coupon.stl", "cad/tests/dovetail_test_coupon.scad", None),
    ("spline_test_coupon.stl", "cad/tests/spline_test_coupon.scad", None),
]

def check_openscad():
    # Check standard PATH
    path = shutil.which("openscad")
    if path:
        return path
    
    # Check common macOS app locations
    mac_paths = [
        "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD",
        os.path.expanduser("~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD")
    ]
    for p in mac_paths:
        if os.path.exists(p):
            return p
    return None

def main():
    print("==================================================")
    print(" Bambu Lab A1 Enclosure - STL Batch Exporter")
    print("==================================================")
    
    openscad_bin = check_openscad()
    output_dir = "stl_exports"
    os.makedirs(output_dir, exist_ok=True)
    
    if not openscad_bin:
        print("\n[!] Notice: OpenSCAD executable was not detected on this system.")
        print("    You can render these models directly by:")
        print("    1. Installing OpenSCAD (https://openscad.org/downloads.html) or Bambu Studio.")
        print("    2. Opening any `.scad` file in `cad/parts/` or `cad/tests/`.")
        print("    3. Or running: /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o output.stl cad/parts/corner_bottom.scad\n")
        print("Parts manifest configured for export:")
        for stl_name, src, mod in PARTS_MANIFEST:
            print(f"  • {stl_name:<26} <-- {src} {f'({mod})' if mod else ''}")
        return 0

    print(f"Found OpenSCAD: {openscad_bin}")
    print(f"Rendering STLs into '{output_dir}/'...\n")
    
    for stl_name, src, mod in PARTS_MANIFEST:
        out_path = os.path.join(output_dir, stl_name)
        cmd = [openscad_bin, "-o", out_path]
        if mod:
            cmd.extend(["-D", f"{mod};"])
        cmd.append(src)
        
        print(f"  --> Rendering {stl_name}...")
        res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if res.returncode == 0:
            print(f"      [OK] Created {out_path}")
        else:
            print(f"      [ERROR] Failed to render {stl_name}: {res.stderr.decode('utf-8')}")

    print("\nBatch export completed!")

if __name__ == "__main__":
    main()
