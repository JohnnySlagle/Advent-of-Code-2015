//
//  Day3.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

// MARK:- Custom Operators
prefix operator ↑ {}
prefix func ↑(inout house: Santa) -> Santa {
    house.y += 1
    return house
//    return House(x: house.x, y: house.y + 1)
}

prefix operator ↓ {}
prefix func ↓(inout house: Santa) -> Santa {
    house.y -= 1
    return house
//    return House(x: house.x, y: house.y - 1)
}

prefix operator ← {}
prefix func ←(inout house: Santa) -> Santa {
    house.x -= 1
    return house
//    return House(x: house.x - 1, y: house.y)
}

prefix operator → {}
prefix func →(inout house: Santa) -> Santa {
    house.x += 1
    return house
//    return House(x: house.x + 1, y: house.y)
}

// MARK:- Equatable
func ==(left: Santa, right: Santa) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

// Note: I am using NSObject to override now NSCountedSet equates and compares this class
class Santa: NSObject { // Equatable, Hashable {
    var x: Int = 0
    var y: Int = 0
    
    init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    override var hashValue: Int {
        return "(\(x), \(y))".hashValue
    }
    
    override var description: String {
        get {
            return "(\(x), \(y))"
        }
    }
    
    // Note: I am using this as the "key" because...I COULD NOT FIGURE OUT HOW TO MAKE MY CUSTOM CLASS EQUATABLE/HASHABLE. WTF
    func key() -> String {
        return "(\(x), \(y))"
    }
    
    override func copy() -> AnyObject {
        return Santa(x: x, y: y)
    }
}


class Day3: Day {
    
    var visited: [String: Int] = [:]
    
    func visit(house: Santa) {
        visited[house.key()] = ((visited[house.key()] ?? 0) + 1)
    }
    
    override func part1() -> Any {
        // Note: I don't like how I solved this, at all. I want something cleaner and more swifty
        let instructions = input()!
        var santa = Santa()
        
        visit(santa)
        for c in instructions.characters {
            // Move
            switch c {
            case "^":
                ↑santa
            case "v":
                ↓santa
            case "<":
                ←santa
            case ">":
                →santa
            default:
                break
            }
            visit(santa)
        }

        // Count homes > 1 present
        return visited.filter { $1 >= 1 }.count
    }
    
    override func part2() -> Any {
        // Note: I don't like how I solved this, at all. I want something cleaner and more swifty
        let instructions = input()!
        var santa = Santa()
        
        visit(santa)
        for c in instructions.characters {
            // Move
            switch c {
            case "^":
                ↑santa
            case "v":
                ↓santa
            case "<":
                ←santa
            case ">":
                →santa
            default:
                break
            }
            visit(santa)
        }
        
        // Count homes > 1 present
        return visited.filter { $1 >= 1 }.count
    }
}