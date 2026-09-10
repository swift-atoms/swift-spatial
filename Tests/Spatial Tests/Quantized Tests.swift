import Spatial
import Quantizer
import Testing

enum TestQuantizedSpace: Quantizer::Quantized {}

extension TestQuantizedSpace {
    typealias Scalar = Double
    static var quantum: Double { 0.01 }
}

@Suite
struct `Quantized Tests` {

    @Suite
    struct `Quantize Tests` {

        @Test
        func `rounds down below midpoint`() throws {
            #expect(try TestQuantizedSpace.quantize(1.234) == 1.23)
            #expect(try TestQuantizedSpace.quantize(0.001) == 0.00)
        }

        @Test
        func `rounds up at midpoint`() throws {
            #expect(try TestQuantizedSpace.quantize(1.235) == 1.24)
            #expect(try TestQuantizedSpace.quantize(0.005) == 0.01)
        }

        @Test
        func `rounds up above midpoint`() throws {
            #expect(try TestQuantizedSpace.quantize(1.236) == 1.24)
            #expect(try TestQuantizedSpace.quantize(0.009) == 0.01)
        }
    }

    @Suite
    struct `quantum(as:)` {

        @Test
        func `converts to Double`() throws {
            let q: Double = TestQuantizedSpace.quantum(as: Double.self)
            #expect(q == 0.01)
        }

        @Test
        func `converts to Float`() throws {
            let q: Float = TestQuantizedSpace.quantum(as: Float.self)
            #expect(q == 0.01)
        }
    }
}
