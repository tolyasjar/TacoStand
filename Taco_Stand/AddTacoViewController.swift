//
//  AddTacoViewController.swift
//  Taco_Stand
//
//  Created by Toleen Jaradat on 7/26/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

class AddTacoViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var tacoNameFieldText: UITextField!

    @IBOutlet weak var tacoPriceFieldText: UITextField!
    
    @IBOutlet weak var tacoImgURL: UITextField!
    
    @IBAction func addMyTacoButtonPressed(sender: AnyObject) {
        
        
        let url = "https://taco-stand.herokuapp.com/api/tacos/"
        
        guard let apiURL = NSURL(string: url) else {
            fatalError("URL incorrect")
        }
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: apiURL)
        request.HTTPMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
      //  params = { taco: { name: "", price: "", photo_url: "" } }
        
        let parameters = ["taco":["name": self.tacoNameFieldText.text! ,"price": self.tacoPriceFieldText.text! ,"photo_url": self.tacoImgURL.text!]]
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
        
        session.dataTaskWithRequest(request) { (data :NSData?, response :NSURLResponse?, error: NSError?) in
        
            print("finished")
            
            }.resume()
                
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tacoNameFieldText.delegate = self
        self.tacoPriceFieldText.delegate = self
        self.tacoImgURL.delegate = self

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
