//
//  ViewController.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 28.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClick(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    @IBAction func signUpClik(_ sender: Any) {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
}

