//
//  MusicDetailViewController.swift
//  Core Data
//
//  Created by Cesar Rojas on 11/29/22.
//

import UIKit

class MusicDetailViewController: UIViewController {
    
    var music2: [Results] = []
    var network: NetworkManager = NetworkManager()
    
    @IBOutlet weak var sLabel1: UILabel!
    @IBOutlet weak var sImage1: UIImageView!
    @IBOutlet weak var sLabel2: UILabel!
    @IBOutlet weak var sLabel3: UILabel!
    @IBOutlet weak var sLabel4: UILabel!
    
    var myString1: String? = ""
    var myImage1: Data?
    var myString2: String? = ""
    var myString3: String? = ""
    var myString4: String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sLabel1.text = myString1
        sImage1.image = UIImage(data : myImage1 ?? Data())
        sLabel2.text = myString2
        sLabel3.text = myString3
        sLabel4.text = myString4
        
    }
}
