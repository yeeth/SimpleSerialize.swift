import Foundation

extension Data {
    private static let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }
    
    public func hexEncodedString() -> String {
        return String(self.reduce(into: "".unicodeScalars, { (result, value) in
            result.append(Data.hexAlphabet[Int(value/16)])
            result.append(Data.hexAlphabet[Int(value%16)])
        }))
    }
}


/**
 An object that encodes instances of a data type as SimpleSerialize objects.
 */

final public class SimpleSerializeEncoder {
    public init() {}
    
    /**
     A dictionary you use to customize the encoding process
     by providing contextual information.
     */
    public var userInfo: [CodingUserInfoKey : Any] = [:]

    /**
     Returns a SimpleSerialize-encoded representation of the value you supply.
     
     - Parameters:
        - value: The value to encode as SimpleSerialize.
     - Throws: `EncodingError.invalidValue(_:_:)`
                if the value can't be encoded as a SimpleSerialize object.
     */
    public func encode(_ value: Encodable) throws -> Data {
        let encoder = _SimpleSerializeEncoder()
        encoder.userInfo = self.userInfo
        switch value {
        case let data as Data:
            try Box<Data>(data).encode(to: encoder)
        case let date as Date:
            try Box<Date>(date).encode(to: encoder)
        default:
            try value.encode(to: encoder)
        }
        return encoder.data
    }
}

// MARK: -

protocol _SimpleSerializeEncodingContainer {
    var data: Data { get }
}

class _SimpleSerializeEncoder {
    var codingPath: [CodingKey] = []
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    fileprivate var container: _SimpleSerializeEncodingContainer?
    
    var data: Data {
        return container?.data ?? Data()
    }
}

extension _SimpleSerializeEncoder: Encoder {
    fileprivate func assertCanCreateContainer() {
        precondition(self.container == nil)
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        assertCanCreateContainer()
        
        let container = KeyedContainer<Key>(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        assertCanCreateContainer()
        let container = UnkeyedContainer(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        
        return container
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        assertCanCreateContainer()
        
        
        let container = SingleValueContainer(codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        
        return container
    }
}
