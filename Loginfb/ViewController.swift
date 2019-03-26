//
//  ViewController.swift
//  Loginfb
//
//  Created by Mario Burga on 3/15/19.
//  Copyright © 2019 mihost.com. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    var dict : [String : AnyObject]!//array para recibir los datos del usuario
    
    @IBOutlet weak var estatusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let btnFBLogin = FBSDKLoginButton()
//        btnFBLogin.readPermissions = ["public_profile", "email", "user_friends"]
//        btnFBLogin.delegate = self
//
//        btnFBLogin.center = self.view.center
//        self.view.addSubview(btnFBLogin)
        
        if FBSDKAccessToken.current() != nil {
            
            self.estatusLbl.text = "Usuario Logeado"
            
     
        } else {
            
            self.estatusLbl.text = "== No Logeado =="
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // Comprueba si ya has iniciado sesión
        if let _ = FBSDKAccessToken.current() {
            // Migración de pantalla
            // performSegue (withIdentifier: "modalTop", sender: self)
            print("--- Estoy conectado ---")
            segueToSeccondViewController()
        } else {
            // Instalar el botón de inicio de sesión de FB
            let fbLoginBtn = FBSDKLoginButton()
            fbLoginBtn.readPermissions = ["public_profile", "email"]
            fbLoginBtn.center = self.view.center
            fbLoginBtn.delegate = self
            self.view.addSubview(fbLoginBtn)
        }
    }
    
    
    // Migración de pantalla
    func segueToSeccondViewController() {
        //self.performSegue(withIdentifier: "v2", sender: nil)
        
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "v2", sender: nil)
        }
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            
            self.estatusLbl.text = error.localizedDescription
        }
        else if result.isCancelled{
            
             self.estatusLbl.text = "Usuario canceló login"
        }
        
        else {
            
            //login satisfactorio
            
             self.estatusLbl.text = "Usuario Logeado"
            
            
            segueToSeccondViewController()
            
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        self.estatusLbl.text = "Usuario desconectado"
        
    }


}

