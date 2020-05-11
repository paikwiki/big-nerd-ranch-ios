import UIKit

// 2.2. Using Standard Types
// =========================

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str
//constStr = "Hello, world"

// 2.2.2. Specifying types

var nextYear: Int = 0
var bodyTemp: Float = 0
var hasPet: Bool = true
var arrayOfInts: Array<Int> = []
var arrayOfStrings: [String] = []
//var dictionaryOfCapitalsByCountry: Dictionary<String, String> = [:]
var dictionaryOfCapitalsByCountry: [String: String] = [:]
var winningLotteryNumbers: Set<Int> = []

// 2.2.3. Literals and subscripting

let number = 42
let fmStatiion = 91.2

//let countingUp = ["one", "two"]
var countingUp = ["one", "two"] // change for 2.2.6. Instance methods
let secondElement = countingUp[1]

// 2.2.4. Initializers

let defaultNumber = Int()
let defaultBool = Bool()
let meanigOfLife = String(number)
let availableRooms = Set([205, 411, 412])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi: Float = 3.14

// 2.2.5. Properties

countingUp.count
let emptyString = String()
emptyString.isEmpty

// 2.2.6. Instance methods

countingUp.append("three")

// 2.3. Optionals
// ==============

var anOptionalFloat: Float?
var anOptionalArrayOfStrings: [String]?
var anOptionalArrayOfOptionalStrings: [String?]?

var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.8
reading2 = 9.2
//reading3 = 9.7

//let avgReading = (reading1 + reading2 + reading3) / 3 // Error
//let avgReading = (reading1! + reading2! + reading3!) / 3
if let r1 = reading1,
    let r2 = reading2,
    let r3 = reading3 {
        let avgReading = (r1 + r2 + r3) / 3
        print(avgReading)
} else {
    let errorString = "Instrument reported a reading that was nil."
    print(errorString)
}

// 2.3.1. Subsriptiong dictionaries

let nameByParkingSpace = [13: "Alice", 27: "Bob"]
//let space13Assignee: String? = nameByParkingSpace[13]
if let space13assignee = nameByParkingSpace[13] {
    print(space13assignee)
}
let space42Assignee: String? = nameByParkingSpace[42]

// 2.4. Loops and String Interpolation

let range = 0..<countingUp.count
for i in range {
    let string = countingUp[i]
    // Use 'string'
    print(string)
}

for (i, string) in countingUp.enumerated() {
    print(i, string)
}

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
    print(permit)
}

// 2.5. Enumeratoins and the Switch Statement

enum PieType: Int {
    case apple = 0
    case cherry
    case pecan
}
let favoritePie = PieType.apple
let name: String
switch favoritePie {
case .apple:
    name = "Apple"
case .cherry:
    name = "Cherry"
case .pecan:
    name = "Pecan"
}

let pieRwaValue = PieType.pecan.rawValue

if let pieType = PieType(rawValue: pieRwaValue) {
    // Got a valid 'pieType'!
    print(pieType)
}
// 2.6. Closures

let compareAscending = { (i: Int, j: Int) -> Bool in
    return i < j
}
compareAscending(42, 2)
compareAscending(-2, 12)

var numbers = [42, 9, 12, -17]
numbers.sort(by: compareAscending)
numbers.sort(by: { (i: Int, j: Int) -> Bool in
    return i < j
})
