import Spatial
import Quantizer
import Tagged
import Testing

private enum WideGrid: Quantized {
    static var quantum: Double { 1 }
}

@Suite struct `Spatial values use explicit grid quantization` {
    @Test func `Spatial values have no implicit machine tick bound`() throws {
        let value = Coordinate.X<WideGrid>.Value<Double>(0x1p80)
        #expect(value.underlying == 0x1p80)
        #expect(try value.ticks(as: UInt128.self) == UInt128(1) << 80)
        #expect(throws: Quantizer<Double>.Error.outOfRange) { try value.ticks(as: Int64.self) }
    }
}
