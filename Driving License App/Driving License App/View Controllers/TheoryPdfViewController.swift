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
        loadPdf()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setCorrectPage()
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    private func loadPdf(){
        fileName = "Theory/" + fileName
        fileName = NSBundle.mainBundle().pathForResource(fileName, ofType: "pdf")!
        
        let url = NSURL.fileURLWithPath(fileName)
        self.webView.loadRequest(NSURLRequest(URL: url))
        self.webView.scalesPageToFit = true
    }
    
    private func setCorrectPage(){
        if NSUserDefaults.standardUserDefaults().objectForKey(fileName + "x") == nil {
            saveCurrentOffset()
        }
        let point : CGPoint = CGPoint(x: CGFloat((NSUserDefaults.standardUserDefaults().objectForKey(fileName + "x") as! Float)),
            y: CGFloat((NSUserDefaults.standardUserDefaults().objectForKey(fileName + "y") as! Float)))
        self.webView.scrollView.setContentOffset(point, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        saveCurrentOffset()
    }
    
    private func saveCurrentOffset(){
        NSUserDefaults.standardUserDefaults().setFloat(Float(self.webView.scrollView.contentOffset.y), forKey: fileName + "y")
        NSUserDefaults.standardUserDefaults().setFloat(Float(self.webView.scrollView.contentOffset.x), forKey: fileName + "x")
    }
    
}
