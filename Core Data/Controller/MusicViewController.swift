//
//  ViewController.swift
//  Core Data
//
//  Created by Cesar Rojas on 11/23/22.
//

import UIKit

class musicViewController: UIViewController {
    
    var music: [Results] = []
    public var favs: [Results] = []
    
    @IBOutlet weak var musicTableView: UITableView!

    
    var network: NetworkManager = NetworkManager()
    
    var textToBeSend1 : String = ""
    var imageToBeSend1 : Data?
    var textToBeSend2 : String = ""
    var textToBeSend3 : String = ""
    var textTobeSend4 : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
        self.network.getInfo(with: "https://rss.applemarketingtools.com/api/v2/mx/music/most-played/100/albums.json") { home in
            guard let home = home
            else { return }

            
            self.music.append(contentsOf: home.feed.results)
            DispatchQueue.main.async {

                self.musicTableView.reloadData()
               
            }
          
        }
        
    }
    
    func setupUI() {
    
        self.musicTableView.dataSource = self
        self.musicTableView.delegate = self
    }
}

extension musicViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(music.count)
        return self.music.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.musicTableView.dequeueReusableCell(withIdentifier: "MusicTableCells", for: indexPath) as? MusicTableViewCell else {return UITableViewCell()}
        
        let mus = self.music[indexPath.row]
        
        //        cell.textLabel?.text = "Something"
        cell.Label1.text = "Artist: \(mus.artistName)"
        cell.Label2.text = "Song: \(mus.name)"
        print("\(mus.name)")
        
        
        let img = mus.artworkUrl100
        self.network.fetchImageData(path: (img)) { data in
            
            DispatchQueue.main.async {
                guard let data = data else {return}
                cell.Image1.image = UIImage(data: data)
                
            }
        }
        
        return cell
        
    }
}

extension musicViewController : UITableViewDelegate {
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("The selected path is \(indexPath.row)")
        
        let mus = self.music[indexPath.row]
        
        self.favs.append(mus)
        favsViewController().musics = self.favs
        favsViewController().musics.append(mus)
        print(favs.compactMap{$0.artistName})
        
        
        self.textToBeSend1 = mus.artistName
        self.textToBeSend2 = mus.name
        self.textToBeSend3 = mus.releaseDate
        self.textTobeSend4 = mus.genres[0].name
        
        let img = mus.artworkUrl100
        self.network.fetchImageData(path: (img)) { data in
            
            DispatchQueue.main.async {
                guard let data = data else {return}
                self.imageToBeSend1 = data
                self.performSegue(withIdentifier: "detailSegue", sender: self)
                
            }
            
        }

        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! MusicDetailViewController
        
        info.myString1 = textToBeSend1
        info.myString2 = textToBeSend2
        info.myString3 = textToBeSend3
        info.myString4 = textTobeSend4

        info.myImage1 = imageToBeSend1

        DispatchQueue.main.async {

            self.musicTableView.reloadData()
           
        }
        
        if segue.identifier == "favs" {
            //Obtenemos la referencia del siguiente view controller
            let controller2 = segue.destination as! favsViewController
            //Aqui pasas la variable de informaci??n al siguiente view controller
            controller2.musics = favs
        }
    }
    
}
