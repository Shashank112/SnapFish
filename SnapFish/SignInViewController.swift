//
//  SignInViewController.swift
//  SnapFish
//
//  Created by Mac Owner on 2/6/17.
//  Copyright © 2017 Shashank. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    @IBAction func turnupTapped(_ sender: UIButton) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            print("We tried to sign in")
            if error != nil {
                print("Hey we have an error:\(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                        
                        if error != nil {
                        print("Hey we have an error:\(error)")
                        } else {
                            print("Created User Successfully!")
                            
                            self.performSegue(withIdentifier: "signinsegue", sender: nil)
                            
                    }
                    
                })
                
                
            } else {
                print("Signed in Successfully!")
                
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
                
            }
            
            
        })
        
        
    }
    
    

}

