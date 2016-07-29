//
//  TacoViewController.swift
//  Taco_Stand
//
//  Created by Toleen Jaradat on 7/29/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

class TacoViewController: UIViewController {

    @IBOutlet weak var tacoImage: UIImageView!
    
    @IBOutlet weak var tacoTitleLabel: UILabel!
    
    @IBOutlet weak var tacoPriceLabel: UILabel!
    
    
    @IBOutlet weak var tacoNameLabel: UILabel!
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var taco = Taco()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tacoNameLabel.text = taco.name
        self.tacoTitleLabel.text = taco.name
        self.tacoPriceLabel.text = taco.price
        
        getTacoImage()

    }

    
    func getTacoImage(){
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) {
            
            
            if (self.taco.photo_url as NSString).containsString("http") {
                
                guard let imageURL = NSURL(string: self.taco.photo_url) else {
                    fatalError("Invalid URL")
                }
                
                
                let imageData = NSData(contentsOfURL: imageURL)
                
                let image = UIImage(data: imageData!)
                
                print(imageURL)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.tacoImage.image = image
                  
                })
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
