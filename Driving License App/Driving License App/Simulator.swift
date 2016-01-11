//
//  Simulator.swift
//  Driving License App
//
//  Created by Koba Kareli on 11/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import Foundation

class Simulator {
    private var category : String? = nil
    private var usedQuestions : Set<Question>
    
    init(category: String?) {
        self.category = category
        self.usedQuestions = Set<Question>()
    }
    
    func getNextQuestion() -> Question {
        // connect to database here
        let answers = ["Yes", "No", "Who knows?!", "Who cares?!"]
        if let cat = category {
            //return next question from the category ntil we ahve one that is not in the usedQuestions already
            let question = Question(imagename: "road", questionText: "Is this working?", answersArray: answers, correctAnswerIndex: 1, category: cat)
            while usedQuestions.contains(question) {
                //return another question
            }
            return question
        }
        else {
            //return random question
            let question = Question(imagename: "road", questionText: "Is this working?", answersArray: answers, correctAnswerIndex: 1, category: "Testing")
            while usedQuestions.contains(question) {
                //return another question
            }
            return question
        }
    }
}
