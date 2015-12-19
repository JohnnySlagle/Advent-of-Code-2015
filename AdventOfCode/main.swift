//
//  main.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

print(">>>>>>>>>>>> Advent of Code <<<<<<<<<<<<<")

let days = [Day7.init()]
for day in days {
    print("\(day.self) –") // counter++
    print("\t Part 1: \(day.part1())")
    print("\t Part 2: \(day.part2())")
}

print(">@>o>o>0<<<0>>o<<<o<0<<@>@>*<o<<<*<<o>>o<")