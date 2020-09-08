//
//  MediaFinderVC.swift
//  first ios project
//
//  Created by IOS on 9/6/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import SDWebImage

class MediaFinderVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResult: UITableView!
    @IBOutlet weak var mediaTable: UITableView!
    
    
    var mediaArray : [Media] = []
    var mediaType = MediaType.movie
    var criteria : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultManager.shared().isLoggedIn = true
        
        self.navigationItem.title = "Media Finder"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(rightHandAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(lefttHandAction))
        
        mediaTable.register(UINib(nibName: "MediaCell", bundle: nil), forCellReuseIdentifier: "MediaCell")
        
        
        mediaTable.dataSource = self
        mediaTable.delegate = self
        searchBar.delegate = self
    }
    
    @IBAction func mediaTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mediaType = .movie
            getMedia()
        }
        else if sender.selectedSegmentIndex == 1 {
            mediaType = .music
            getMedia()
        }
        else {
            mediaType = .tvShow
            getMedia()
        }
    }
    
    
    private func getMedia() {
        APIManager.loadMedia(mediaType: mediaType.rawValue, criteria: criteria! ) { (error , media) in
            if let error = error {
                print(error)
            }
            else if let media = media {
                self.mediaArray = media
                self.mediaTable.reloadData()
                
            }
        }
    }
    
    @objc
    func rightHandAction() {
        let ProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        navigationController?.pushViewController(ProfileVC, animated: true)
    }
    
    @objc
    func lefttHandAction() {
        let LoginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(LoginVC, animated: true)
    }

    
    
}

extension MediaFinderVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmed = searchText.trimmingCharacters(in: .whitespaces)
        if trimmed != "" {
            criteria = searchText
            getMedia()
            mediaTable.isHidden = false
            }
        }
    }


extension MediaFinderVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mediaTable.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as? MediaCell
            else{
                return UITableViewCell()
        }
        
        let image = mediaArray[indexPath.row].artworkUrl100
        cell.mediaArtWork.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "movie placeholder.png"))
        
        if mediaType == .tvShow {
            cell.mediaName.text = mediaArray[indexPath.row].artistName
            cell.mediaDescription.text = mediaArray[indexPath.row].longDescription
        }
        else if mediaType == .music{
            cell.mediaName.text = mediaArray[indexPath.row].trackName
            cell.mediaDescription.text = mediaArray[indexPath.row].artistName
        }
        else {
            cell.mediaName.text = mediaArray[indexPath.row].trackName
            cell.mediaDescription.text = mediaArray[indexPath.row].longDescription
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}





/*
 import UIKit
 import SDWebImage
 
 class MoviesVC: UIViewController {
 
 //outllets
 @IBOutlet weak var moviesTable: UITableView!
 
 //variables
 var moviesArray : [Movies] = []
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 UserDefaultManager.shared().isLoggedIn = true
 
 self.navigationItem.hidesBackButton = true
 self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(rightHandAction))
 self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(lefttHandAction))
 
 moviesTable.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
 
 moviesTable.dataSource = self
 moviesTable.delegate = self
 
 getData()
 
 }
 
 private func getData() {
 
 APIManager.loadMovies{ (error, movies) in
 if let error = error {
 print(error)
 } else if let movies = movies {
 //print(movies.first?.title)
 self.moviesArray = movies
 self.moviesTable.reloadData()
 
 }
 }
 }
 
 

 }
 
 extension MoviesVC : UITableViewDataSource, UITableViewDelegate
 {
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return moviesArray.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 guard let cell = moviesTable.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
 else{
 return UITableViewCell()
 }
 
 let image = moviesArray[indexPath.row].image
 
 //let image = UIImage(imageLiteralResourceName: moviesArray[indexPath.row].image)
 
 //imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
 
 cell.movieImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "movie placeholder.png"))
 
 //cell.movieImage.image = image
 cell.movieNameLbl.text = moviesArray[indexPath.row].title
 cell.movieTypeLbl.text = moviesArray[indexPath.row].genre[0]
 cell.moviesReleasedLbl.text = String(moviesArray[indexPath.row].releaseYear)
 cell.movieRatingLbl.text = String(moviesArray[indexPath.row].rating)
 return cell
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return 120
 }
 
 
 }
*/
