import Spatial
import Tagged
import Testing

@Suite
struct `Spatial - Tagged Values` {
    enum TestSpace {}

    @Test
    func `Tagged with X Coordinate`() {
        let x: Coordinate.X<TestSpace>.Value<Double> = Tagged::Tagged(10.0)
        #expect(x == 10.0)
    }

    @Test
    func `Tagged with Y Displacement`() {
        let dy: Displacement.Y<TestSpace>.Value<Double> = Tagged::Tagged(5.0)
        #expect(dy == 5.0)
    }

    @Test
    func `Tagged with Magnitude`() {
        let mag: Magnitude<TestSpace>.Value<Double> = Tagged::Tagged(3.14)
        #expect(mag == 3.14)
    }

    @Test
    func `Different spaces are different types`() {
        enum Space1 {}
        enum Space2 {}

        let x1: Coordinate.X<Space1>.Value<Double> = Tagged::Tagged(10.0)
        let x2: Coordinate.X<Space2>.Value<Double> = Tagged::Tagged(10.0)

        #expect(type(of: x1) != type(of: x2))
    }

    @Test
    func `Void space for generic geometry`() {
        let x: Coordinate.X<Void>.Value<Double> = Tagged::Tagged(10.0)
        let y: Coordinate.Y<Void>.Value<Double> = Tagged::Tagged(20.0)

        #expect(x == 10.0)
        #expect(y == 20.0)
    }
}
