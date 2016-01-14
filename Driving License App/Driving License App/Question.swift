//
//  Question.swift
//  Driving License App
//
//  Created by Koba Kareli on 11/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import Foundation

class Question: Equatable, Hashable{
    
    private var imageName = ""
    private var question = "";
    private var answers = [String]()
    private var correctAnswerIndex = 0
    private var category = ""
    private var explanation = ""
    
    init(imagename : String, questionText: String, answersArray: [String], correctAnswerIndex : Int, category : String, explanation : String) {
        self.imageName = imagename
        self.question = questionText
        var ans = answersArray
        var s = Set<Int>()
        for var i = 0; i < ans.count; i++ {
            var indx = Int(arc4random_uniform(4))
            while(s.contains(indx)) {
                indx = Int(arc4random_uniform(4))
            }
            s.insert(indx)
            if indx == correctAnswerIndex-1 {
                self.correctAnswerIndex = i+1
            }
            self.answers.append(ans[indx])
        }
        self.category = category
        self.explanation = explanation
    }
    
    func getImageName() -> String {
        return imageName
    }
    
    func getQuestion() -> String {
        return question
    }
    
    func getAnswers() -> [String] {
        return answers
    }
    
    func getCorrectAnswerIndex() -> Int {
        return correctAnswerIndex
    }
    
    func getCategory() -> String {
        return category
    }
    
    func getExplanation() -> String {
        return explanation
    }
    
    var hashValue: Int {
        get {
            return self.question.hashValue
        }
    }
}

func ==(lhs: Question, rhs: Question) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
