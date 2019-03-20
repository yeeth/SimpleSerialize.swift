import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SimpleSerialize_swiftTests.allTests),
    ]
}
#endif