//
//  SingleValueEncodingContainer.swift
//  BigInt
//
//  Created by Eric Tu on 2/18/19.
//

import Foundation

extension _SSZEncoder {
    final class SingleValueContainer {
        private var storage: Data = Data()
        
        fileprivate var canEncodeNewValue = true
        fileprivate func checkCanEncode(value: Any?) throws {
            guard self.canEncodeNewValue else {
                let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Attempt to encode value through single value container when previously value already encoded.")
                throw EncodingError.invalidValue(value as Any, context)
            }
        }

        var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
        
        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
        }
    }
}

extension _SSZEncoder.SingleValueContainer: SingleValueEncodingContainer {
    typealias Byte = UInt8
    func encodeNil() throws {
//        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode nil.")
//        throw EncodingError.invalidValue(nil, context)
    }
    
    func encode(_ value: Bool) throws {
        try checkCanEncode(value: nil)
        defer { self.canEncodeNewValue = false }
        
        switch value {
        case false:
            self.storage.append(0x0)
        case true:
            self.storage.append(0x1)
        }
    }
    
    func encode(_ value: String) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Strings.")
        throw EncodingError.invalidValue(value, context)
    }
    
    func encode(_ value: Double) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Double.")
        throw EncodingError.invalidValue(value, context)
    }
    
    func encode(_ value: Float) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Float.")
        throw EncodingError.invalidValue(value, context)
    }
    
    func encode(_ value: Int) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Int.")
        throw EncodingError.invalidValue(value, context)
    }

    func encode(_ value: Int8) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Int8.")
        throw EncodingError.invalidValue(value, context)
    }

    func encode(_ value: Int16) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Int16.")
        throw EncodingError.invalidValue(value, context)
    }
    
    func encode(_ value: Int32) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Int32.")
        throw EncodingError.invalidValue(value, context)
    }

    func encode(_ value: Int64) throws {
        let context = EncodingError.Context(codingPath: self.codingPath, debugDescription: "Cannot encode type: Int64.")
        throw EncodingError.invalidValue(value, context)
    }

    
    internal func encodeUInt <T: BinaryInteger>(endian: T) -> [Byte]{
        var _endian = endian
        let count = endian.bitWidth/8
        let bytePtr = withUnsafePointer(to: &_endian) {
            $0.withMemoryRebound(to: Byte.self, capacity: count) {
                UnsafeBufferPointer(start: $0, count: count)
            }
        }
        return [Byte](bytePtr)
    }
    func encode(_ value: UInt) throws {
        let encoded = encodeUInt(endian: value.littleEndian)
        self.storage.append(contentsOf: encoded)
    }
    
    func encode(_ value: UInt8) throws {
        let encoded = encodeUInt(endian: value.littleEndian)
        self.storage.append(contentsOf: encoded)
    }
    
    func encode(_ value: UInt16) throws {
        let encoded = encodeUInt(endian: value.littleEndian)
        self.storage.append(contentsOf: encoded)
    }
    
    func encode(_ value: UInt32) throws {
        let encoded = encodeUInt(endian: value.littleEndian)
        self.storage.append(contentsOf: encoded)
    }
    
    func encode(_ value: UInt64) throws {
        let encoded = encodeUInt(endian: value.littleEndian)
        self.storage.append(contentsOf: encoded)
    }
    
    func encode<T>(_ value: T) throws where T : Encodable {
        try checkCanEncode(value: value)
        defer { self.canEncodeNewValue = false }
        
        switch value {
        case let data as Data:
            try self.encode(data)
        case let date as Date:
            try self.encode(date)
        default:
            let encoder = _SSZEncoder()
            try value.encode(to: encoder)
            self.storage.append(encoder.data)
        }
    }
}

extension _SSZEncoder.SingleValueContainer: SSZEncodingContainer {
    var data: Data {
        return storage
    }
}
