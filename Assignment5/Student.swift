//
//  Student.swift
//  Assignment5
//
//  Created by H.Namikawa on 2023/03/21.
//

import Foundation

class Student: CustomStringConvertible {
  
  private(set) var firstName:String
  private(set) var lastName:String
  private(set) var grades:[GradeCategory:Double]
  fileprivate(set) var course:Course
  fileprivate(set) var gradePropotions = GradeCategoryFactory.getGradeCategoryProportions(course:.general)
  
  init(firstName: String, lastName: String, grades:[GradeCategory:Double]) {
    self.firstName = firstName
    self.lastName = lastName
    self.grades = grades
    self.course = .general
  }
  
  var finalExamScore: Double {
    return grades[.finalExam] ?? 0
  }
  
  var finalAvgScore: Double{
    var avgScore:Double = 0
    
    for (category, grade) in grades {
      let propotion:Double = gradePropotions[category] ?? 0.0
      avgScore += grade * propotion
    }
    return round(avgScore * 100) / 100
  }
  
  var letterGrade: String {
    var letterGrade:String
    let avgScore = self.finalAvgScore
    if 90 < avgScore && avgScore <= 100 {
      letterGrade = "A"
    } else if 80 < avgScore && avgScore <= 90 {
      letterGrade = "B"
    } else if 70 < avgScore && avgScore <= 80 {
      letterGrade = "C"
    } else if 60 < avgScore && avgScore <= 70 {
      letterGrade = "D"
    } else {
      letterGrade = "F"
    }
    return letterGrade
  }
  
  // make String like below
  // Marvin Dipwart                            88      80.30   B
  var description: String{
    let SPACE_NAME = 42
    let SPACE_F_EXAM = 8
    let SPACE_F_AVG = 8
    
    var desc = ""
    // Name
    let fullName = firstName + " " + lastName
    desc.append(fullName)
    for _ in 0..<(SPACE_NAME - fullName.count) {
      desc.append(" ")
    }
    // Final Exam
    let finalExam = String(Int(self.finalExamScore))
    desc.append(finalExam)
    for _ in 0..<(SPACE_F_EXAM - finalExam.count) {
      desc.append(" ")
    }
    // Final Avg
    let finalAvg = String(self.finalAvgScore)
    desc.append(finalAvg)
    for _ in 0..<(SPACE_F_AVG - finalAvg.count) {
      desc.append(" ")
    }
    // Letter Grade
    let letterGrade = self.letterGrade
    desc.append(letterGrade)
    
    return desc
  }
}

class EnglishStudent: Student {
  override init(firstName: String, lastName: String, grades: [GradeCategory : Double]) {
    super.init(firstName: firstName, lastName: lastName, grades: grades)
    gradePropotions = GradeCategoryFactory.getGradeCategoryProportions(course:.english)
    course = .english
  }
}

class HistoryStudent: Student {
  override init(firstName: String, lastName: String, grades: [GradeCategory : Double]) {
    super.init(firstName: firstName, lastName: lastName, grades: grades)
    gradePropotions = GradeCategoryFactory.getGradeCategoryProportions(course:.history)
    course = .history
  }
}

class MathStudent: Student {
  override init(firstName: String, lastName: String, grades: [GradeCategory : Double]) {
    super.init(firstName: firstName, lastName: lastName, grades: grades)
    gradePropotions = GradeCategoryFactory.getGradeCategoryProportions(course:.math)
    course = .math
  }
}

class StudentFactory {
  static func getStudentInstance(
    course:Course, fistName:String, lastName:String, grades:[GradeCategory:Double]) -> Student {
      
    var student:Student
    switch course {
    case .english:
      student = EnglishStudent(firstName: fistName, lastName: lastName, grades: grades)
    case .history:
      student = HistoryStudent(firstName: fistName, lastName: lastName, grades: grades)
    case .math:
      student = MathStudent(firstName: fistName, lastName: lastName, grades: grades)
    case .general:
      student = Student(firstName: fistName, lastName: lastName, grades: grades)
    }
    return student
  }
}

enum Course: String {
  case general = "general" ,
       english = "english",
       history = "history",
       math = "math"
}

enum GradeCategory: String {
  case attendance = "attendance",
       termPaper = "termPaper",
       project = "project",
       quizAvg1 = "quizAvg1", quizAvg2 = "quizAvg2",
       quizAvg3 = "quizAvg3", quizAvg4 = "quizAvg4", quizAvg5 = "quizAvg5",
       test1 = "test1", test2 = "test2",
       midterm = "midterm",
       finalExam = "finalExam"
}

class GradeCategoryFactory {
  static func getGradeCategories(course:Course) -> [GradeCategory] {
    var gradeCategories:[GradeCategory] = []
    switch course {
    case .general:
      break
    case .english:
      gradeCategories.append(.termPaper)
      gradeCategories.append(.midterm)
      gradeCategories.append(.finalExam)
    case .history:
      gradeCategories.append(.attendance)
      gradeCategories.append(.project)
      gradeCategories.append(.midterm)
      gradeCategories.append(.finalExam)
    case .math:
      gradeCategories.append(.quizAvg1)
      gradeCategories.append(.quizAvg2)
      gradeCategories.append(.quizAvg3)
      gradeCategories.append(.quizAvg4)
      gradeCategories.append(.quizAvg5)
      gradeCategories.append(.test1)
      gradeCategories.append(.test2)
      gradeCategories.append(.finalExam)
    }
    return gradeCategories
  }
  
  static func getGradeCategoryProportions(course:Course) -> [GradeCategory:Double] {
    var gradeCategoryPropotions:[GradeCategory:Double] = [:]
    switch course {
    case .general:
      break
    case .english:
      gradeCategoryPropotions[.termPaper] = 0.25
      gradeCategoryPropotions[.midterm] = 0.35
      gradeCategoryPropotions[.finalExam] = 0.40
    case .history:
      gradeCategoryPropotions[.attendance] = 0.10
      gradeCategoryPropotions[.project] = 0.30
      gradeCategoryPropotions[.midterm] = 0.30
      gradeCategoryPropotions[.finalExam] = 0.30
    case .math:
      gradeCategoryPropotions[.quizAvg1] = 0.03
      gradeCategoryPropotions[.quizAvg2] = 0.03
      gradeCategoryPropotions[.quizAvg3] = 0.03
      gradeCategoryPropotions[.quizAvg4] = 0.03
      gradeCategoryPropotions[.quizAvg5] = 0.03
      gradeCategoryPropotions[.test1] = 0.25
      gradeCategoryPropotions[.test2] = 0.25
      gradeCategoryPropotions[.finalExam] = 0.35
    }
    return gradeCategoryPropotions
  }
}
