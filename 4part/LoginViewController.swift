//
//  LoginViewController.swift
//  4part
//
//  Created by Fania on 24.01.2018.
//  Copyright © 2018 Fania. All rights reserved.
//

import UIKit
import Apollo
import CryptoSwift

class LoginViewController: UIViewController {
    
    let loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    var errorAlert: UIAlertController = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
    
    var preferences = UserDefaults.standard
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func emailDidEndEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
        password.becomeFirstResponder()
    }

    @IBAction func passwordDidEndEdititng(_ sender: UITextField) {
        sender.resignFirstResponder()
        self.onLogin(sender)
    }
    @IBAction func onTapRecognized(_ sender: Any) {
        login.resignFirstResponder()
        password.resignFirstResponder()
    }
    @IBAction func onLogin(_ sender: Any) {
        if (self.password.text! == "" || self.login.text! == "") {
            self.errorAlert.message = "Please type email and password";
            self.present(self.errorAlert, animated: true, completion: nil);
            return
        }
        self.onTapRecognized(sender)
        self.present(self.loadingAlert, animated: true, completion: nil)
        
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        
        let password: HashedPassword = HashedPassword(digest: self.password.text!.sha256(), algorithm: "sha-256")
        
        apollo.perform(mutation: LoginWithPasswordMutation(email: self.login.text!, password: password)){ result, error in
            if result!.errors != nil && result!.errors!.count > 0 {
                self.loadingAlert.dismiss(animated: false, completion: {
                    self.errorAlert.message = result!.errors![0].message;
                    self.present(self.errorAlert, animated: true, completion: nil);
                })
                return
            } else {
                self.login.text = "";
                self.password.text = "";
                self.preferences.set(result?.data?.loginWithPassword?.token, forKey: "token")
                self.loadingAlert.dismiss(animated: false, completion: {
                        self.navigationController?.pushViewController(homeViewController, animated: true)
                })
            }
        
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingAlert.view.addSubview(loadingIndicator)
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        //        let preferences = UserDefaults.standard
        
        if let token = preferences.string(forKey: "token") {
            self.present(self.loadingAlert, animated: true, completion: nil)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            apollo.fetch(query: MeQuery()) {
                result, error in
                if result!.data?.me != nil {
                    self.loadingAlert.dismiss(animated: false, completion: {
                        self.navigationController?.pushViewController(homeViewController, animated: true)
                    })
                } else {
                    self.loadingAlert.dismiss(animated: false, completion: nil)
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
