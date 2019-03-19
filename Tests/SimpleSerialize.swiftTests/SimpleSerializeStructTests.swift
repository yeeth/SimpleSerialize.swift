import XCTest
@testable import SimpleSerialize_swift

class SimpleSerializeRoundTripTests: XCTestCase {
    var encoder: SimpleSerializeEncoder!
    
    override func setUp() {
        self.encoder = SimpleSerializeEncoder()
    }

    func testRoundTrip() {
        let value = Airport.example
        let encoded = try! encoder.encode(value)

        print("AC ", encoded.hexEncodedString())
        print("EX ", "03000000020001")
        XCTAssertEqual(encoded.hexEncodedString(), "03000000020001")

    }

    static var allTests = [
        ("testRoundTrip", testRoundTrip)
//        ("testRoundTripArray", testRoundTripArray),
//        ("testRoundTripDictionary", testRoundTripDictionary),
//        ("testRoundTripDate", testRoundTripDate),
//        ("testRoundTripDateWithNanoseconds", testRoundTripDateWithNanoseconds)
    ]
}
