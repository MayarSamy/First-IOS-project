
//
//  MoviesVC.swift
//  first ios project
//
//  Created by IOS on 8/26/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

    //outllets
    @IBOutlet weak var moviesTable: UITableView!
    
    //variables
    var moviesArray : [Movies] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title
        self.navigationItem.title = "Movies List"
    }
    
    
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
//        let movie1 = Movie(image: "true story" , name: "True Story", type: "Mystery", releaseDate: "2015")
//        let movie2 = Movie(image: "spy", name: "Spy", type: "Action comedy", releaseDate: "2015")
//        let movie3 = Movie(image: "assassins creed", name: "Assassin's Creed", type: "Science fiction action", releaseDate: "2016")
//        let movie4 = Movie(image: "x-men", name: "X-Men: Apocalypse ", type: "Superhero", releaseDate: "2016")
//        let movie5 = Movie(image: "Kong Skull Island", name: "Kong: Skull Island", type: "Monster", releaseDate: "2017")
//        let movie6 = Movie(image: "Jigsaw", name: "Jigsaw", type: "Horror", releaseDate: "2017")
//        let movie7 = Movie(image: "TheNun", name: "The Nun", type: "Horror", releaseDate: "2018")
//        let movie8 = Movie(image: "fantastic beasts", name: "Fantastic Beasts: The Crimes of Grindelwald", type: "Fantasy", releaseDate: "2018")
//        let movie9 = Movie(image: "joker", name: "Joker", type: "Psychological thriller", releaseDate: "2019")
//        let movie10 = Movie(image: "Us", name: "Us", type: "Horror", releaseDate: "2019")
//
//        moviesArray.append(contentsOf: [movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8, movie9, movie10])
   
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
        
        let image = UIImage(named: moviesArray[indexPath.row].image)
        cell.movieImage.image = image
        cell.movieNameLbl.text = moviesArray[indexPath.row].title
        cell.movieTypeLbl.text = moviesArray[indexPath.row].genre[0]
        //cell.mov.text = String(moviesArray[indexPath.row].rating)

        cell.moviesReleasedLbl.text = String(moviesArray[indexPath.row].releaseYear)
        cell.movieRatingLbl.text = String(moviesArray[indexPath.row].rating)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
