//
//  SQLManager.swift
//  first ios project
//
//  Created by IOS on 9/9/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import SQLite

class SQLManager {
    
    private init() {}
    private static let sharedInstance = SQLManager()

    static func shared() -> SQLManager {
        return SQLManager.sharedInstance
    }
    
    var database : Connection!
    
    let usersTable = Table("users")
    let searchedTable = Table("searchedMedia")
    
    //user table columns
    let name = Expression<String>("username")
    let email = Expression<String>("userEmail")
    let phone = Expression<String>("userPhone")
    let address = Expression<String>("userAddress")
    let password = Expression<String>("userPassword")
    let gender = Expression<String>("userGender")
    //let image = Expression<String>("userImage")

    //media searched table columns
    let userEmail = Expression<String>("userEmail")
    let artworkUrl = Expression<String>("artworkUrl")
    let artistName = Expression<String>("artistName")
    let trackName = Expression<String?>("trackName")
    let longDescription = Expression<String?>("longDescription")
    let previewUrl = Expression<String>("previewUrl")
    let kind = Expression<String>("kind")
    
    // database connection setup
    func setupConnection() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("searchedMedia").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    //create users table
    func createUsersTable() {
        let createUsersTable = self.usersTable.create(ifNotExists: true) {
            (table) in
            table.column(self.name)
            table.column(self.email, primaryKey: true)
            table.column(self.phone)
            table.column(self.address)
            table.column(self.password)
            table.column(self.gender)
            //table.column(self.image)
        }
        do {
            try self.database.run(createUsersTable)
            print("users table created")
        } catch {
            print(error)
        }
    }
    
    //create searched media table
    func createSearchedTable() {
        let createSearchedTable = self.searchedTable.create(ifNotExists: true) {
            (table) in
            table.column(self.userEmail)
            table.column(self.artworkUrl)
            table.column(self.artistName)
            table.column(self.trackName)
            table.column(self.longDescription)
            table.column(self.previewUrl)
            table.column(self.kind)
        }
        
        do {
            try self.database.run(createSearchedTable)
            print("searched table created")
        } catch {
            print(error)
        }
    }
    
    //insert user data
    func insertUser(name: String, email: String, phone: String, address: String, password: String, gender: String/*, image: String*/) {
        let user = self.usersTable.insert(self.name <- name, self.email <- email, self.phone <- phone, self.address <- address, self.password <- password, self.gender <- gender/*, self.image <- image*/)

        do {
            try self.database.run(user)
            print("user data entered")
        } catch {
            print(error)
        }
    }
    
    //inset searched media
    func insertMedia(userEmail: String, artworkUrl: String, artistName: String, trackName: String?, longDescription: String?, previewUrl: String, kind: String) {
        
        let media = self.searchedTable.insert(self.userEmail <- userEmail, self.artworkUrl <- artworkUrl, self.artistName <- artistName, self.longDescription <- longDescription, self.previewUrl <- previewUrl, self.kind <- kind, self.trackName <- trackName)
        do {
            try self.database.run(media)
            print("data entered")
        } catch {
            print(error)
        }
    }
    
    //getting user data from table
    func retriveUserData(userMail: String) -> User {
        var usersData: User = User()
        do {
            let users = try self.database.prepare(self.usersTable.filter(email == userMail))
            for user in users {
                usersData = User(name: user[self.name], email: user[self.email], phone: user[self.phone], address: user[self.address], password: user[self.password], gender: Gender(rawValue: user[self.gender]))
            }

            } catch {
            print(error)
        }
        return usersData
    }
    
    //getting media data from table
    func retriveMedia(userMail: String) -> [Media] {
        var mediaArr : [Media] = []
        do {
            let medias = try self.database.prepare(self.searchedTable.filter(userEmail == userMail))
            for media in medias {
                    let med = Media(artworkUrl100: media[self.artworkUrl], artistName: media[self.artistName], trackName: media[self.trackName], longDescription:media[self.longDescription], previewUrl: media[self.previewUrl], kind: media[self.kind])
                mediaArr.append(med)
            }
        } catch {
            print(error)
        }
        return mediaArr
    }
    
    //deleting media table
    func droppingSearchedMedia(userMail: String){
        do {
            let deleted = self.searchedTable.filter(userEmail == userMail)
            try self.database.run(deleted.delete())
            print("searched table dropped")
        } catch {
            print(error)
        }
    }

}
