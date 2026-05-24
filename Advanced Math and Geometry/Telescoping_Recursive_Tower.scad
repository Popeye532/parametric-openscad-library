
// levels: number of levels of the tower
// base_radius: radius of the first cylinder, decreases by a factor of Factor
// layer_height: height of a single layer
// _eps and _is_internal are reserved for internal logic. Do not override.
module telescoping_tower(levels, base_radius, layer_height, factor, _eps = 0.01, _is_internal = false) {
    // 1. Validation only happens at the public entry point
    if (!_is_internal) {
        assert(levels > 0&&base_radius>0&&layer_height>0&&factor>0, "All parameters must be positive");
        assert(floor(levels) == levels, "Levels must be an integer");
        assert(factor < 1, "Factor must be less than 1");
    }

    if (levels > 0) {
        // Adjust height ONLY if we are not the very first base layer
        _h_adj = _is_internal ? _eps : 0;
        
        // Render current layer
        cylinder(r = base_radius, h = layer_height + _h_adj, $fn = 50);

        // Move to the top of the CURRENT layer (pure height), then sink back by eps
        translate([0, 0, layer_height])
        translate([0, 0, -_eps])
            telescoping_tower(levels - 1, base_radius * factor, layer_height, _eps, _is_internal = true);
    }
}

telescoping_tower(10, 100, 100, factor=0.8);