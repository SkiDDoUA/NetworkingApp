//
//  MainViewController.swift
//  NetworkingApp
//
//  Created by Anton Kolesnikov on 01.11.2022.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    @IBOutlet private weak var RecipesCollectionView: UICollectionView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var guessButton: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    
    var recipes = [Result]() {
        didSet {
            DispatchQueue.main.async {
                self.RecipesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecipesCollectionView.delegate = self
        RecipesCollectionView.dataSource = self
        
        setupUI()
        
        getRecipes(for: "sandwich")
    }
    
    func setupUI() {
        let radius = CGFloat(12)
        
        searchButton.layer.cornerRadius = radius
        searchButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        guessButton.layer.cornerRadius = radius
        guessButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        searchTextField.layer.cornerRadius = radius
        searchTextField.layer.borderColor = UIColor(named: "Gray")?.cgColor
        searchTextField.layer.borderWidth = 1.5
        searchTextField.clipsToBounds = true
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let request = searchTextField.text {
            getRecipes(for: request)
        }
    }
    
    @IBAction func guessButtonTapped(_ sender: Any) {
        if let request = searchTextField.text {
            guessNutrition(for: request)
        }
    }
    
    //MARK: - Alamofire Networking Functions
    func getRecipes(for text: String) {
        Task {
            let data = try? await NetworkSettings.networkServiceAlamofire.performAwaitAlamofire(.get, .recipes, RecipesQuery(text, .recipes))
            let recipesList = try! JSONDecoder().decode(RecipesList.self, from: data!)
            recipes = recipesList.results
        }
    }

    func guessNutrition(for text: String) {
        Task {
            let data = try? await NetworkSettings.networkServiceAlamofire.performAwaitAlamofire(.get, .nutrition, RecipesQuery(text, .nutrition))
            let dishNutrition = try! JSONDecoder().decode(DishNutrition.self, from: data!)

            showAlert(dish: text, text: dishNutrition.description)
        }
    }

    func getRecipeInformation(for id: Int, completion: @escaping (Recipe) -> ()) {
        Task {
            let dataInformation = try? await NetworkSettings.networkServiceAlamofire.performAwaitAlamofire(.get, .recipeInformation(id: id), RecipesQuery(String(id), .recipeInformation(id: id)))
            var recipeForSegue = try! JSONDecoder().decode(Recipe.self, from: dataInformation!)

            let dataCuisine = try? await NetworkSettings.networkServiceAlamofire.performAwaitAlamofire(.post, .cuisine, RecipesQuery(recipeForSegue.title, .cuisine))
            let cuisine = try! JSONSerialization.jsonObject (with: dataCuisine!) as? [String: Any]

            recipeForSegue.cuisine = cuisine?["cuisine"] as? String
            completion(recipeForSegue)
        }
    }
    
    //MARK: - Networking Functions
//    func getRecipes(for text: String) {
//        Task {
//            let data = try? await NetworkSettings.networkService.performAwait(.get, .recipes, RecipesQuery(text, .recipes))
//            let recipesList = try! JSONDecoder().decode(RecipesList.self, from: data!)
//            recipes = recipesList.results
//        }
//    }
//
//    func guessNutrition(for text: String) {
//        Task {
//            let data = try? await NetworkSettings.networkService.performAwait(.get, .nutrition, RecipesQuery(text, .nutrition))
//            let recipeNutrition = try! JSONDecoder().decode(DishNutrition.self, from: data!)
//
//            showAlert(dish: text, text: recipeNutrition.description)
//        }
//    }
//
//    func getRecipeInformation(for id: Int, completion: @escaping (Recipe) -> ()) {
//        Task {
//            let dataInformation = try? await NetworkSettings.networkService.performAwait(.get, .recipeInformation(id: id), RecipesQuery(String(id), .recipeInformation(id: id)))
//            var recipeForSegue = try! JSONDecoder().decode(Recipe.self, from: dataInformation!)
//
//            let dataCuisine = try? await NetworkSettings.networkService.performAwait(.post, .cuisine, RecipesQuery(recipeForSegue.title, .cuisine))
//            let cuisine = try! JSONSerialization.jsonObject (with: dataCuisine!) as? [String: Any]
//
//            recipeForSegue.cuisine = cuisine?["cuisine"] as? String
//            completion(recipeForSegue)
//        }
//    }
    
    func showAlert(dish: String, text: String) {
        let alert = UIAlertController(title: "Nutririon for: \(dish)", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Nice!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
    //MARK: - Parse Cell Data To RecipeViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueIdentifier.toRecipe:
            let destination = segue.destination as! RecipeViewController
            let cell = sender as! RecipeCollectionViewCell
            let indexPath = RecipesCollectionView.indexPath(for: cell)!
            
            getRecipeInformation(for: recipes[indexPath.item].id) { recipe in
                destination.configure(for: recipe)
            }
        default: break
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RecipesCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        cell.configure(for: recipes[indexPath.row])
        return cell
    }
}
