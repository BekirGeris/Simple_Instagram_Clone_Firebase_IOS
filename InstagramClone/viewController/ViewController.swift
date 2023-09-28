//
//  ViewController.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 28.09.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController{

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            self.performSegue(withIdentifier: "toHome", sender: nil)
        }
    }

    @IBAction func signInClick(_ sender: Any) {
        validEmailAndPassword {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if error == nil {
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                } else {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    @IBAction func signUpClik(_ sender: Any) {
        validEmailAndPassword {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if error == nil {
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                } else {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func validEmailAndPassword(validet: () -> Void) {
        if emailText.text != "" && passwordText.text != "" {
            validet()
        } else {
            makeAlert(title: "Eror", message: "Email or Password is failed")
        }
    }
}

