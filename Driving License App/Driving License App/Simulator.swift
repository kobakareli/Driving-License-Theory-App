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
    private var counter : Int = 0
    private var numberOfQuestions : Int = 0
    private var returned_results : [NSManagedObject]? = nil
    
    init(category: String?) {
        self.category = category
        self.usedQuestions = Set<Question>()
        precalculate()
    }
    
    func getNumberOfQuestions() -> Int {
        return numberOfQuestions
    }
    
    func precalculate(){
        if category == nil {
            numberOfQuestions = 30
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Question")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category!)
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            returned_results = (results as! [NSManagedObject])
            numberOfQuestions = returned_results!.count
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getNextQuestion() -> Question? {
        var chosenQuestion : NSManagedObject?
        if category != nil {
            if counter >= returned_results?.count {
                print("Already returned all questions")
                return nil
            }
            chosenQuestion = returned_results![counter]
            counter++
        } else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Question")
            let id : Int32 = Int32(arc4random() % UInt32(QuestionConstants.numberOfQuestions) + 1)
            fetchRequest.predicate = NSPredicate(format: "questionID == %d", id)
            do {
                let results = try managedContext.executeFetchRequest(fetchRequest)
                if results.count > 0 {
                    chosenQuestion = (results as! [NSManagedObject])[0]
                }
                else {
                    chosenQuestion = nil
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
                return nil
            }
        }
        
        do {
            var question : Question? = nil
            if chosenQuestion != nil {
                let imagename : String = chosenQuestion!.valueForKey("imageName") as! String
                let explanation : String = chosenQuestion!.valueForKey("explanation") as! String
                let questionText : String = chosenQuestion!.valueForKey("question") as! String
                let correctAnswerIndex : Int = chosenQuestion!.valueForKey("correctID") as! Int
                let category : String = chosenQuestion!.valueForKey("category") as! String
                let numberOfAnswers : Int = chosenQuestion!.valueForKey("numberOfAnswers") as! Int
                
                var answersArray : [String] = []
                for i in 1...numberOfAnswers {
                    answersArray.append(chosenQuestion!.valueForKey("ans\(i)") as! String)
                }
                
                question = Question(imagename: imagename, questionText: questionText, answersArray: answersArray, correctAnswerIndex: correctAnswerIndex, category: category, explanation : explanation)
                
                while usedQuestions.contains(question!) {
                    //return another question
                    return question // TODO when we add many questions, then we will change it
                }
            }
            return question
        }
        
    }
}
