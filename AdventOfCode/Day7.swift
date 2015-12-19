//
//  Day6.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/17/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

class Wire {
    var identifier: String?
    var signal: Int16?
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
    
    var currentToken: String?
    var tokens: [String] = []
    var token: String?
    
    override func part1() -> Any {
        let instructions = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        
        for instruction in instructions {
            parse(instruction)
        }
        
        return 0
    }
    
    override func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/Inputs/\(self.dynamicType)-Tests")
    }
    
    func parse(instruction: String) {
        parseTokens(instruction)
        token = nextToken()
        
//        for i in 0..<tokens.count {
//            var token = tokens[i]
//
////            have a way to match a certain token or something...eg. match(Direction.Connection) or whatever
//            print(token)
        
        // There are four styles of instructions
        // 1: number -> identifier
        // 2: identifier_1/number GATE identifier_2/number -> identifier_3
        // 3: GATE identifier_1 -> identifier_2
        
        if let token = token {
            if let num = Int(token) {
                matchDirection()
                let identifier = nextToken()
                
                I'm gonna need a tryMatch or somethign so I can test to see what the layout is maybe? O rjust merge this if and the else together'
                
                print("\(num) -> \(identifier)")
            } else if let gate = Gate(rawValue: token) {
                let identifier = nextToken()
                matchDirection()
                let destination = nextToken()
                
                print("\(token) \(identifier) -> \(destination)")
            } else { // Assuming this is a alpha character
                let gate = nextToken()
                let identifier_2 = nextToken()
                matchDirection()
                let destination = nextToken()
                
                print("\(token) \(gate) \(identifier_2) -> \(destination)")
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
    
    func matchDirection() {
        guard nextToken() == Direction.Connection.rawValue else {
            print("Error: Could not match direction.")
            return
        }
    }
    
}

//            if let num = Int(token) {
//                print("Num \(num)")
//            } else if let gate = Gate(rawValue: token) {
//                print(gate)
//            } else if let direction = Direction(rawValue: token) {
//                print(direction)
//            }
