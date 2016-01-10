//
//  TheoryPdfViewController.swift
//  Driving License App
//
//  Created by Tornike Mandzulashvili on 1/9/16.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class TheoryPdfViewController: UIViewController {
    var fileName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = fileName
        
        fileName = "Theory/" + fileName
        fileName = NSBundle.mainBundle().pathForResource(fileName, ofType: "pdf")!
        
        let url = NSURL.fileURLWithPath(fileName)
        self.webView.loadRequest(NSURLRequest(URL: url))
        self.webView.scalesPageToFit = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
