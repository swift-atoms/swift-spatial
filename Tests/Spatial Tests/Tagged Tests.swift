import Numeric
import Scale
import Tagged
import Tagged_Standard_Library_Integration
import Testing

@testable import Spatial

@Suite
struct `Tagged - Displacement Arithmetic` {
    enum TestSpace {}

    @Test
    func `displacement + displacement`() {
        let dx1: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx2: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(20.0)
        let result = dx1 + dx2
        #expect(result == 30.0)
    }

    @Test
    func `displacement - displacement`() {
        let dx1: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(30.0)
        let dx2: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let result = dx1 - dx2
        #expect(result == 20.0)
    }

    @Test
    func `displacement negation`() {
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let result = -dx
        #expect(result == -10.0)
    }

    @Test
    func `displacement scaling by scale`() {
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let result1 = dx * Scale(2.0)
        let result2 = Scale(2.0) * dx
        #expect(result1 == 20.0)
        #expect(result2 == 20.0)
    }

    @Test
    func `displacement division by scale`() {
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let result = dx / Scale(2.0)
        #expect(result == 5.0)
    }

    @Test
    func `displacement ratio returns scale`() {
        let dx1: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx2: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(2.0)
        let ratio: Scale<1, Double> = dx1 / dx2
        #expect(ratio.value == 5.0)
    }
}

@Suite
struct `Tagged - Coordinate Displacement Arithmetic` {
    enum TestSpace {}

    @Test
    func `coordinate + displacement = coordinate`() {
        let x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        let result = x + dx
        #expect(result == 15.0)
    }

    @Test
    func `displacement + coordinate = coordinate`() {
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        let x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let result = dx + x
        #expect(result == 15.0)
    }

    @Test
    func `coordinate - displacement = coordinate`() {
        let x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        let result = x - dx
        #expect(result == 7.0)
    }

    @Test
    func `coordinate - coordinate = displacement`() {
        let x1: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let x2: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(7.0)
        let result: Displacement.X<TestSpace>.Value<Double> = x1 - x2
        #expect(result == 3.0)
    }

    @Test
    func `coordinate += displacement (Double, non-quantized space)`() {
        var x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        x += dx
        #expect(x == 15.0)
    }

    @Test
    func `coordinate -= displacement (Double, non-quantized space)`() {
        var x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        x -= dx
        #expect(x == 7.0)
    }

    @Test
    func `coordinate += displacement (Int, plain AdditiveArithmetic space)`() {
        var x: Coordinate.X<TestSpace>.Value<Int> = Tagged::Tagged(10)
        let dx: Displacement.X<TestSpace>.Value<Int> = Tagged::Tagged(5)
        x += dx
        #expect(x == 15)
    }

    @Test
    func `coordinate -= displacement (Int, plain AdditiveArithmetic space)`() {
        var x: Coordinate.X<TestSpace>.Value<Int> = Tagged::Tagged(10)
        let dx: Displacement.X<TestSpace>.Value<Int> = Tagged::Tagged(3)
        x -= dx
        #expect(x == 7)
    }
}

@Suite
struct `Tagged - Magnitude Arithmetic` {
    enum TestSpace {}

    @Test
    func `magnitude + magnitude`() {
        let m1: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let m2: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        let result = m1 + m2
        #expect(result == 15.0)
    }

    @Test
    func `magnitude - magnitude`() {
        let m1: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let m2: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        let result = m1 - m2
        #expect(result == 7.0)
    }

    @Test
    func `magnitude scaling`() {
        let m: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let result = m * Scale(2.0)
        #expect(result == 20.0)
    }

    @Test
    func `coordinate + magnitude = coordinate`() {
        let x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let m: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        let result = x + m
        #expect(result == 15.0)
    }

    @Test
    func `coordinate - magnitude = coordinate`() {
        let x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let m: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        let result = x - m
        #expect(result == 7.0)
    }
}

@Suite
struct `Tagged - Dimensional Arithmetic` {
    enum TestSpace {}

    @Test
    func `displacement x displacement = area`() {
        let dx: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        let dy: Displacement.Y<TestSpace>.Value<Double> = Tagged::Tagged(4.0)
        let area: Area<TestSpace>.Value<Double> = dx * dy
        #expect(area == 12.0)
    }

    @Test
    func `area + area`() {
        let a1: Area<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let a2: Area<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        let result = a1 + a2
        #expect(result == 15.0)
    }

    @Test
    func `area - area`() {
        let a1: Area<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let a2: Area<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        let result = a1 - a2
        #expect(result == 7.0)
    }

    @Test
    func `area div magnitude = magnitude`() {
        let area: Area<TestSpace>.Value<Double> = Tagged::Tagged(12.0)
        let mag: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(3.0)
        let result: Magnitude<TestSpace>.Value<Double> = area / mag
        #expect(result == 4.0)
    }
}

@Suite
struct `Tagged - Free Functions` {
    enum TestSpace {}

    @Test
    func `abs function`() {
        let negative: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(-10.0)
        let result = abs(negative)
        #expect(result == 10.0)
    }

    @Test
    func `min free function`() {
        let dx1: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx2: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(20.0)
        let result = min(dx1, dx2)
        #expect(result == 10.0)
    }

    @Test
    func `max free function`() {
        let dx1: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        let dx2: Displacement.X<TestSpace>.Value<Double> = Tagged::Tagged(20.0)
        let result = max(dx1, dx2)
        #expect(result == 20.0)
    }
}

@Suite
struct `Tagged - Zero` {
    enum TestSpace {}

    @Test
    func `zero for displacement`() {
        let zero: Displacement.X<TestSpace>.Value<Double> = .zero
        #expect(zero == 0.0)
    }

    @Test
    func `zero for magnitude`() {
        let zero: Magnitude<TestSpace>.Value<Double> = .zero
        #expect(zero == 0.0)
    }
}
