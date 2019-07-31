//
//  ViewController.swift
//  colbatechDemo
//
//  Created by Amadeo on 29/07/2019.
//  Copyright © 2019 Amadeo. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onLoginClicked(_ sender: Any) {
        
        // Get the default UI object
        let authUI = FUIAuth.defaultAuthUI()
        
        // Ensure the user identifier is not nil
        guard authUI != nil else {
            // Log th Error
            return
        }
        
        // Set ourselves as delegate
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        // Get a reference to the Auth UI view controller
        let authViewController = authUI!.authViewController()
        
        // Show it
        present(authViewController, animated: true, completion: nil)    }
    
}

extension ViewController: FUIAuthDelegate {
    // Function for checking if the user is authenticated or not
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // Check if there was an error
        if error != nil {
            // Log error
            return
        }
        // If there was no error take user to Main view
        performSegue(withIdentifier: "goToMain", sender: self)
        
    }
}
