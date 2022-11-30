//
//  ViewController.swift
//  Core Data
//
//  Created by Cesar Rojas on 11/23/22.
//

import UIKit

class musicViewController: UIViewController {
    
    var music: [Results] = []
    
    @IBOutlet weak var musicTableView: UITableView!
    
    var network: NetworkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
        self.network.getInfo(with: "https://rss.applemarketingtools.com/api/v2/mx/music/most-played/100/songs.json") { home in
            guard let home = home
            else { return }

            
            self.music.append(contentsOf: home.feed.results)
            DispatchQueue.main.async {
                self.musicTableView.reloadData()
                self.musicTableView.dataSource = self
            }
          self.setupUI()
        }
        
    }
    
    func setupUI() {
        

    }
}

extension musicViewController: UITableViewDataSource{
    
    
    
    
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
