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
    
    func matchDirection() {
        guard nextToken() == Direction.Connection.rawValue else {
            print("Error: Could not match direction.")
            return
        }
    }
}

class Wire: Parser, CustomStringConvertible {
    var first_identifier: String?
    var second_identifier: String?
    var gate: Gate?
    var destination: String?
    var expression: String?
    
    var first_value: UInt16?
    var second_value: UInt16?
    var signal: UInt16?
    
    var description: String {
        get {
            return "\(first_identifier) \(gate) \(second_identifier) -> \(destination) == \(signal)"
        }
    }
    
    convenience init(expression: String) {
        self.init()
        
        self.expression = expression
        parseTokens(expression)
        token = nextToken()
        
        // Instruction Types
        // 1: number -> identifier
        // 2: identifier_1/number GATE identifier_2/number -> identifier_3
        // 3: NOT identifier_1 -> identifier_2
        
        if let token = token {
            if Gate(rawValue: token) == .NOT {
                // 3: NOT identifier_1 -> identifier_2
                self.gate = .NOT
                first_identifier = nextToken()
                matchDirection()
                destination = nextToken()
                
                //                print("\(token) \(identifier) -> \(destination)")
                
                if let id = first_identifier, signal = UInt16(id) {
                    self.signal = ~signal
                    //                    print("\(wires[destination])")
                }
            } else if tryMatchGate() {
                // 2: identifier_1/number GATE identifier_2/number -> identifier_3
                first_identifier = token
                gate = Gate(rawValue: nextToken())!
                second_identifier = nextToken()
                matchDirection()
                destination = nextToken()
                
                //                print("\(token) \(gate) \(identifier_2) -> \(destination)")
                
                if let signal = logic() {
                    self.signal = signal
                }
            } else {// if let number = Int16(token) {
                // 1: number -> identifier
                matchDirection()
                first_identifier = token// nextToken() // Do I need this?
                destination = nextToken()//first_identifier
                signal = signal(token)
                
                //                print("\(token) -> \(identifier)")
            }
        }
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
        if let signal = firstSignal() where gate == .NOT { // NOT
            return ~signal
        } else if let _ = firstSignal(), _ = secondSignal() { // x GATE y
            return logic()
        } else if let first = firstSignal() { // X -> D
            return first
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
    
    func evaluateSignal() {
        self.signal = evaluate()
    }
    
    func logic() -> UInt16? {
        if let gate = gate {
            if let left = signal(first_identifier), right = signal(second_identifier) {
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
            } else if let left = signal(first_identifier) where gate == .NOT {
                return ~left
            }
        }
        return nil
    }
    
    func signal(identifier: String?) -> UInt16? {
        if let id = identifier, signal = UInt16(id) {
            return signal
        }
        return nil
    }
}

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
    
    var wires: [String: UInt16] = [:]
    var incomplete: [String: Wire] = [:]
    
    override func part1() -> Any {
        let instructions = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        
        for instruction in instructions {
            parse(instruction)
        }
        
        for i in incomplete.keys {
            if let signal = evaluate(i) {
                wires[i] = signal
            }
        }
        
        return wires["a"]
    }

    override func part2() -> Any {
        let instructions = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        
        for instruction in instructions {
            parse(instruction)
        }
        
        incomplete["b"] = Wire(expression: "3176 -> b")
        
        for i in incomplete.keys {
            if let signal = evaluate(i) {
                wires[i] = signal
            }
        }
        
        return wires["a"]
    }
    
    override func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/Inputs/\(self.dynamicType)-Input")
    }
    
    func evaluate(id: String?) -> UInt16? {
        if let id = id, wire = incomplete[id] {
            if wire.signal == nil {
                
                if let first = evaluate(wire.first_identifier) {
                    wire.first_identifier = String(first)
                }
                
                if let second = evaluate(wire.second_identifier) {
                    wire.second_identifier = String(second)
                }

                wire.evaluateSignal()
            }
            
            if let signal = wire.signal {
                return signal
            }
        }
        return nil
    }
    
    func parse(instruction: String) {
        let wire = Wire(expression: instruction)
        if let destination = wire.destination {
            incomplete[destination] = wire
        }
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