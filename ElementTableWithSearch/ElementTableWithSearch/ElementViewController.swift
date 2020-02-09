//
//  ElementViewController.swift
//  ElementTableViewSegue
//
//  Created by Ani Adhikary on 18/11/17.
//  Copyright © 2017 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    @IBOutlet weak var elementTableView: UITableView!
    
    var elements = [Element]()
    //1
    let searchController = UISearchController(searchResultsController: nil)
    //4
    var filteredElements: [Element] = []
    
    //5
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //7
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loadElements()
        setupSearchController() //3 calling
    }
    
    func loadElements() {
        elements = [
            Element(elementName: "Hydrogen", elementSymbol: "H"),
            Element(elementName: "Helium", elementSymbol: "He"),
            Element(elementName: "Lithium", elementSymbol: "Li"),
            Element(elementName: "Beryllium", elementSymbol: "Be"),
            Element(elementName: "Boron", elementSymbol: "B"),
            Element(elementName: "Carbon", elementSymbol: "C"),
            Element(elementName: "Nitrogen", elementSymbol: "N"),
            Element(elementName: "Oxygen", elementSymbol: "O"),
            Element(elementName: "Fluorine", elementSymbol: "F"),
            Element(elementName: "Neon", elementSymbol: "Ne"),
            Element(elementName: "Sodium", elementSymbol: "Na"),
            Element(elementName: "Magnesium", elementSymbol: "Mg"),
            Element(elementName: "Aluminum", elementSymbol: "Al"),
            Element(elementName: "Silicon", elementSymbol: "Si"),
            Element(elementName: "Phosphorus", elementSymbol: "P"),
            Element(elementName: "Sulfur", elementSymbol: "S"),
            Element(elementName: "Chlorine", elementSymbol: "Cl"),
            Element(elementName: "Argon", elementSymbol: "Ar"),
            Element(elementName: "Potassium", elementSymbol: "K"),
            Element(elementName: "Calcium", elementSymbol: "Ca"),
            Element(elementName: "Scandium", elementSymbol: "Sc")
        ]
    }
    
    //3
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Elements"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //6
    func filterContentForSearchText(_ searchText: String) {
//      filteredCandies = candies.filter { (candy: Candy) -> Bool in
//        return candy.name.lowercased().contains(searchText.lowercased())
//      }
        
//        filteredElements = elements.filter {
//            return $0.elementName.lowercased().contains(searchText.lowercased()) ||
//                $0.elementSymbol.lowercased().contains(searchText.lowercased())
//        }
      
        filteredElements = elements.filter({ (ele: Element) -> Bool in
            return ele.elementName.lowercased().contains(searchText.lowercased()) ||
                ele.elementSymbol.lowercased().contains(searchText.lowercased())
        })
        
      elementTableView.reloadData()
    }
    
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //8
        if isFiltering {
            return filteredElements.count
        }
                          
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        
        //9
        let element: Element
        
        if isFiltering {
          element = filteredElements[indexPath.row]
        } else {
          element = elements[indexPath.row]
        }
                
        elementCell.textLabel?.text = element.elementName
        elementCell.detailTextLabel?.text = element.elementSymbol
        return elementCell
    }
}

extension ElementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //10
       let element: Element
       
       if isFiltering {
         element = filteredElements[indexPath.row]
       } else {
         element = elements[indexPath.row]
       }
        
        let elementDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ElementDetailViewController") as! ElementDetailViewController
        elementDetailVC.element = element
        self.navigationController?.pushViewController(elementDetailVC, animated: true)
        elementTableView.deselectRow(at: indexPath, animated: true)
    }
}

//2
extension ElementViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!) //6 call
    }
    
}
