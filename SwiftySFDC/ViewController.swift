//
//  ViewController.swift
//  SwiftySFDC
//
//  Created by Sugam Kalra on 14/09/15.
//  Copyright (c) 2015 Sugam Kalra. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SFAuthenticationManagerDelegate {

    @IBOutlet weak var txtfSFUsername: UITextField!
    
    
    @IBOutlet weak var txtfSFPassword: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: "removeProgressView", name: "SFWebViewCancelNotification", object: nil)

    }

    
    
    
    @IBAction func btnLoginPressed(sender: AnyObject)
    {
        if txtfSFUsername.text!.characters.count == 0
        {
            let alertController: UIAlertController = UIAlertController(title: "Enter Username", message: "Please Enter Username", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style:.Default) { (action) -> Void in
                
            }
            
            alertController.addAction(cancelAction)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        else if txtfSFPassword.text!.characters.count == 0
        {
            let alertController: UIAlertController = UIAlertController(title: "Enter Password", message: "Please Enter Password", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style:.Default) { (action) -> Void in
                
            }
            
            alertController.addAction(cancelAction)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        else
        {
            JHProgressHUD.sharedHUD.showInView(self.view)
            
            
            SFAuthenticationManager.sharedManager().logout()
            
            var vc:AAACustomAuthViewController = AAACustomAuthViewController()
            
            vc.userName = txtfSFUsername.text
            vc.password = txtfSFPassword.text
            
            
            SFAuthenticationManager.sharedManager().authViewController = vc
            
            SFAuthenticationManager.sharedManager().addDelegate(self)
            
            
            SFAuthenticationManager.sharedManager().loginWithCompletion({ (info) -> Void in
                
                print(SFUserAccountManager.sharedInstance().currentUser)
                
                if SFUserAccountManager.sharedInstance().currentUser != nil
                {
                     var identityData:SFIdentityData?
                    
                    identityData = SFUserAccountManager.sharedInstance().currentUser.idData
                    
                    print(identityData)
                }

                
                }, failure: { (info, error) -> Void in
                    
                    JHProgressHUD.sharedHUD.hide()
                    
                    SFAuthenticationManager.sharedManager().logout()
            })
            
            

        }
    }
    
    
    func authManagerDidAuthenticate(manager: SFAuthenticationManager!, credentials: SFOAuthCredentials!, authInfo info: SFOAuthInfo!)
    {
        
        JHProgressHUD.sharedHUD.hide()

        
        print(SFAuthenticationManager.sharedManager().coordinator.credentials.instanceUrl)
        
        print(SFAuthenticationManager.sharedManager().coordinator.credentials.accessToken)
        
    }
    
    
    func removeProgressView()
    {
        JHProgressHUD.sharedHUD.hide()
        
    }


    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

