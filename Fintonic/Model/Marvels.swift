//
//  Marvels.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

protocol Networks {
    typealias response = (SuperHeroes)->()
    func getMarvelsHeroes(completion: @escaping response)
}

struct SuperHeroes: Codable {
  let superheroes: [Marvels]
}

struct Marvels: Codable {
     let name: String
     let photo: String
     let realName: String
     let height: String
     let power: String
     let abilities: String
     let groups: String
}

class MarvelAPI {
 static func getMarvels() -> [Marvels]{
   let marvels = [
        Marvels(name: "Spiderman",
                photo: "https://i.annihil.us/u/prod/marvel/i/mg/9/30/538cd33e15ab7/standard_xlarge.jpg",
                realName: "Peter Benjamin Parker",
                height: "1.77m",
                power: "Peter can cling to most surfaces, has superhuman strength (able to lift 10 tons optimally) and is roughly 15 times more agile than a regular human.",
                abilities: "Peter is an accomplished scientist, inventor and photographer.",
                groups: "Avengers, formerly the Secret Defenders, \"New Fantastic Four\", the Outlaws"),
                Marvels(name: "Captain Marvel",
                photo: "https://i.annihil.us/u/prod/marvel/i/mg/c/10/537ba5ff07aa4/standard_xlarge.jpg",
                realName: "Carol Danvers",
                height: "1.80m",
                power: "Ms. Marvel's current powers include flight, enhanced strength, durability and the ability to shoot concussive energy bursts from her hands.",
                abilities: "Ms. Marvel is a skilled pilot & hand to hand combatant",
                groups: "Avengers, formerly Queen's Vengeance, Starjammers"),
                Marvels(name: "Hulk",
                photo: "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/standard_xlarge.jpg",
                realName: "Robert Bruce Banner",
                height: "1.75m",
                power: "The Hulk possesses an incredible level of superhuman physical ability.",
                abilities: "Dr. Bruce Banner is a genius in nuclear physics, possessing a mind so brilliant that it cannot be measured on any known intelligence test. When Banner is the Hulk, Banner's consciousness is buried within the Hulk's, and can influence the Hulk's behavior only to a very limited extent.",
                groups: "Formerly Avengers, Defenders, Fantastic Four, Pantheon, Horsemen of Apocalypse, Warbound")
    ]
   return marvels
  }
}

class MarvelUrlAPI: Networks {
    func getMarvelsHeroes(completion: @escaping (SuperHeroes) -> ()) {
        guard let url = URL(string: "https://api.myjson.com/bins/bvyob") else{ return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse,
                (200...209).contains(httpURLResponse.statusCode),
                let mimetype = response?.mimeType, mimetype == "application/json",
                let data = data, error == nil else { return }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let heroes = try JSONDecoder().decode(SuperHeroes.self, from: data)
                completion(heroes)
            } catch {
                print("Json Error \(error.localizedDescription)")
            }
        }.resume()
    }
}
