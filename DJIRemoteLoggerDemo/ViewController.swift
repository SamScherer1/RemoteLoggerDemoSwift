//
//  ViewController.swift
//  DJIRemoteLoggerDemo
//
//  Created by Samuel Scherer on 5/9/21.
//  Copyright © 2021 DJI. All rights reserved.
//

import Foundation
import DJISDK


class ViewController: UIViewController, DJISDKManagerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DJISDKManager.registerApp(with: self)
    }
    
    func showAlertViewWith(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
//
    //MARK: - DJISDKManager Delegate Method
    func appRegisteredWithError(_ error: Error?) {
        var message = "Register App Successed!"
        if let _ = error {
            message = "Register App Failed! Please enter your App Key and check the network."
        } else {
            DJISDKManager.enableRemoteLogging(withDeviceID: "Enter Device ID Here", logServerURLString: "Enter URL Here")
        }
        self.showAlertViewWith(title: "Register App", message: message)
    }

    func productConnected(_ product: DJIBaseProduct?) {
        //If this demo is used in China, it's required to login to your DJI account to activate the application. Also you need to use DJI Go app to bind the aircraft to your DJI account. For more details, please check this demo's tutorial.
        DJISDKManager.userAccountManager().logIntoDJIUserAccount(withAuthorizationRequired: false) { (state:DJIUserAccountState, error:Error?) in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
            }
        }
    }

    //#MARK: - IBAction Method
    @IBAction func logSDKVersionButtonAction(_ sender: Any) {
        //        DJILogDebug(@"SDK Version: %@", [DJISDKManager SDKVersion]);
        
    }

    func didUpdateDatabaseDownloadProgress(_ progress: Progress) {
        print("didUpdateDatabaseDownloadProgress called")
    }
}
