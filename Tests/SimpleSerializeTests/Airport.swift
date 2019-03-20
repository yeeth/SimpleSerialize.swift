struct Airport: Codable, Equatable {
    let B: UInt16
    let A: UInt8
    
    enum CodingKeys: Int, CodingKey {
        case B = 1
        case A = 2
    }

    static var example: Airport {
        return Airport(
            B: 2,
            A: 1

        )
    }
}
