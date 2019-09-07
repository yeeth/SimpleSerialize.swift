//
//  Encoder.swift
//  BigInt
//
//  Created by Eric Tu on 2/18/19.
//

import Foundation


public class SSZEncoder {
    func encode(_ value: Encodable) throws -> Data {
        let encoder = _SSZEncoder()
        try value.encode(to: encoder)
        return encoder.data
    }
}

final class _SSZEncoder {
    var codingPath: [CodingKey] = []
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    fileprivate var container: SSZEncodingContainer?
    
    var data: Data {
        return container?.data ?? Data()
    }
}

extension _SSZEncoder: Encoder {
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

protocol SSZEncodingContainer: class {
    var data: Data { get }
}
