//
//  AppDelegate.swift
//  Driving License App
//
//  Created by Koba Kareli on 07/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var managedObjectContext: NSManagedObjectContext
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("QuestionModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
            This code uses a file named "DataModel.sqlite" in the application's documents directory.
            */
            let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }

    var window: UIWindow?
    
    
    func saveQuestion(ans1 : String, ans2 : String, ans3 : String,
        ans4 : String, category : String, correctID : Int,
        explanation : String, imageName : String,
        numberOfAnswers : Int, questionn : String, questionID : Int){
            
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Question",
            inManagedObjectContext:managedContext)
        
        let question = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        question.setValue(ans1, forKey: "ans1")
        question.setValue(ans2, forKey: "ans2")
        question.setValue(ans3, forKey: "ans3")
        question.setValue(ans4, forKey: "ans4")
        question.setValue(category, forKey: "category")
        question.setValue(correctID, forKey: "correctID")
        question.setValue(explanation, forKey: "explanation")
        question.setValue(imageName, forKey: "imageName")
        question.setValue(numberOfAnswers, forKey: "numberOfAnswers")
        question.setValue(questionn, forKey: "question")
        question.setValue(questionID, forKey: "questionID")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //// I will use this place to fill core data with questions.
        //// This is not permanent, just to make it ready for the user, then we will delete it
        ///////
        
        saveQuestion("ki", ans2: "albat", ans3: "ravi shen?", ans4: "ar var aqauri", category: "პრიორიტეტის ნიშნები", correctID: 4, explanation: "geubnebi raa", imageName: "road2", numberOfAnswers: 4, questionn: "ra sargebloba moaqvs mamals?", questionID: 1)
        
        ///////
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

