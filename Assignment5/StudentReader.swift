//
//  StudentReader.swift
//  Assignment5
//
//  Created by H.Namikawa on 2023/03/21.
//

import Foundation

class StudentReader {
  private(set) var targetFolder:String
  private(set) var targetFile:String
  private(set) var contents = ""
  
  private(set) var numOfStudet = 0
  var students:[Student] = []
  
  init(targetFolder:String, targetFile: String) {
    self.targetFolder = targetFolder
    self.targetFile = targetFile
  }
  
  func read() -> Bool {
    var result = false
    if let contents = try? String(contentsOfFile: "\(targetFolder)/\(targetFile)") {
      self.contents = contents
      result = true
    }
    return result
  }
  
  func breakDownContents() -> Bool {
    if contents.isEmpty {
      return false
    }
    
    let eachLineContents = contents.split(separator: "\n")
    
    guard let numOfStudent:Int = Int(eachLineContents[0]) else {
      // error
      return false
    }
    self.numOfStudet = numOfStudent
    
    var lineNo = 1
    for _ in 0..<numOfStudent {
      // Name
      var line = eachLineContents[lineNo]
      let names = line.split(separator: ", ")
      let lastName = String(names[0])
      let firstName = String(names[1])
      lineNo += 1
      
      // Course, Grade
      line = eachLineContents[lineNo]
      var scores = line.split(separator: " ")
      let course = scores.remove(at: 0)
      lineNo += 1
      
      guard let _course = Course(rawValue: course.lowercased()) else {
        return false
      }
      
      let gradeCategories = GradeCategoryFactory.getGradeCategories(course: _course)
      
      if gradeCategories.count > scores.count {
        return false
      }
      
      var grades:[GradeCategory:Double] = [:]
      var index = 0
      for gradeCategory in gradeCategories {
        guard let score = Double(scores[index]) else {
          return false
        }
        
        grades[gradeCategory] = score
        index += 1
      }
             
      students.append(
        StudentFactory.getStudentInstance(
          course: _course, fistName: firstName, lastName: lastName, grades: grades))
    }
    
    return true
  }
}
