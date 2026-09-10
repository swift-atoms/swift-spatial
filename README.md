
## Layer and ownership

Spatial combines frame-tagged coordinate roles, extents, dimensional measures and quantization policy. It is a molecule. The atom layer supplies Affine points, mathematical Vector/Matrix values, Magnitude and Tagged. Adapting this implementation to those cores is deferred to the higher-layer pass.

Uniform-grid values use Quantizer directly. Value construction and arithmetic no longer narrow grid coordinates to Int64. The existing nonthrowing constructors require a valid grid and representable finite result. The legacy `ticks` property specifically requires an Int64-representable coordinate; `ticks(as:)` provides explicit storage selection and typed failures.
