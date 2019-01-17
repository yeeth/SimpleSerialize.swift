//
//  SimpleSerialize.swift
//  SimpleSerialize.swift
//
//  Created by Eric Tu on 1/16/19.
//

import Foundation

typealias Byte = UInt8

protocol UIntToBytesConvertable {
    var toBytes: [Byte] { get }
}

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
        return toBytes(endian: self.bigEndian)
    }
    func serialize() -> Data{
        let bytesArray = toBytes
        return Data(bytes: bytesArray, count: bytesArray.count)
    }
}

extension UInt16: UIntToBytesConvertable  {
    var toBytes: [Byte] {
        return toBytes(endian: self.bigEndian)
    }
    func serialize() -> Data{
        let bytesArray = toBytes
        return Data(bytes: bytesArray, count: bytesArray.count)
    }
}

extension UInt32: UIntToBytesConvertable  {
    var toBytes: [Byte] {
        return toBytes(endian: self.bigEndian)
    }
    func serialize() -> Data{
        let bytesArray = toBytes
        return Data(bytes: bytesArray, count: bytesArray.count)
    }
}

extension UInt64: UIntToBytesConvertable  {
    var toBytes: [Byte] {
        return toBytes(endian: self.bigEndian)
    }
    func serialize() -> Data{
        let bytesArray = toBytes
        return Data(bytes: bytesArray, count: bytesArray.count)
    }
}

extension Bool {
    func serialize() -> Data{
        if self == true {
            return Data(bytes: [1])
        } else {
            return Data(bytes: [0])
        }
    }
}

//Address, hashN
extension Data {
    func serialize(length :UInt) -> Data{
        assert(self.count == length)
        return self
    }
}
