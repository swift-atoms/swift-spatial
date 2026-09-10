import Spatial
import Testing

@Suite struct `Spatial role boundaries` {
    enum Frame {}
    enum OtherFrame {}

    @Test func `coordinate difference preserves its displacement role`() {
        let start = Coordinate.X<Frame>.Value<Int>(-8)
        let end = Coordinate.X<Frame>.Value<Int>(3)
        let delta: Displacement.X<Frame>.Value<Int> = end - start
        #expect(delta.underlying == 11)
        #expect(start + delta == end)
    }

    @Test func `axis and frame tags remain distinct`() {
        #expect(ObjectIdentifier(Coordinate.X<Frame>.self) != ObjectIdentifier(Coordinate.Y<Frame>.self))
        #expect(ObjectIdentifier(Coordinate.X<Frame>.self) != ObjectIdentifier(Coordinate.X<OtherFrame>.self))
        #expect(ObjectIdentifier(Coordinate.X<Frame>.self) != ObjectIdentifier(Displacement.X<Frame>.self))
    }

    @Test func `legacy extents remain signed values`() {
        let offset = Displacement.X<Frame>.Value<Int>(-5)
        let extent: Extent.X<Frame>.Value<Int> = width(offset)
        #expect(extent.underlying == -5)
        #expect((extent - Extent.X<Frame>.Value<Int>(2)).underlying == -7)
    }

    @Test func `dimensional product retains signed measure and exponent`() {
        let length = Measure<1, Frame>.Value<Double>(-3)
        let area: Measure<2, Frame>.Value<Double> = length * length
        let volume: Measure<3, Frame>.Value<Double> = area * length
        #expect(area.underlying == 9)
        #expect(volume.underlying == -27)
    }

    @Test func `area root returns length and follows scalar domain`() {
        let area = Area<Frame>.Value<Double>(25)
        let length: Magnitude<Frame>.Value<Double> = sqrt(area)
        #expect(length.underlying == 5)
        #expect(sqrt(Area<Frame>.Value<Double>(-1)).underlying.isNaN)
    }

    @Test func `fourth axis storage retains role and scalar`() {
        let coordinate = Coordinate.W<Frame>.Value<Int>(9)
        let displacement = Displacement.W<Frame>.Value<Int>(-2)
        #expect(coordinate.underlying == 9)
        #expect(displacement.underlying == -2)
    }
}
