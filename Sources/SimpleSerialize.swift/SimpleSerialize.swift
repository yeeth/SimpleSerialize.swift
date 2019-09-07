//
//  SimpleSerialize.swift
//  SimpleSerialize.swift
//
//  Created by Eric Tu on 1/16/19.
//

import Foundation
import web3swift

typealias Byte = UInt8
protocol BytesConvertable{
    var toBytes: [Byte] { get }
}

protocol UIntToBytesConvertable: BytesConvertable {
}


//extension Data {
//    func hex(separator:String = "") -> String {
//        return (self.map { String(format: "%02X", $0) }).joined(separator: separator)
//    }
//}
//
//struct Address {
//    var address: Data
//    var isValid: Bool {
//        return address.count == 20
//    }
//
//    public init (addressString: String) {
//        address = Data(addressString.data(using: String.Encoding.utf8))
//    }
//}


extension UIntToBytesConvertable {
    func toBytes <T: BinaryInteger>(endian: T) -> [Byte]{
        var _endian = endian
        let count = endian.bitWidth/8
        let bytePtr = withUnsafePointer(to: &_endian) {
            $0.withMemoryRebound(to: Byte.self, capacity: count) {
                UnsafeBufferPointer(start: $0, count: count)
            }
        }
        return [Byte](bytePtr)
    }
}

extension UInt8: UIntToBytesConvertable {
    var toBytes: [Byte] {
        return toBytes(endian: self.littleEndian)
    }
    func serialize() -> Data{
        return Data(toBytes)
    }
}

extension UInt16: UIntToBytesConvertable  {
    var toBytes: [Byte] {
        return toBytes(endian: self.littleEndian)
    }
    func serialize() -> Data{
        return Data(toBytes)
    }
}

extension UInt32: UIntToBytesConvertable  {
    var toBytes: [Byte] {
        return toBytes(endian: self.littleEndian)
    }
    func serialize() -> Data{
        return Data(toBytes)
    }
}

extension UInt64: UIntToBytesConvertable  {
    var toBytes: [Byte] {
        return toBytes(endian: self.littleEndian)
    }
    func serialize() -> Data{
        return Data(toBytes)
    }
}

extension Bool: BytesConvertable {
    var toBytes: [Byte]{
        if self == true {
            return [1]
        } else {
            return [0]
        }
    }
    func serialize() -> Data {
        return Data(toBytes)
    }
}

//Serialize Bytes
extension Array where Iterator.Element == Byte {
    func serialize() -> Data {
        print("LLL",self.count)
        assert(self.count < 2^32)
        let length = UInt32(self.count)
        let serializedLength: Data = length.serialize()
        print("LEN: ",serializedLength)
        return serializedLength + self
    }
}

// List/Vectors of the same type
extension Array where Element: BytesConvertable{
    func serialize () -> Data{
        print ("HIHITIHTITIHI")
        return self.map {elem in elem.toBytes}
        .reduce([], +).serialize()
    }
}

//Container


extension Array where Iterator.Element == Byte {

    //Deserialize UInts
    func deserialize <T: UIntToBytesConvertable> (type: T.Type) -> T {
        let uint = UnsafePointer(self).withMemoryRebound(to: T.self, capacity: 1) {
            $0.pointee
        }
        return uint
    }

    //Deserialize Bools take anther look... Looks wrong tbh
    func deserialize <T> (type: T.Type) -> Bool {
        assert (self.count == 1)
        if self[0] == 1{
            return true
        } else {
            return false
        }
    }
    

    //List/Vectors of same type
//    func deserialize <T> (type: [T.Type]) -> [T] {
//        //assert(self.count > )
//
//        return;
//    }
}


//protocol StructConvertable{
//    var toBytes: Data{get}
//}



//import Foundation
//typealias SSZCodable = SSZDecodable & SSZEncodable
//
//protocol SSZEncodable: Encodable{
//    static func encode<T: UnsignedInteger>( _ object: T) -> Data? where T:Encodable
//
//}
//
//protocol SSZDecodable: Decodable{
//
//    static func decode<T:Decodable>(_ type: T.Type, from data: Data) -> Decodable?
//}
//
//
//
//extension SSZEncodable{
//    static func encode<T: UnsignedInteger>( object: T) -> Data? where T:Encodable {
//        static func toBytes <T: BinaryInteger>(endian: T) -> [UInt8]{
//            var _endian = endian
//            let count = endian.bitWidth/8
//            let bytePtr = withUnsafePointer(to: &_endian) {
//                $0.withMemoryRebound(to: UInt8.self, capacity: count) {
//                    UnsafeBufferPointer(start: $0, count: count)
//                }
//            }
//            return [UInt8](bytePtr)
//        }
//        return Data(toBytes(endian: object.littleEndian))
//    }
//}
//
//final class Decode<T: Decodable>{
//
//}
