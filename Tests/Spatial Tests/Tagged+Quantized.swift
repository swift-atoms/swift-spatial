import Spatial
import Quantizer
import Tagged
import Testing

private enum TestSpace: Quantizer::Quantized {}

extension TestSpace {
    typealias Scalar = Double
    static var quantum: Double { 0.01 }
}

private typealias QX = Coordinate.X<TestSpace>.Value<Double>
private typealias QY = Coordinate.Y<TestSpace>.Value<Double>
private typealias QDx = Displacement.X<TestSpace>.Value<Double>
private typealias QDy = Displacement.Y<TestSpace>.Value<Double>
private typealias QMag = Magnitude<TestSpace>.Value<Double>
private typealias QExtX = Extent.X<TestSpace>.Value<Double>

private func genericEqual<T: Equatable>(_ lhs: T, _ rhs: T) -> Bool {
    lhs == rhs
}

@Suite
struct `Tagged+Quantized` {

    @Suite
    struct `Tick Representation` {

        @Test
        func `ticks property returns correct grid index`() {
            let x: QX = .init(1.234)
            #expect(x.ticks == 123)
        }

        @Test
        func `init from ticks creates correct value`() {
            let x = QX(ticks: 14940)
            #expect(x.ticks == 14940)
        }

        @Test
        func `same tick produces identical bits`() {
            let x1 = QX(ticks: 14940)
            let x2 = QX(ticks: 14940)
            #expect(x1 == x2)
            #expect(x1.underlying.bitPattern == x2.underlying.bitPattern)
        }
    }

    @Suite
    struct `Tick Equality` {

        @Test
        func `equal ticks are equal`() {
            let x1: QX = .init(149.4)
            let x2: QX = .init(149.4000000001)
            #expect(x1 == x2)
            #expect(x1.ticks == x2.ticks)
        }

        @Test
        func `different ticks are not equal`() {
            let x1: QX = .init(149.4)
            let x2: QX = .init(149.5)
            #expect(x1 != x2)
        }
    }

    @Suite
    struct `X Axis` {

        @Test
        func `coordinate + displacement`() {
            let x: QX = .init(100.0)
            let dx: QDx = .init(21.8)
            let result = x + dx
            #expect(result.ticks == 12180)
        }

        @Test
        func `coordinate + displacement accumulation`() {
            let x: QX = .init(84.0)
            let dx: QDx = .init(21.8)
            let row1 = x + dx
            let row2 = row1 + dx
            let row3 = row2 + dx

            #expect(row1.ticks == 10580)
            #expect(row2.ticks == 12760)
            #expect(row3.ticks == 14940)
        }

        @Test
        func `coordinate - coordinate`() {
            let x1: QX = .init(149.4)
            let x2: QX = .init(84.0)
            let dx: QDx = x1 - x2
            #expect(dx.ticks == 6540)
        }

        @Test
        func `coordinate - displacement`() {
            let x: QX = .init(149.4)
            let dx: QDx = .init(21.8)
            let result = x - dx
            #expect(result.ticks == 12760)
        }

        @Test
        func `displacement + displacement`() {
            let dx1: QDx = .init(21.8)
            let dx2: QDx = .init(21.8)
            let dx3: QDx = .init(21.8)
            let sum = dx1 + dx2 + dx3
            #expect(sum.ticks == 6540)
        }

        @Test
        func `displacement - displacement`() {
            let dx1: QDx = .init(65.4)
            let dx2: QDx = .init(21.8)
            let result = dx1 - dx2
            #expect(result.ticks == 4360)
        }
    }

    @Suite
    struct `Y Axis` {

        @Test
        func `coordinate + displacement`() {
            let y: QY = .init(100.0)
            let dy: QDy = .init(21.8)
            let result = y + dy
            #expect(result.ticks == 12180)
        }

        @Test
        func `coordinate - coordinate`() {
            let y1: QY = .init(149.4)
            let y2: QY = .init(84.0)
            let dy: QDy = y1 - y2
            #expect(dy.ticks == 6540)
        }

