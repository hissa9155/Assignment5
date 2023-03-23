//
//  StudentWriter.swift
//  Assignment5
//
//  Created by H.Namikawa on 2023/03/21.
//

import Foundation

class StudentWriter {
  //private(set) var targetFolder:String
  private(set) var targetFile:String
  private(set) var students:[Student]
  
  init(targetFile: String, students:[Student]) {
    //self.targetFolder = targetFolder
    self.targetFile = targetFile
    self.students = students
  }
  
  func write() -> Bool {
    guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return false
    }
    let fileURL = dir.appending(path: targetFile)
    
    var outputString = ""
    
    outputString.append("Student Grade Summary\n")
    outputString.append("---------------------\n")
    outputString.append("\n")
    
    outputString = writeCategorySummary(outputString, .english)
    outputString.append("\n")
    outputString.append("\n")
    outputString = writeCategorySummary(outputString, .history)
    outputString.append("\n")
    outputString.append("\n")
    outputString = writeCategorySummary(outputString, .math)
    outputString.append("\n")
    outputString.append("\n")
    
    outputString = writeOverAllGradeDistribution(outputString)
    
    do {
      try outputString.write(to: fileURL, atomically: false, encoding: .utf8)
      print("Sucessfully wrote into \(fileURL.absoluteString)")
      return true
    } catch {
      return false
    }
  }
  
  private func writeCategorySummary(_ str:String, _ course:Course) -> String{
    var _str = str
    _str = writeCategorySummaryTitle(_str, course)
    _str.append("\n")
    _str.append("\n")
    _str = writeStudentTableTitle(_str)
    _str.append("\n")
    _str = writeStudentTableTitleSeparator(_str)
    _str.append("\n")
    
    let tgtStudents = students.filter{ $0.course == course }
    
    for student in tgtStudents {
      _str.append(student.description)
      _str.append("\n")
    }
    
    return _str
  }
  
  private func writeCategorySummaryTitle(_ str:String, _ course:Course) -> String {
    var _str = str
    switch course {
    case .english:
      _str.append("ENGLISH CLASS")
    case .history:
      _str.append("HISTORY CLASS")
    case .math:
      _str.append("MATH CLASS")
    case .general:
      _str.append("CLASS")
    }
    return _str
  }
  
  private func writeStudentTableTitle(_ str:String) -> String {
    let SPACE_NAME = 42
    let SPACE_F_EXAM = 8
    let SPACE_F_AVG = 8
    
    let COL1_TITLE_1 = "Student"
    let COL1_TITLE_2 = "Name"
    let COL2_TITLE_1 = "Final"
    let COL2_TITLE_2 = "Exam"
    let COL3_TITLE_1 = "Final"
    let COL3_TITLE_2 = "Avg"
    let COL4_TITLE_1 = "Letter"
    let COL4_TITLE_2 = "Grade"
    
    var _str = str
    
    var row1Title = ""
    // Student Name
    row1Title.append(COL1_TITLE_1)
    // Space
    for _ in 0..<(SPACE_NAME - COL1_TITLE_1.count){
      row1Title.append(" ")
    }
    // Final Exam
    row1Title.append(COL2_TITLE_1)
    // Space
    for _ in 0..<(SPACE_F_EXAM - COL2_TITLE_1.count){
      row1Title.append(" ")
    }
    // Final Avg
    row1Title.append(COL3_TITLE_1)
    // Space
    for _ in 0..<(SPACE_F_AVG - COL3_TITLE_1.count){
      row1Title.append(" ")
    }
    // Leter Grade
    row1Title.append(COL4_TITLE_1)
    
    var row2Title = ""
    // Student Name
    row2Title.append(COL1_TITLE_2)
    // Space
    for _ in 0..<(SPACE_NAME - COL1_TITLE_2.count){
      row2Title.append(" ")
    }
    // Final Exam
    row2Title.append(COL2_TITLE_2)
    // Space
    for _ in 0..<(SPACE_F_EXAM - COL2_TITLE_2.count){
      row2Title.append(" ")
    }
    // Final Avg
    row2Title.append(COL3_TITLE_2)
    // Space
    for _ in 0..<(SPACE_F_AVG - COL3_TITLE_2.count){
      row2Title.append(" ")
    }
    // Leter Grade
    row2Title.append(COL4_TITLE_2)
    
    _str.append(row1Title)
    _str.append("\n")
    _str.append(row2Title)
    
    return _str
  }
  
  private func writeStudentTableTitleSeparator(_ str:String) -> String {
    var _str = str
    _str.append("----------------------------------------------------------------")
    return _str
  }
  
  private func writeOverAllGradeDistribution(_ str:String) -> String {
    var _str = str
    _str.append("OVERALL GRADE DISTRIBUTION")
    _str.append("\n")
    _str.append("\n")
    
    let countA = students.filter{ $0.letterGrade == "A" }.count
    let countB = students.filter{ $0.letterGrade == "B" }.count
    let countC = students.filter{ $0.letterGrade == "C" }.count
    let countD = students.filter{ $0.letterGrade == "D" }.count
    let countF = students.filter{ $0.letterGrade == "F" }.count
    
    let SPACE_COUNT = 3
    _str.append("A:")
    for _ in 0..<(SPACE_COUNT - String(countA).count){
      _str.append(" ")
    }
    _str.append(String(countA) + "\n")
    _str.append("B:")
    for _ in 0..<(SPACE_COUNT - String(countB).count){
      _str.append(" ")
    }
    _str.append(String(countB) + "\n")
    _str.append("C:")
    for _ in 0..<(SPACE_COUNT - String(countC).count){
      _str.append(" ")
    }
    _str.append(String(countC) + "\n")
    _str.append("D:")
    for _ in 0..<(SPACE_COUNT - String(countD).count){
      _str.append(" ")
    }
    _str.append(String(countD) + "\n")
    _str.append("F:")
    for _ in 0..<(SPACE_COUNT - String(countF).count){
      _str.append(" ")
    }
    _str.append(String(countF) + "\n")
    
    return _str
  }
  
}
