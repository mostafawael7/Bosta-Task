//
//  ViewController.swift
//  Bosta Task
//
//  Created by Hendawi on 01/12/2024.
//

import UIKit
import Moya

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<NetworkManager>()
        provider.request(.getUser(id: 1)) { result in
            switch result {
            case .success(let response):
                print(response)
                do {
                    // Decode the JSON into the User model
                    let user = try JSONDecoder().decode(User.self, from: response.data)
                    print("User: \(user)")
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

