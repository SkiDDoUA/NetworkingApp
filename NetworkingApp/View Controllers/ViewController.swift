//
//  ViewController.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 31.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "4e63d4faa0msh378a71badc41377p1acfa1jsnee0352aaf9dc",
            "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        var networkService = AlamoNetworking<RecipesEndpoint>("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                                                              headers: headers)
        
        Task {
            let data = try? await networkService.perform(.post, .analyzer,
                RecipeAnalyzelnstruction("Fried potatoe with chicken, onions and cheese"))
            print(try! JSONSerialization.jsonObject (with: data!))
        }
        
        
        
//        networkService.perform(.post, .analyzer, RecipeAnalyzelnstruction("Fried potatoe with chicken, onions and cheese")) { result in
//            switch result {
//            case .data(let data):
//                print(try! JSONSerialization.jsonObject (with: data!))
//            case .error(let error): break
//            }
//        }
        
        
        
//        do {
//            var networkService = try Network<RecipesEndpoint>(
//                "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
//                headers: headers
//            )
//            Task
//            {
//                let data = try? await networkService.perform(.post, .analyzer,
//                    RecipeAnalyzelnstruction("Fried potatoe with chicken, onions and cheese"))
//                print(try! JSONSerialization.jsonObject (with: data!))
//            }
//        } catch {
//            print(error)
//        }
    }
}

