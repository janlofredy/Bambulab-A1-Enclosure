#!/usr/bin/env python3
"""
Batch STL Exporter for Bambu Lab A1 Enclosure (8-Part Modular Kit)
Exports the 8 standardized core parts + spring clips to stl_exports/
"""

import os
import sys
import subprocess
import shutil

PARTS_MANIFEST = [
    # 4 Main Frame Parts
    ("1_corner_part.stl", "cad/parts/corner_part.scad", None),
    ("2_edge_standard.stl", "cad/parts/edge_standard.scad", None),
    ("3_edge_hinge.stl", "cad/parts/edge_hinge.scad", None),
    ("4_edge_ptfe.stl", "cad/parts/edge_ptfe.scad", None),
    
    # 4 Door & Roof Parts
    ("5_door_corner.stl", "cad/parts/door_corner.scad", None),
    ("6_door_edge.stl", "cad/parts/door_edge.scad", None),
    ("7_door_edge_handle.stl", "cad/parts/door_edge_handle.scad", None),
    ("8_door_edge_hinge.stl", "cad/parts/door_edge_hinge.scad", None),
    
    # Cellophane Retention
    ("9_spline_clip_batch.stl", "cad/parts/spline_clip.scad", "spline_clip_batch()"),
    
    # Test Coupons
    ("test_dovetail_coupon.stl", "cad/tests/dovetail_test_coupon.scad", None),
    ("test_spline_coupon.stl", "cad/tests/spline_test_coupon.scad", None),
]

def check_openscad():
    path = shutil.which("openscad")
    if path: return path
    for p in [
        "/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD",
        "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD",
        os.path.expanduser("~/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD")
    ]:
        if os.path.exists(p): return p
    return None

def main():
    print("==================================================")
    print(" Bambu Lab A1 Enclosure - 8-Part STL Exporter")
    print("==================================================")
    
    openscad_bin = check_openscad()
    out_dir = "stl_exports"
    os.makedirs(out_dir, exist_ok=True)
    
    if not openscad_bin:
        print("[!] OpenSCAD not detected in standard PATH.")
        return 1
        
    print(f"Using OpenSCAD: {openscad_bin}")
    print(f"Exporting 8-part modular kit into '{out_dir}/'...\n")
    
    for stl_name, src, mod in PARTS_MANIFEST:
        out_path = os.path.join(out_dir, stl_name)
        cmd = [openscad_bin, "-o", out_path]
        if mod:
            cmd.extend(["-D", f"{mod};"])
        cmd.append(src)
        
        print(f"  --> Rendering {stl_name}...")
        res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if res.returncode == 0:
            print(f"      [OK] Created {out_path}")
        else:
            print(f"      [ERROR] {res.stderr.decode('utf-8')}")

    print("\nBatch STL export complete!")
    return 0

if __name__ == "__main__":
    sys.exit(main())
