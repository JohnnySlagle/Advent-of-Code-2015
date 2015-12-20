//
//  Day6.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/17/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

class Parser {
    var currentToken: String?
    var tokens: [String] = []
    var token: String?

    func parseTokens(input: String) {
        tokens = input.componentsSeparatedByCharactersInSet(.whitespaceCharacterSet())
    }
    
    func nextToken() -> String {
        guard tokens.count > 0 else {
            return ""
        }
        return tokens.removeFirst()
    }
    
    func tryMatchGate() -> Bool {
        return (Gate(rawValue: tokens.first ?? "") != nil)
    }
}

class Wire: Parser {
    var first_identifier: String?
    var second_identifier: String?
    var gate: Gate?
//    var signal: UInt16?
    
    convenience init(expression: String) {
        self.init()
    }
    
    convenience init(left: String, gate: Gate, right: String) {
        self.init()
        self.first_identifier = left
        self.gate = gate
        self.second_identifier = right
    }
    
    convenience init(gate: Gate, identifier: String) {
        self.init()
        self.gate = gate
        self.first_identifier = identifier
    }
    
    func evaluate() -> UInt16? {
        if let signal = firstSignal() where gate == .NOT {
            return ~signal
        } else if let first = firstSignal(), second = secondSignal() {
            return logic(first, right: second)
        } else if let leftString = first_identifier, rightString = second_identifier {
            if let left = Wire(expression: leftString).evaluate(), right = Wire(expression: rightString).evaluate() {
                return logic(left, right: right)
            }
        }
        return nil
    }
    
    func firstSignal() -> UInt16? {
        if let id = first_identifier, signal = UInt16(id) {
            return signal
        }
        return nil
    }
    
    func secondSignal() -> UInt16? {
        if let id = second_identifier, signal = UInt16(id) {
            return signal
        }
        return nil
    }
    
    func logic(left: UInt16, right: UInt16) -> UInt16 {
        switch gate! {
        case .AND:
            return left & right
        case .OR:
            return left | right
        case .LSHIFT:
            return left << right
        case .RSHIFT:
            return left >> right
        default:
            // We shouldn't get here because x NOT y isn't a valid expression.
            return 0
        }
    }
}

//if let signal = UInt16(identifier) {
//    return signal
//}  else if let signal = wires[identifier] {
//    return UInt16(signal)
//}
//return nil

enum Gate: String {
    case NOT
    case AND
    case OR
    case LSHIFT
    case RSHIFT
}

enum Direction: String {
    case Connection = "->"
}

class Day7: Day {
    
    var currentToken: String?
    var tokens: [String] = []
    var token: String?
    //    var wires: [Wire] = []
    var wires: [String: UInt16] = [:]
    var incomplete: [String: Wire] = [:]
    
    override func part1() -> Any {
        let instructions = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        
        for instruction in instructions {
            parse(instruction)
        }
        
        print(wires)
        print(incomplete)
        
        evaluate("a")
        
        return 0
    }
    
