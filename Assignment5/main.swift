//
//  main.swift
//  Assignment5
//
//  Created by H.Namikawa on 2023/03/21.
//

import Foundation

// How to read a file?
//let filename = "sample.in"
//if let contents = try? String(contentsOfFile: "/Users/park/Desktop/Assignment5/Assignment5/\(filename)") {
//  print(contents)
//}
//
//// How to write into a file?
//let outputFilename = "sample.out"
//let outputString = "Hello, World!"
//if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//  let fileURL = dir.appending(path: outputFilename)
//  do {
//    try outputString.write(to: fileURL, atomically: false, encoding: .utf8)
//    print("Sucessfully wrote into \(fileURL.absoluteString)")
//  } catch {
//    print(error.localizedDescription)
//  }
//}

while true {
  print("Input folder path where your student info file exists:")
  let folderPath = readLine() ?? ""
  print("")
  print("Input file name which you want to read:")
  let fileName = readLine() ?? ""
  print("")
  
  let studentReader = StudentReader(targetFolder: folderPath, targetFile: fileName)
  var result = studentReader.read()
  
  if !result {
    print("Input file path might be wrong! Please confirm it.")
    continue
  }
  
  result = studentReader.breakDownContents()
  
  if !result {
    print("Input file format might be wrong! Please confirm it.")
    continue
  }
  
  let students = studentReader.students
  
  if students.isEmpty {
    print("Couldn't read any student infomation! Please confirm it.")
  }
  
  print("Complete reading!!")
  
  while true {
    print("Input file name which you want to write:")
    let fileNameOutput = readLine() ?? ""
    
    let studentWriter =
      StudentWriter(targetFile: fileNameOutput, students: students)
    
    result = studentWriter.write()
    
    if !result {
      print("Writing was failed..... ")
      //continue
      break
    }
    print("Complete writing!!")
    break
  }
  break
}
