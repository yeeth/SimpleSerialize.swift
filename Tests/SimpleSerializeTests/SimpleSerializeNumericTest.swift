import XCTest
@testable import SimpleSerialize

extension Data {
    private static let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }
    
    public func hexEncodedString() -> String {
        return String(self.reduce(into: "".unicodeScalars, { (result, value) in
            result.append(Data.hexAlphabet[Int(value/16)])
            result.append(Data.hexAlphabet[Int(value%16)])
        }))
    }
}

class SimpleSerializeEncodingTests: XCTestCase {
    
    
    var encoder: SimpleSerializeEncoder!
    
    override func setUp() {
        self.encoder = SimpleSerializeEncoder()
    }
    
    func testEncodeNil() {
        let value = try! encoder.encode(nil as Int?)
        XCTAssertEqual(value, Data(bytes: [0xc0]))
    }
    
    func testEncodeFalse() {
        let value = try! encoder.encode(false)
        XCTAssertEqual(value, Data(bytes: [0x0]))
    }
    
    func testEncodeTrue() {
        let value = try! encoder.encode(true)
        XCTAssertEqual(value, Data(bytes: [0x1]))
    }
    
    func testEncodeUInt16() {
        let value = try! encoder.encode(99 as UInt16)
        XCTAssertEqual(value, Data(bytes: [0x63, 0x00]))
    }
    
    func testEncodeUInt32() {
        let value = try! encoder.encode(128 as UInt32)
        XCTAssertEqual(value, Data(bytes: [0x80, 0x00,0x00,0x00]))
    }
    
    func testEncodeArrayUInt16() {
        let value = try! encoder.encode([1, 2] as [UInt16])
        // print("Actual: ", value.hexEncodedString())
        // print("Expected: ", Data(bytes: [0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00]).hexEncodedString())
        XCTAssertEqual(value, Data(bytes: [0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00]))
    }

    
    static var allTests = [
        ("testEncodeFalse", testEncodeFalse),
        ("testEncodeTrue", testEncodeTrue),
        ("testEncodeUInt32", testEncodeUInt32),
        ("testEncodeArray", testEncodeArrayUInt16),

    ]
}
