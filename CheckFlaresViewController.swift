//
//  CheckFlaresViewController.swift
//  Breaker19
//
//  Created by Joshua Yancey on 23/11/2015.
//  Copyright (c) 2015 Joshua Yancey. All rights reserved.
//

import UIKit
import GoogleMobileAds


//USING A GLOBAL BECAUSE A) LAZINESS. B) NOT DANGEROUS BECAUSE THIS APP IS SMALL
var radiusSearch = NSString()


class CheckFlaresViewController: UIViewController {
    
    
    //DON'T FORGET TO CAST TO INT FOR THIS. NEED INTO FOR THE QUERY
    var point:PFGeoPoint = PFGeoPoint()
    var miles:Double = 1.0
    
    
    
    
    //HAVE TO DO THESE EMPTy SO DOESN'T MESS UP ARRAY COUNT STUFF
    var titles = [String]()
    var date = [String]()
    var descriptions = [String]()
    
    
    
    
    
    
    @IBAction func selectRadBTN(sender: AnyObject) {
        
        
    }
    

    @IBOutlet weak var bannerView: GADBannerView!
    
    
    @IBOutlet weak var radSelectedLBL: UILabel! = UILabel()

    
    
    
    @IBOutlet weak var ScrollView: UIScrollView! = UIScrollView()
    
    

    
    @IBAction func checkFlareBTN(sender: AnyObject) {
        
        //GET THE INT FROM THE RADIUS STRING TO SEND TO PARSE
        self.miles = (radiusSearch).doubleValue
        
        
        
        //RUN THE PARSE QUERY TO FIND FLARES WITHIN THE SPECIFIED RADIUS
        var query = PFQuery(className: "Flares")
        query.whereKey("location", nearGeoPoint: self.point, withinMiles: self.miles)
        
        
        //NEWEST ENTRIES AT THE TOP
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            
            
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            
            if error == nil {
                
                
                //GOT SOMETHING
                NSLog("Successfully retrieved \(objects.count) items.")
                
                
                //ALERT MESSAGE FOR NO RESULTS HERE.
                if objects.count == 0 {
                    
                    var error = ""
                    
                    self.displayAlert("No Flares in your area.", error: "Stay safe out there.")
                    
                    
                }
                
                
                if let users = objects  {
                    
                    //EMPTYING EVERYTHING
                    self.date.removeAll(keepCapacity: true)
                    self.titles.removeAll(keepCapacity: true)
                    self.descriptions.removeAll(keepCapacity: true)
                    
                    
                    
                    // Do something with the found objects
                    for object in objects {
                        
                        
                        
                        //THIS KEEPS YOU FROM SEEING YOURSELF IN RESULTS
                        if object.username != PFUser.currentUser().username {
                            
                            
                            //THIS IS JUST TO FORMAT THE PARSE DATE OBJECT TO STRING FOR READABILITY
                            var created = object.createdAt as NSDate
                            var dateFormat = NSDateFormatter()
                            dateFormat.dateFormat = "MMM dd, YYYY"
                            
                            var dateString = NSString(format: "%@", dateFormat.stringFromDate(created))
                            
                            
                            //THEN ADD THAT FORMATTED STRING TO THE DATE ARRAY ABOVE
                            self.date.append(dateString)
                            
                            //UPDATE ARRAYS WITH INFO FROM PARSE
                            self.titles.append(object["Title"] as String)
                            self.descriptions.append(object["Description"] as String)

                            
                            NSLog("%@", object.objectId)
                        }
                        
                    }
                    
                    
                }
                
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
        }
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //GOOGLE AD STUFF HERE. BLOCK 1 OF 1
        self.bannerView.adUnitID = "UNLOCK FOR RELEASE"
        self.bannerView.rootViewController = self
        var request: GADRequest = GADRequest()
        self.bannerView.loadRequest(request)
        
        
        //SET INITIAL VALUE TO 1 FOR RADIUS OF SEARCH
        radiusSearch = "1"
        
        
        
        
        //SETTING THE BG IMAGE TO CUSTOM IMAGE
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "breaker19BG.png")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
        
        
        //SET THE SCROLL HEIGHT. 1000 WORKS PRETTY WELL.
        ScrollView.contentSize.height = 1000
        

    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        //SET LABEL TO SELECTED RADIUS ONCE VIEW REAPPEARS FROM SELECTION VIEW
        radSelectedLBL.text = radiusSearch

        
        
    }
    
    
    
    
    //ALERT DISPLAY FUNCTION
    func displayAlert(title:String, error:String){
        var alert = UIAlertController(title: title, message:error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok.", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
