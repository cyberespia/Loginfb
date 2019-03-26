//
//  LogeadoViewController.swift
//  Loginfb
//
//  Created by Mario Burga on 3/17/19.
//  Copyright © 2019 mihost.com. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class LogeadoViewController: UIViewController {

    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("############# Se ha realizado la transición de pantalla. ############# ")
        returnUserDate()
        

        
    }
    

    @IBAction func salirBtn(_ sender: Any) {
        
        print("clicked!")
        
        salir()
        
    }
    
    func returnUserDate() {
        let graphPath = "me"
        let parameters = ["fields": "id, name, first_name, last_name, picture.type(large), email"]
        let graphRequest = FBSDKGraphRequest(graphPath: graphPath, parameters: parameters)
        
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let result = result as? [String: Any] else {
                    return
                }
                print("===== R ======")
                print(result)
                
                
                //Get user access token
                let token = FBSDKAccessToken.current()?.tokenString
                
                print("token: \(token!)")
                
                
                
                if let username = result["name"] as? String {
                    self.nombreLbl.text = username
                }
                
                if let email = result["email"] as? String {
                    self.emailLbl.text = email
                }
            }
        })
        connection.start()
        
    }
    
    
    func salir() {
        //self.dismiss(animated: true, completion: nil)
        FBSDKLoginManager().logOut()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)//instanciamos nuestro story
        
        let siguienteViewController = storyBoard.instantiateViewController(withIdentifier: "v1")
        
        self.present(siguienteViewController, animated: true, completion: nil)//mostrar nuestro viewcontroller
    }

}