    override func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/Inputs/\(self.dynamicType)-Input")
    }
    
    func evaluate(identifier: String) -> Int16 {
        
        return 0
    }
    
    func parse(instruction: String) {
        parseTokens(instruction)
        token = nextToken()
        
        // Instruction Types
        // 1: number -> identifier
        // 2: identifier_1/number GATE identifier_2/number -> identifier_3
        // 3: NOT identifier_1 -> identifier_2
        
        if let token = token {
            if Gate(rawValue: token) == .NOT {
                // 3: NOT identifier_1 -> identifier_2
                let identifier = nextToken()
                matchDirection()
                let destination = nextToken()
                
//                print("\(token) \(identifier) -> \(destination)")
                
                if let signal = signal(identifier) {
                    wires[destination] = ~signal
//                    print("\(wires[destination])")
                } else {
//                    incomplete[destination] = "\(Gate.NOT) \(identifier)"
                    incomplete[destination] = Wire(gate: .NOT, identifier: identifier)
                }
            } else if tryMatchGate() {
                // 2: identifier_1/number GATE identifier_2/number -> identifier_3
                let gate = Gate(rawValue: nextToken())!
                let identifier_2 = nextToken()
                matchDirection()
                let destination = nextToken()
                
//                print("\(token) \(gate) \(identifier_2) -> \(destination)")
                
                if let _ = signal(token), _ = signal(identifier_2) {
                    wires[destination] = execute(token, gate: gate, rightString: identifier_2)
                } else {
                    incomplete[destination] = Wire(left: token, gate: gate, right: identifier_2)
                }
            } else {
                // 1: number -> identifier
                matchDirection()
                let identifier = nextToken()
                
                wires[identifier] = signal(token)
                
//                print("\(token) -> \(identifier)")
            }
        }
    }
    
    func parseTokens(input: String) {
        tokens = input.componentsSeparatedByCharactersInSet(.whitespaceCharacterSet())
    }
    
    func nextToken() -> String {
        guard tokens.count > 0 else {
            return ""
        }
        return tokens.removeFirst()
    }
    
    func tryMatchGate() -> Bool {
        return (Gate(rawValue: tokens.first ?? "") != nil)
    }
    
    func matchDirection() {
        guard nextToken() == Direction.Connection.rawValue else {
            print("Error: Could not match direction.")
            return
        }
    }
    
    func execute(leftString: String, gate: Gate, rightString: String) -> UInt16? {
        if let left = signal(leftString), right = signal(rightString) {
            switch gate {
            case .AND:
                return left & right
            case .OR:
                return left | right
            case .LSHIFT:
                return left << right
            case .RSHIFT:
                return left >> right
            default:
                // We shouldn't get here because x NOT y isn't a valid expression.
                return nil
            }
        }
        return nil
    }
    
    func signal(identifier: String) -> UInt16? {
        if let signal = UInt16(identifier) {
            return signal
        }  else if let signal = wires[identifier] {
            return UInt16(signal)
        }
        return nil
    }
    
    func hasSignal(identifier: String) -> Bool {
        return (wires[identifier] != nil)
    }
}

//func parse(instruction: String) {
//    parseTokens(instruction)
//    token = nextToken()
//    
//    // Instruction Types
//    // 1: number -> identifier
//    // 2: identifier_1/number GATE identifier_2/number -> identifier_3
//    // 3: NOT identifier_1 -> identifier_2
//    
//    if let token = token {
//        if Gate(rawValue: token) == .NOT {
//            // 3: NOT identifier_1 -> identifier_2
//            let identifier = nextToken()
//            matchDirection()
//            let destination = nextToken()
//            
//            //                print("\(token) \(identifier) -> \(destination)")
//            
//            if let signal = signal(identifier) {
//                wires[destination] = ~signal
//                //                    print("\(wires[destination])")
//            } else {
//                //                    incomplete[destination] = "\(Gate.NOT) \(identifier)"
//                incomplete[destination] = Wire(gate: .NOT, identifier: identifier)
//            }
//        } else if tryMatchGate() {
//            // 2: identifier_1/number GATE identifier_2/number -> identifier_3
//            let gate = Gate(rawValue: nextToken())!
//            let identifier_2 = nextToken()
//            matchDirection()
//            let destination = nextToken()
//            
//            //                print("\(token) \(gate) \(identifier_2) -> \(destination)")
//            
//            if let _ = signal(token), _ = signal(identifier_2) {
//                wires[destination] = execute(token, gate: gate, rightString: identifier_2)
//            } else {
//                incomplete[destination] = Wire(left: token, gate: gate, right: identifier_2)
//            }
//        } else {
//            // 1: number -> identifier
//            matchDirection()
//            let identifier = nextToken()
//            
//            wires[identifier] = signal(token)
//            
//            //                print("\(token) -> \(identifier)")
//        }
//    }
//}