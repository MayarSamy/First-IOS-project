//
//  MediaFinderVC.swift
//  first ios project
//
//  Created by IOS on 9/6/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class MediaFinderVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResult: UITableView!
    @IBOutlet weak var mediaTable: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var mediaArray : [Media] = []
    var mediaType = UserDefaultManager.shared().mediaType
    var criteria : String = ""
    let email = UserDefaultManager.shared().email
    
    var playerVC = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultManager.shared().isLoggedIn = true
        priviousdata()
        
        self.navigationItem.title = "Media Finder"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(rightHandAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(lefttHandAction))
        
        mediaTable.register(UINib(nibName: "MediaCell", bundle: nil), forCellReuseIdentifier: "MediaCell")
        
        mediaTable.dataSource = self
        mediaTable.delegate = self
        searchBar.delegate = self
        
        setupSegment()
    }
    
    @IBAction func mediaTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mediaType = .movie
            UserDefaultManager.shared().mediaType = .movie
            getMedia()
        }
        else if sender.selectedSegmentIndex == 1 {
            mediaType = .music
            UserDefaultManager.shared().mediaType = .music
            getMedia()
        }
        else {
            mediaType = .tvShow
            UserDefaultManager.shared().mediaType = .tvShow
            getMedia()
        }
    }
    
    private func setupSegment(){
        switch mediaType {
        case .movie:
            segment.selectedSegmentIndex = 0
        case .music:
            segment.selectedSegmentIndex = 1
        case .tvShow:
            segment.selectedSegmentIndex = 2
        }
    }
    
    private func priviousdata() {
        mediaArray = SQLManager.shared().retriveMedia(userMail: email)
            if mediaArray.isEmpty == false {
                mediaTable.isHidden = false
                mediaTable.reloadData()
            }
    }
    
    private func getMedia() {
        SQLManager.shared().createSearchedTable()
        SQLManager.shared().droppingSearchedMedia(userMail: email)
        APIManager.loadMedia(mediaType: mediaType.rawValue, criteria: criteria ) { (error , media) in
            if let error = error {
                print(error)
            }
            else if let media = media {
                self.mediaArray = media
                for medias in self.mediaArray {
                    let artWork = medias.artworkUrl100
                    let previewUrl = medias.previewUrl
                    let artistName = medias.artistName
                    let trackName = medias.trackName
                    
                    if medias.kind == "song" {
                        SQLManager.shared().insertMedia(userEmail: self.email, artworkUrl: artWork, artistName: artistName!, trackName: trackName, longDescription: nil, previewUrl: previewUrl, kind: medias.kind!)
                    } else {
                        let longDescription = medias.longDescription
                        SQLManager.shared().insertMedia(userEmail: self.email, artworkUrl: artWork, artistName: artistName!, trackName: trackName, longDescription: longDescription, previewUrl: previewUrl, kind:  medias.kind!)
                    }
                }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playMedia(previewUrl: mediaArray[indexPath.row].previewUrl)
    }
    
    func playMedia(previewUrl: String) {
        let url: URL = URL(string: previewUrl)!
        playerView = AVPlayer(url: url)
        playerVC.player = playerView
        
        self.present(playerVC, animated: true)
        self.playerVC.player?.play()
    }
}
