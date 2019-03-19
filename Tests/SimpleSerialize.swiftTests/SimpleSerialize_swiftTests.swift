import XCTest
@testable import SimpleSerialize_swift

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
    
    //    func testEncodeFloat() {
    //        let value = try! encoder.encode(3.14 as Float)
    //        XCTAssertEqual(value, Data(bytes: [0xCA, 0x40, 0x48, 0xF5, 0xC3]))
    //    }
    
    //    func testEncodeDouble() {
    //        let value = try! encoder.encode(3.14159 as Double)
    //        XCTAssertEqual(value, Data(bytes: [0xCB, 0x40, 0x09, 0x21, 0xF9, 0xF0, 0x1B, 0x86, 0x6E]))
    //    }
    //
    //    func testEncodeString() {
    //        let value = try! encoder.encode("hello")
    //        XCTAssertEqual(value, Data(bytes: [0xA5, 0x68, 0x65, 0x6C, 0x6C, 0x6F]))
    //    }
    
    func testEncodeArrayUInt16() {
        let value = try! encoder.encode([1, 2] as [UInt16])
        // print("Actual: ", value.hexEncodedString())
        // print("Expected: ", Data(bytes: [0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00]).hexEncodedString())
        XCTAssertEqual(value, Data(bytes: [0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00]))
    }
    //
    //    func testEncodeDictionary() {
    //        let value = try! encoder.encode(["a": 1])
    //        XCTAssertEqual(value, Data(bytes: [0x81, 0xA1, 0x61, 0x01]))
    //    }
    //
    //    func testEncodeData() {
    //        let data = "hello".data(using: .utf8)
    //        let value = try! encoder.encode(data)
    //        XCTAssertEqual(value, Data(bytes: [0xC4, 0x05, 0x68, 0x65, 0x6C, 0x6C, 0x6F]))
    //    }
    //
    //    func testEncodeDate() {
    //        let date = Date(timeIntervalSince1970: 1)
    //        let value = try! encoder.encode(date)
    //        XCTAssertEqual(value, Data(bytes: [0xD6, 0xFF, 0x00, 0x00, 0x00, 0x01]))
    //    }
    //
    //    func testEncodeDistantPast() {
    //        let date = Date.distantPast
    //        let value = try! encoder.encode(date)
    //        XCTAssertEqual(value, Data(bytes: [0xC7, 0x0C, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xF1, 0x88, 0x6B, 0x66, 0x00]))
    //    }
    //
    //    func testEncodeDistantFuture() {
    //        let date = Date.distantFuture
    //        let value = try! encoder.encode(date)
    //        XCTAssertEqual(value, Data(bytes: [0xC7, 0x0C, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0E, 0xEC, 0x31, 0x88, 0x00]))
    //    }
    //
    //    func testEncodeArrayWithDate() {
    //        let date = Date(timeIntervalSince1970: 1)
    //        let value = try! encoder.encode([date])
    //        XCTAssertEqual(value, Data(bytes: [0x91, 0xD6, 0xFF, 0x00, 0x00, 0x00, 0x01]))
    //    }
    //
    //    func testEncodeDictionaryWithDate() {
    //        let date = Date(timeIntervalSince1970: 1)
    //        let value = try! encoder.encode(["1": date])
    //        XCTAssertEqual(value, Data(bytes: [0x81, 0xA1, 0x31, 0xD6, 0xFF, 0x00, 0x00, 0x00, 0x01]))
    //    }
    
    static var allTests = [
        ("testEncodeFalse", testEncodeFalse),
        ("testEncodeTrue", testEncodeTrue),
        // ("testEncodeInt", testEncodeInt),
        ("testEncodeUInt32", testEncodeUInt32),
        //        ("testEncodeFloat", testEncodeFloat),
        //        ("testEncodeDouble", testEncodeDouble)
        ("testEncodeArray", testEncodeArrayUInt16),
        //("testEncodeDictionary", testEncodeDictionary),
        //("testEncodeDate", testEncodeDate),
        //("testEncodeDistantPast", testEncodeDistantPast),
        //("testEncodeDistantFuture", testEncodeDistantFuture),
        //("testEncodeArrayWithDate", testEncodeArrayWithDate),
        //("testEncodeDictionaryWithDate", testEncodeDictionaryWithDate)
    ]
}
