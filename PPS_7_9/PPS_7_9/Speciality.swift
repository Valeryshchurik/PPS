//
//  File.swift
//  PPS_7_9
//
//  Created by Admin on 31.05.17.
//  Copyright (c) 2017 Popov. All rights reserved.
//

import Foundation

struct Speciality
{
    var code = Int32()
    var form = String()
    var name = String()
    var grades = [Int32:[SubjGrade]]()
    var sName = String()
    var cafedra = String()
    var plans = [Int32:Plan]()
}

struct SubjGrade
{
    var grade = Int32()
    var subj = String()
}

struct Plan {
    var free = Int32()
    var unfree = Int32()
}