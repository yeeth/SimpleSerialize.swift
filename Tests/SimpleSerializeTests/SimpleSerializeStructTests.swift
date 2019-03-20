import XCTest
@testable import SimpleSerialize

class SimpleSerializeRoundTripTests: XCTestCase {
    var encoder: SimpleSerializeEncoder!
    
    override func setUp() {
        self.encoder = SimpleSerializeEncoder()
    }

    func testSimpleStruct() {
        let value = SomeStruct.example
        let encoded = try! encoder.encode(value)

        XCTAssertEqual(encoded.hexEncodedString(), "03000000020001")

    }

    static var allTests = [
        ("testSimpleStruct", testSimpleStruct)
    ]
}
