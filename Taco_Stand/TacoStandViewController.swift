//
//  TacoStandViewController.swift
//  Taco_Stand
//
//  Created by Toleen Jaradat on 7/26/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

class TacoStandViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tacos = [Taco]()
    var tacoDictionary: [String: [Taco]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor = UIColor(red: 4/255, green: 206/255, blue: 132/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = myColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        populateTacos()
    }
    
    override func viewDidAppear(animated: Bool) {
        populateTacos()
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddTacoViewControllerSegue"
        {
          guard segue.destinationViewController is AddTacoViewController
                
                else {
                    fatalError("Destination controller not found")
            }
            
        } else if segue.identifier == "TacoViewControllerSegue"
        
        {
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                fatalError("Invalid IndexPath")
            }
            
            let taco = self.tacos[indexPath.row]
            
            guard let tacoViewController = segue.destinationViewController as? TacoViewController else {
                fatalError("Destination controller not found")
            }
            
            tacoViewController.taco = taco
            
        }
        
    }

    
    private func populateTacos(){
        
        let tacoAPI = "https://taco-stand.herokuapp.com/api/tacos/"
        
        guard let url = NSURL(string: tacoAPI) else {
            
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url) { (data :NSData?, response :NSURLResponse?, error :NSError?) in
            
            let jsonTacosDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String: [AnyObject]]
            
            let  jsonTacosArray = jsonTacosDictionary["tacos"]
            
            for item in jsonTacosArray! {
                
                let taco = Taco()

                taco.name = item.valueForKey("name") as! String
                
                //Check for avaialble URL
                
                taco.photo_url = item.valueForKey("photo_url") as! String
                
                taco.price = item.valueForKey("price") as! String
                
                self.tacos.append(taco)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                
            })
            
            }.resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tacos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? TacoStandCell
        
        let taco = self.tacos[indexPath.row]
        
        if (taco.photo_url as NSString).containsString("http") {
            guard NSURL(string: taco.photo_url) != nil else {
                
                       fatalError("Invalid URL")
                      }
        }
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) {
            
            
            if (taco.photo_url as NSString).containsString("http") {

            guard let imageURL = NSURL(string: taco.photo_url) else {
                fatalError("Invalid URL")
            }
            
            
            let imageData = NSData(contentsOfURL: imageURL)
            
            let image = UIImage(data: imageData!)
            
            print(imageURL)
            
            dispatch_async(dispatch_get_main_queue(), {
            
                cell?.img.image = image
                cell?.price.text = taco.price
                cell?.title.text = taco.name
            })
            }
        }
        
        return cell!
    }

}
