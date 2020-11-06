//
//  ViewController.swift
//  Instagram
//
//  Created by shayan shokri on 11/2/20.
//  Copyright © 2020 SHAYI. All rights reserved.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated(){
        // check auth status
        if Auth.auth().currentUser == nil{
            // show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }


}