        @Test
        func `displacement + displacement`() {
            let dy1: QDy = .init(21.8)
            let dy2: QDy = .init(21.8)
            let dy3: QDy = .init(21.8)
            let sum = dy1 + dy2 + dy3
            #expect(sum.ticks == 6540)
        }
    }

    @Suite
    struct `Canonical Quantization` {

        @Test
        func `coordinate + displacement produces canonical bit pattern, not raw float sum`() {
            let x: QX = .init(ticks: 8867)
            let dx: QDx = .init(ticks: -5951)
            let result = x + dx
            let canonical = QX(ticks: 2916)

            #expect(result.ticks == 2916)
            #expect(result.underlying.bitPattern == canonical.underlying.bitPattern)
        }
    }

    @Suite
    struct `Compound Assignment` {

        @Test
        func `coordinate += displacement matches direct addition's canonical bits`() {
            let x: QX = .init(ticks: 8867)
            let dx: QDx = .init(ticks: -5951)

            var d = x
            d += dx
            let direct = x + dx

            #expect(d.ticks == 2916)
            #expect(d.underlying.bitPattern == direct.underlying.bitPattern)
        }

        @Test
        func `coordinate -= displacement matches direct subtraction's canonical bits`() {
            let x: QX = .init(ticks: 14940)
            let dx: QDx = .init(ticks: 21800)

            var d = x
            d -= dx
            let direct = x - dx

            #expect(d.ticks == -6860)
            #expect(d.underlying.bitPattern == direct.underlying.bitPattern)
        }

        @Test
        func `coordinate += magnitude matches direct addition's canonical bits`() {
            let x: QX = .init(ticks: 1000)
            let m: QMag = .init(ticks: 547)

            var d = x
            d += m
            let direct = x + m

            #expect(d.ticks == 1547)
            #expect(d.underlying.bitPattern == direct.underlying.bitPattern)
        }

        @Test
        func `coordinate -= magnitude matches direct subtraction's canonical bits`() {
            let x: QX = .init(ticks: 8867)
            let m: QMag = .init(ticks: 5951)

            var d = x
            d -= m
            let direct = x - m

            #expect(d.ticks == 2916)
            #expect(d.underlying.bitPattern == direct.underlying.bitPattern)
        }

        @Test
        func `coordinate += extent matches direct addition's canonical bits`() {
            let x: QX = .init(ticks: 1000)
            let e: QExtX = .init(ticks: 547)

            var d = x
            d += e
            let direct = x + e

            #expect(d.ticks == 1547)
            #expect(d.underlying.bitPattern == direct.underlying.bitPattern)
        }

        @Test
        func `coordinate -= extent matches direct subtraction's canonical bits`() {
            let x: QX = .init(ticks: 8867)
            let e: QExtX = .init(ticks: 5951)

            var d = x
            d -= e
            let direct = x - e

            #expect(d.ticks == 2916)
            #expect(d.underlying.bitPattern == direct.underlying.bitPattern)
        }
    }

    @Suite
    struct `Equatable Hashable Coherence` {

        @Test
        func `direct and generic equality contexts agree for same-tick, different-bit values`() {
            let x1 = QX(_unchecked: 123.401)
            let x2 = QX(_unchecked: 123.404)

            #expect(x1.ticks == x2.ticks)
            #expect(x1.underlying.bitPattern != x2.underlying.bitPattern)

            #expect((x1 == x2) == genericEqual(x1, x2))
        }
    }

    @Suite
    struct `Boundary Alignment` {

        @Test
        func `accumulated path equals direct path`() {
            let start: QY = .init(84.0)
            let step: QDy = .init(21.8)

            let row1End = start + step
            let row2End = row1End + step
            let row3End = row2End + step

            let total: QDy = .init(65.4)
            let spanEnd = start + total

            #expect(row3End == spanEnd)
            #expect(row3End.ticks == spanEnd.ticks)
            #expect(row3End.ticks == 14940)
        }

        @Test
        func `different computation paths produce same bits`() {
            let start: QY = .init(84.0)
            let step: QDy = .init(21.8)
            let total: QDy = .init(65.4)

            let accumulated = start + step + step + step
            let direct = start + total

            #expect(accumulated.underlying.bitPattern == direct.underlying.bitPattern)
        }
    }
}
