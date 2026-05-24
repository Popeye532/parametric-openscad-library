# Parametric OpenSCAD Library

A collection of 17 highly parametric, automated, and library-grade 3D script utilities written for OpenSCAD. This repository moves away from static modeling, focusing instead on procedural components, data-driven mechanical hardware, complex algorithmic geometries, and animated kinetic assemblies.

## 🛠️ Key Features
* **Defensive Parametric Design:** Comprehensive use of rigorous compile-time `assert()` checks ensuring inputs conform to dimensional limits before compilation.
* **Procedural & Data-Driven Logic:** Integrates complex look-up tables (`search()` and `lookup()`) to reference engineering standards directly inside code arrays.
* **Dynamic Geometry Hooks:** Leverages advanced children iteration pipelines (`$children` arrays and child masking) to apply operations smoothly across arbitrary user shapes.
* **Strict Variable Isolation:** Built with localized internal variables (`_eps`, `_angle_inc`, `_v`) ensuring a collision-free environment.

---

## 📂 Repository Directory Structure

The utility suite is broken down into 5 targeted engineering disciplines, meticulously organized in chronological sequence (from Day 8 through Day 23, followed by project-specific tooling):

### 1. Layouts and Arrays
* **`Planetary_Gear_Layout_Template.scad`** *(Day 8)* An automated layout engine for generating spatial placements of planetary gears with modular outwards-facing alignment keys.
* **`Parametric_Radial_Text_Engraving.scad`** *(Day 14)* Advanced circular coordinate mapping that dynamically handles letter widths and mathematical text-wrap limits around cylinders.
* **`Staggered_and_Standard_Grid_Arrays.scad`** *(Learn.scad)* A clean array tool capable of generating standard rectangular matrices or alternating interleaved grids via automatic child-index mapping.

### 2. Advanced Math and Geometry
* **`Procedural_Polyhedron_Cylinder.scad`** *(Day 9)* Skips native primitives entirely to build an explicitly mapped 3D mesh polyhedron using analytical vector loop point generation.
* **`Recursive_Fractal_Tree_Generator.scad`** *(Day 15)* Implements multi-level algorithmic 3D branching with strict recursion-depth limits and automatic component scaling.
* **`Procedural_Wireframe_and_Strut_Truss.scad`** *(Day 19)* Calculates vector transformations (`norm`, `cross`, `acos`) to safely project structural beams between arbitrary 3D coordinate paths.
* **`Telescoping_Recursive_Tower.scad`** *(TelescopingTower.openscad)* A recursive rendering utility that handles multi-tier component shrinkage and precise relative-offset translation stack shifts.

### 3. Motion and Animation
* **`Animated_Mechanisms_Rack_and_Wiper.scad`** *(Day 12)* Uses the global time variable `$t` to simulate mechanical movement profiles for linear racks, rotating pinions, and oscillating sweeps.
* **`Animated_Linear_Actuator_Assembly.scad`** *(Day 23)* A full actuator simulation engine that links a NEMA casing model to a moving slide carriage using custom timing parameters.

### 4. Data and Automation
* **`Conformal_Component_Tray_Generator.scad`** *(Day 16)* Extracts 2D profiles from any arbitrary child geometry via `projection()`, processing it through a mathematical `minkowski()` shell to generate matching custom vacuum storage containers.
* **`Data_Driven_Mechanical_Spline.scad`** *(Day 18)* Generates precise mechanical spline patterns using programmatic lookup arrays conforming to standard industrial metrics.
* **`Dynamic_Hulled_Gasket_Generator.scad`** *(CustomGasket.scad)* An elegant utility that parses an undefined number of input shapes to systematically weave continuous outer sealing tracks using linear `hull()` cascades.

### 5. Mechanical Hardware
* **`Parametric_Hinge_Assembly.scad`** *(Day 11)* A versatile modular hinge that uses conditional compilation flags to instantly toggle between an expanded production flat-pattern layout and an integrated 3D assembly.
* **`Parametric_Cantilever_Snap_Hook.scad`** *(Day 17)* A programmatic 2D profile builder that calculates stress-relieving fillets on structural mounting hooks using inverse geometric offsets.
* **`Parametric_Star_Knob_with_Nut_Trap.scad`** *(Day 22)* Generates modular toolless equipment thumb grips complete with custom clearance configurations for capturing hex nuts.
* **`Parametric_V_Belt_Pulley.scad`** *(Assignment.scad)* A precision transmission component engine using custom asymmetric mirrors and profile sub-cuts to extrude multi-groove high-efficiency pulleys.
* **`NEMA_Motor_Mount_and_Bolt_Patterns.scad`** *(learn1.scad)* A standardized lookup library providing automated mount configurations and accurate bolt-hole placements across distinct motor frame classifications.

---

## 🚀 Getting Started

### Prerequisites
Download and install the latest stable environment from [OpenSCAD.org](https://openscad.org/downloads.html).

### Usage
1. Clone the repository to your local directory:
   ```bash
   git clone https://github.com/Popeye532/parametric-openscad-library.git
   ```
2. Open any .scad file within OpenSCAD.

3. Modify the customizable parameters to dynamically fit your physical requirements.

4. Press F5 to preview the model or F6 to compute the fully rendered 3D geometry for export.
