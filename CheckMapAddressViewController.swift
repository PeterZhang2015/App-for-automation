//
//  CheckMapAddressViewController.swift
//  App for automation
//
//  Created by Chongzheng Zhang on 2/27/18.
//  Copyright © 2018 Chongzheng Zhang. All rights reserved.
//

import UIKit

class CheckMapAddressViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var checking_address: UITextField!
    
    @IBOutlet var check_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.checking_address.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "checkAddress" {
            if let toViewController = segue.destination as? UIMapAddressCheckingViewController {
                toViewController.checking_address = self.checking_address.text!
            }
        }
        
        if segue.identifier == "checkRoute" {
            if let toViewController = segue.destination as? UIMapRouteCheckingViewController {
                toViewController.checking_address = self.checking_address.text!
            }
        }
        

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
