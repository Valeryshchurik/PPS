//
//  DBManager.swift
//  PPS_7_9
//
//  Created by Admin on 31.05.17.
//  Copyright (c) 2017 Popov. All rights reserved.
//

import UIKit
import Foundation

class DBManager: NSObject {
    
    let path = "/Users/admin/Desktop/PPS_7_9/university.db"
    private var dbPointer = COpaquePointer()
    
    func connect()
    {
        if sqlite3_open(path, &dbPointer) == SQLITE_OK {
            print("Successfully opened connection to database at \(path)")
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
        }
    }
    
    func close()
    {
        sqlite3_close(dbPointer)
    }
    
    func getFacultys() -> [Faculty]
    {
        var arr = [Faculty]()
        connect()
        var queryStatementString = "SELECT Faculty.id, Faculty.address, Faculty.name, Faculty.site, Faculty.phone, Faculty.sName, Faculty.code, Head.name FROM Faculty INNER JOIN Head ON Head.faculty = Faculty.id;"
        
        var queryStatement: COpaquePointer = nil
        if sqlite3_prepare_v2(dbPointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                do
                {
                    var f = Faculty()
                    var id = sqlite3_column_int(queryStatement, 0)
                    f.address = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 1)))!
                    f.code = sqlite3_column_int(queryStatement, 6)
                    f.name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 2)))!
                    f.phone = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 4)))!
                    f.site = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 3)))!
                    f.sName = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 5)))!
                    f.specialities = getSpecialitiesFromFaculty(id)
                    f.cafedras = getCafedras(id)
                    f.head = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 7)))!
                    arr.append(f)
                } while sqlite3_step(queryStatement) == SQLITE_ROW
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        close()
        return arr
    }
    
    func getSpecialitiesFromFaculty(id: Int32) -> [Speciality]
    {
        var arr = [Speciality]()
        connect()
        var queryStatementString = "SELECT Speciality.id, Speciality.code, Form.name, Speciality.name, Speciality.sName, Cafedra.name FROM Speciality INNER JOIN Cafedra ON Cafedra.id = Speciality.cafedra INNER JOIN Form ON Form.id = Speciality.form WHERE Speciality.faculty = \(id);"
        
        var queryStatement: COpaquePointer = nil
        if sqlite3_prepare_v2(dbPointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                do
                {
                    var s = Speciality()
                    var ids = sqlite3_column_int(queryStatement, 0)
                    s.code = sqlite3_column_int(queryStatement, 1)
                    s.form = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 2)))!
                    s.sName = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 4)))!
                    s.name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 3)))!
                    s.cafedra = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 5)))!
                    s.grades = getGrades(ids)
                    s.plans = getPlans(ids)
                    arr.append(s)
                } while sqlite3_step(queryStatement) == SQLITE_ROW
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        close()
        return arr
    }
    
    func getGrades(id: Int32) -> [Int32:[SubjGrade]]
    {
        var arr = [Int32:[SubjGrade]]()
        connect()
        var queryStatementString = "SELECT Year.year, Subject.name, SubjGrade.grade FROM Year INNER JOIN SubjGrade ON SubjGrade.year = Year.id INNER JOIN Subject ON Subject.id = SubjGrade.subject WHERE SubjGrade.speciality = \(id);"
        
        var queryStatement: COpaquePointer = nil
        if sqlite3_prepare_v2(dbPointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                do
                {
                    var s = SubjGrade()
                    var year = sqlite3_column_int(queryStatement, 0)
                    s.subj = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 1)))!
                    s.grade = sqlite3_column_int(queryStatement, 2)
                    arr[year]?.append(s)
                } while sqlite3_step(queryStatement) == SQLITE_ROW
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        close()
        return arr
    }
    
    func getCafedras(id: Int32) -> [Cafedra]
    {
        var arr = [Cafedra]()
        connect()
        var queryStatementString = "SELECT Cafedra.id, Cafedra.address, Cafedra.code, Cafedra.name, Cafedra.phone, Cafedra.site, Cafedra.sName, CafedraHead.name FROM Cafedra INNER JOIN CafedraHead ON CafedraHead.cafedra = Cafedra.id WHERE faculty = \(id);"
        
        var queryStatement: COpaquePointer = nil
        if sqlite3_prepare_v2(dbPointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                do
                {
                    var s = Cafedra()
                    var ids = sqlite3_column_int(queryStatement, 0)
                    s.address = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 1)))!
                    s.code = sqlite3_column_int(queryStatement, 2)
                    s.name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 3)))!
                    s.phone = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 4)))!
                    s.site = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 5)))!
                    s.sName = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 6)))!
                    s.specialities = getSpecialitiesFromCafedra(ids)
                    s.head = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 7)))!
                    arr.append(s)
                } while sqlite3_step(queryStatement) == SQLITE_ROW
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        close()
        return arr
    }
    
    func getSpecialitiesFromCafedra(id: Int32) -> [Speciality]
    {
        var arr = [Speciality]()
        connect()
        var queryStatementString = "SELECT Speciality.id, Speciality.code, Form.name, Speciality.name, Speciality.sName, Cafedra.name FROM Speciality INNER JOIN Cafedra ON Cafedra.id = Speciality.cafedra INNER JOIN Form ON Form.id = Speciality.form WHERE Speciality.cafedra = \(id);"
        
        var queryStatement: COpaquePointer = nil
        if sqlite3_prepare_v2(dbPointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                do
                {
                    var s = Speciality()
                    var ids = sqlite3_column_int(queryStatement, 0)
                    s.code = sqlite3_column_int(queryStatement, 1)
                    s.form = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 2)))!
                    s.sName = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 4)))!
                    s.name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 3)))!
                    s.cafedra = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(queryStatement, 5)))!
                    s.grades = getGrades(ids)
                    s.plans = getPlans(ids)
                    arr.append(s)
                } while sqlite3_step(queryStatement) == SQLITE_ROW
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        close()
        return arr
    }
    
    func getPlans(id: Int32) -> [Int32:Plan]
    {
        var arr = [Int32:Plan]()
        connect()
        var queryStatementString = "SELECT Plan.free, Plan.unfree, Year.year FROM Plan INNER JOIN Year ON Year.id = Plan.year WHERE Plan.speciality = \(id);"
        
        var queryStatement: COpaquePointer = nil
        if sqlite3_prepare_v2(dbPointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                do
                {
                    var s = Plan()
                    s.free = sqlite3_column_int(queryStatement, 0)
                    s.unfree = sqlite3_column_int(queryStatement, 1)
                    var year = sqlite3_column_int(queryStatement, 2)
                    arr[year]? = s
                } while sqlite3_step(queryStatement) == SQLITE_ROW
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        close()
        return arr
    }
}
