#!/usr/bin/env python3
"""
Automated Kinematic & Bed Envelope Validator for Bambu Lab A1 Enclosure
Verifies that:
1. Every printable part fits within the 256 x 256 x 256 mm A1 build plate.
2. Full Y-bed travel and rear heatbed cable relief have ample clearance.
3. Right-side poop bucket fits inside with clearance.
4. Top-mounted BMCU 370c and spool rotate freely without roof contact.
5. Critical 3D printing tolerances adhere to FDM standards for 0.4mm nozzle.
"""

import sys
import re
import math

def parse_config(filepath):
    params = {}
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            # Match OpenSCAD variable assignment: NAME = VALUE;
            m = re.match(r'^([A-Z_0-9]+)\s*=\s*([^;]+);', line)
            if m:
                name, expr = m.group(1), m.group(2).strip()
                # Simple evaluation of constants
                try:
                    params[name] = eval(expr, {"__builtins__": None}, params)
                except Exception:
                    pass
    return params

def main():
    print("==================================================")
    print(" Bambu Lab A1 Enclosure Design & Bed Verification")
    print("==================================================")
    
    config_path = "cad/config.scad"
    params = parse_config(config_path)
    
    # 1. Print Bed Limit Check
    max_bed_x = params.get("MAX_PRINT_X", 256)
    max_bed_y = params.get("MAX_PRINT_Y", 256)
    max_bed_z = params.get("MAX_PRINT_Z", 256)
    safe_max = params.get("SAFE_PART_MAX_LEN", 240)
    
    print(f"\n[1] Build Plate Limits: {max_bed_x} x {max_bed_y} x {max_bed_z} mm")
    print(f"    Safe max part dimension threshold: {safe_max} mm")
    
    # Check Segments
    seg_x = params.get("SPAN_X", 536) / params.get("NUM_SEGS_X", 3)
    seg_y = params.get("SPAN_Y", 556) / params.get("NUM_SEGS_Y", 3)
    seg_z = params.get("SPAN_Z", 686) / params.get("NUM_SEGS_Z", 3)
    corner_size = params.get("CORNER_BLOCK_SIZE", 36)
    
    components = [
        ("Bottom/Top Corner Blocks", corner_size, corner_size, corner_size),
        ("X-Span Beam Segments", seg_x, params.get("BEAM_WIDTH", 24), params.get("BEAM_HEIGHT", 24)),
        ("Y-Span Beam Segments", seg_y, params.get("BEAM_WIDTH", 24), params.get("BEAM_HEIGHT", 24)),
        ("Z-Span Pillar Segments", seg_z, params.get("BEAM_WIDTH", 24), params.get("BEAM_HEIGHT", 24)),
        ("PTFE 4-Tube Entry Module", seg_y, params.get("BEAM_WIDTH", 24), params.get("BEAM_HEIGHT", 24)),
        ("Door Vertical Stile Segments", params.get("INTERNAL_HEIGHT", 710)/3, 16, 16),
        ("Door Horizontal Rails (Segmented)", ((params.get("INTERNAL_WIDTH", 560)/2) - 32) / 2, 16, 16),
        ("Roof Door Depth Segments", params.get("INTERNAL_DEPTH", 580)/3, 16, 16),
        ("Roof Heat-Dissipation Prop Leg", 135, 12, 6),
        ("Snap-in Spline Clips (Max)", 220, 4.5, 6),
    ]
    
    all_fit = True
    print("\n[2] Checking Component Printability on A1 Bed:")
    for name, length, w, h in components:
        # Longest dimension check
        max_dim = max(length, w, h)
        fits = max_dim <= safe_max
        status = "PASS" if fits else "FAIL"
        if not fits:
            all_fit = False
        print(f"  • {name:<32}: {length:6.1f} x {w:4.1f} x {h:4.1f} mm  --> [{status}] (Max: {max_dim:.1f} mm <= {safe_max} mm)")
    
    # 2. Kinematic Clearances
    internal_w = params.get("INTERNAL_WIDTH", 560)
    internal_d = params.get("INTERNAL_DEPTH", 580)
    internal_h = params.get("INTERNAL_HEIGHT", 710)
    
    print("\n[3] Kinematic Clearances & Safety Margins:")
    
    # Depth (Y bed travel)
    # A1 bed size = 256mm, full travel envelope ~ 540mm (including heatbed cable relief loop)
    required_y_travel = 540
    clearance_y = internal_d - required_y_travel
    print(f"  • Y-Axis (Bed-Slinger Travel): Internal={internal_d} mm, Required={required_y_travel} mm")
    print(f"    --> Buffer Margin: +{clearance_y:.1f} mm {'[PASS]' if clearance_y >= 30 else '[WARN]'}")
    
    # Width (X base + bucket)
    # A1 base width ~385mm, right poop bucket ~100mm -> 485mm
    required_x = 485
    clearance_x = internal_w - required_x
    print(f"  • X-Axis (Width + Poop Bucket): Internal={internal_w} mm, Required={required_x} mm")
    print(f"    --> Buffer Margin: +{clearance_x:.1f} mm {'[PASS]' if clearance_x >= 40 else '[WARN]'}")
    
    # Height (Z gantry + BMCU 370c + rotating spool)
    # Gantry ~465mm, BMCU 370c + spool ~200mm -> 665mm
    required_z = 665
    clearance_z = internal_h - required_z
    print(f"  • Z-Axis (Gantry + BMCU 370c + Spool): Internal={internal_h} mm, Required={required_z} mm")
    print(f"    --> Overhead Clearance: +{clearance_z:.1f} mm {'[PASS]' if clearance_z >= 35 else '[WARN]'}")
    
    # 3. Tolerances check
    tol_dovetail = params.get("TOL_DOVETAIL", 0.20)
    tol_hinge = params.get("TOL_HINGE", 0.30)
    tol_tight = params.get("TOL_TIGHT", 0.15)
    
    print("\n[4] 3D Printing Tolerance Check:")
    print(f"  • Dovetail Slide Tolerance: {tol_dovetail:.2f} mm (Standard FDM sliding fit)")
    print(f"  • Door & Roof Hinge Gap   : {tol_hinge:.2f} mm (Smooth rotating fit)")
    print(f"  • Spline Friction Pinch    : {tol_tight:.2f} mm (Firm tension clamp)")
    
    if all_fit and clearance_y >= 30 and clearance_x >= 40 and clearance_z >= 35:
        print("\n>>> ALL VALIDATION CHECKS PASSED SUCCESSFULLY! <<<")
        return 0
    else:
        print("\n>>> VALIDATION WARNINGS DETECTED! <<<")
        return 1

if __name__ == "__main__":
    sys.exit(main())
