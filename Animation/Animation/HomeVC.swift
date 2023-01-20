//
//  HomeVC.swift
//  Animation
//
//  Created by vishnu on 09/01/23.
//

import Foundation
import UIKit

class HomeVC : UIViewController {
    
    @IBAction func OpenAR(_ sender: Any) {
        performSegue(withIdentifier: "showARView", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
