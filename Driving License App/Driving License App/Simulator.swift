//
//  Simulator.swift
//  Driving License App
//
//  Created by Koba Kareli on 11/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import CoreData
import Foundation
import UIKit

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
            let question = Question(imagename: "road", questionText: "Is this working?", answersArray: answers, correctAnswerIndex: 1, category: cat, explanation : "egrea ra")
            while usedQuestions.contains(question) {
                //return another question
            }
            return question
        }
        else {
            //1
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "Question")
            
            //3
            do {
                let results =
                try managedContext.executeFetchRequest(fetchRequest)
                let chosenQuestion = (results as! [NSManagedObject])[0]
                //return random question
                
                let imagename : String = chosenQuestion.valueForKey("imageName") as! String
                let explanation : String = chosenQuestion.valueForKey("explanation") as! String
                let questionText : String = chosenQuestion.valueForKey("question") as! String
                let correctAnswerIndex : Int = chosenQuestion.valueForKey("correctID") as! Int
                let category : String = chosenQuestion.valueForKey("category") as! String
                let numberOfAnswers : Int = chosenQuestion.valueForKey("numberOfAnswers") as! Int
                
                var answersArray : [String] = []
                for i in 1...numberOfAnswers {
                    answersArray.append(chosenQuestion.valueForKey("ans\(i)") as! String)
                }
                
                let question = Question(imagename: imagename, questionText: questionText, answersArray: answersArray, correctAnswerIndex: correctAnswerIndex, category: category, explanation : explanation)
                while usedQuestions.contains(question) {
                    //return another question
                }
                return question
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
                return getNextQuestion()
            }
            
            
        }
    }
}
