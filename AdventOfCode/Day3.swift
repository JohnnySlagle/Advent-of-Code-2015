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

    // I'd like to learn why this isn't working
    func move(c: Character) {
        // http://stackoverflow.com/a/25103938/870028 "You can only pass a variable as the argument for an in-out parameter."
        var tempSanta = self
        switch c {
        case "^":
            ↑tempSanta
        case "v":
            ↓tempSanta
        case "<":
            ←tempSanta
        case ">":
            →tempSanta
        default:
            break
        }
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
        visited = [:]
        
        // Note: I don't like how I solved this, at all. I want something cleaner and more swifty
        let instructions = input()!
        let santa = Santa()
        
        visit(santa)
        for c in instructions.characters {
            santa.move(c)
            visit(santa)
        }

        // Count homes > 1 present
        return visited.filter { $1 >= 1 }.count
    }
    
    
    override func part2() -> Any {
        visited = [:]
        
        let instructions = input()!
        let santa = Santa(), robo_santa = Santa()
        var santasTurn = true
        
        visit(santa)
        visit(robo_santa)
        for c in instructions.characters {
            let realSanta = santasTurn ? santa : robo_santa

            realSanta.move(c)
            visit(realSanta)
            
            santasTurn = !santasTurn
        }
        
        // Count homes > 1 present
        return visited.filter { $1 >= 1 }.count
    }
}