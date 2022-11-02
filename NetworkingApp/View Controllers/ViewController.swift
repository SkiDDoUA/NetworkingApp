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
        
//        //Search Recipes
//        Task {
//            let data = try? await NetworkSettings.networkService.performAwait(.get, .recipes, RecipesQuery("pasta", .recipes))
//            print(try! JSONSerialization.jsonObject (with: data!))
//        }
//
//        //Get Random Recipes
//        Task {
//            let data = try? await NetworkSettings.networkService.performAwait(.get, .random, RecipesQuery("10", .random))
//            print(try! JSONSerialization.jsonObject (with: data!))
//        }
//
//        //Guess Nutrition by Dish Name
//        Task {
//            let data = try? await networkService.performAwait(.get, .nutrition, RecipesQuery("Spaghetti Aglio et Olio", .nutrition))
//            print(try! JSONSerialization.jsonObject (with: data!))
//        }
//
//        //Get Recipe Information
//        Task {
//            let data = try? await networkService.performAwait(.get, .recipeInformation, RecipesQuery("479101", .recipeInformation))
//            print(try! JSONSerialization.jsonObject (with: data!))
//        }
//
//        //Classify Cuisine
//        Task {
//            let data = try? await networkService.performAwait(.post, .recipes, RecipesQuery("pasta", .cuisine))
//            print(try! JSONSerialization.jsonObject (with: data!))
//        }
        
//        Task {
//            let data = try? await networkService.performAwait(.post, .analyzer,
//                RecipeAnalyzelnstruction("Fried potatoe with chicken, onions and cheese"))
//            print(try! JSONSerialization.jsonObject (with: data!))
//        }
        
        
        
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

