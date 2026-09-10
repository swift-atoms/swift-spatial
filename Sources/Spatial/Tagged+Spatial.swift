public import Tagged

@inlinable
public func sqrt<Space, Scalar: FloatingPoint>(
    _ value: Tagged::Tagged<Area<Space>, Scalar>
) -> Tagged::Tagged<Magnitude<Space>, Scalar> {
    Tagged::Tagged(_unchecked: value.underlying.squareRoot())
}

extension Tagged::Tagged where Tag: Spatial {

    @_disfavoredOverload
    @inlinable
    public init(_ value: Underlying) {
        self.init(_unchecked: value)
    }
}

extension Tagged::Tagged where Tag: Spatial, Underlying: BinaryFloatingPoint {

    @inlinable
    public init(_ value: Underlying) {
        self = ._quantize(value, in: Tag.Space.self)
    }
}
