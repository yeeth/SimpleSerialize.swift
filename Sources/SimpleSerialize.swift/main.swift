import Foundation
//import web3swift

print("Hello, world!")

let x: UInt16 = 99
let xs = x.serialize().hex
print(xs)

//print(xs.deserialize(type: UInt32.self))

//print ("\(u16)")
print(true.serialize().hex)


let boolarr: [Bool] = [true,false,false,true]
print("ASDF ", boolarr.serialize().hex)

let bytearr: [UInt16] = [1,2]
print("Byte Arr: ", bytearr.serialize().hex)

let emptyb: [UInt16] = [1]
print("Empty Byte Arr: ", emptyb.serialize().hex)
let k: UInt32 = 4294967295
print(Data(k.serialize()).hex)


struct Simplestruct:Codable {
    var B: UInt32
    var A: UInt32
}


let encoder = JSONEncoder()
let decoder = JSONDecoder()
print(UInt32(3).serialize().hex,UInt16(2).serialize().hex,UInt16(1).serialize().hex)

let ss = Simplestruct(B:2, A:1)
let d = try! encoder.encode(ss)
print(String(data:d, encoding: .utf8)!)
let dec = try!decoder.decode(Simplestruct.self, from: d)

