//
//  ViewController.swift
//  ElementTableView
//
//  Created by Ani Adhikary on 18/11/17.
//  Copyright © 2017 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    @IBOutlet weak var elementTableView: UITableView!
    
    //1
    let searchController = UISearchController(searchResultsController: nil)
    
    var pt = [PeriodicTable]()
    var elements = [Element]()
    //4
    var filteredEles: [Element] = []
    
    //5
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElements()
        setupPeriodicTableView()
        setupSearchController() //3 calling
    }
    
    func setupPeriodicTableView() {        
        elementTableView.delegate = self
        elementTableView.register(UINib(nibName: "ElementTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementCell")        
        elementTableView.register(UINib(nibName: "PeriodicTableHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PeriodicTableHeaderTableViewCell")
        elementTableView.register(UINib(nibName: "PeriodicTableFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "PeriodicTableFooterTableViewCell")
        
        pt = getElements()
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
    /*
     func filterContentForSearchText(_ searchText: String) {
     //        filteredElements = elements.filter({ (ele: Element) -> Bool in
     //            return ele.elementName.lowercased().contains(searchText.lowercased()) ||
     //                ele.elementSymbol.lowercased().contains(searchText.lowercased())
     //        })
     
     //        elementTableView.reloadData()
     
     
     _ = pt.filter {
     (ptable: PeriodicTable) -> Bool in
     //var element = ptable.elements
     //return ptable.elements[0].elementName.lowercased().contains(searchText.lowercased())
     
     filteredEles = ptable.elements.filter {
     (ele: Element) -> Bool in
     return ele.elementName.lowercased().contains(searchText.lowercased()) ||
     ele.elementSymbol.lowercased().contains(searchText.lowercased())
     }
     // return true
     }
     
     elementTableView.reloadData()
     }*/
    
    //6
    func filterContentForSearchText(_ searchText: String) {
        filteredEles = elements.filter({ (ele: Element) -> Bool in
            return ele.elementName.lowercased().contains(searchText.lowercased()) ||
                ele.elementSymbol.lowercased().contains(searchText.lowercased())
        })
        
        elementTableView.reloadData()
    }
    
    //7
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func getElements() -> [PeriodicTable] {
        
        var periodicTable = [PeriodicTable]()
        
        let lith­iumGroup = [
            Element(elementName: "Hydrogen", elementSymbol: "H"),
            Element(elementName: "Lithium", elementSymbol: "Li"),
            Element(elementName: "Sodium", elementSymbol: "Na"),
            Element(elementName: "Potassium", elementSymbol: "K")
        ]
        
        let beryl­liumGroup = [
            Element(elementName: "Beryllium", elementSymbol: "Be"),
            Element(elementName: "Magnesium", elementSymbol: "Mg"),
            Element(elementName: "Calcium", elementSymbol: "Ca"),
            Element(elementName: "Strontium", elementSymbol: "Sr")
        ]
        
        let scan­diumGroup = [
            Element(elementName: "Scan­dium", elementSymbol: "Sc"),
            Element(elementName: "Yttrium", elementSymbol: "Y"),
            Element(elementName: "Lanthanum", elementSymbol: "La"),
            Element(elementName: "Actinium", elementSymbol: "Ac")
        ]
        
        let titan­iumGroup = [
            Element(elementName: "Titan­ium", elementSymbol: "Ti"),
            Element(elementName: "Zirconium", elementSymbol: "Zr"),
            Element(elementName: "Hafnium", elementSymbol: "Hf"),
            Element(elementName: "Rutherfordium", elementSymbol: "Rf")
        ]
        
        periodicTable = [
            PeriodicTable(groupName: "Lith­ium group", elements: lith­iumGroup),
            PeriodicTable(groupName: "Beryl­lium group", elements: beryl­liumGroup),
            PeriodicTable(groupName: "Scan­dium Group", elements: scan­diumGroup),
            PeriodicTable(groupName: "Titan­ium Group", elements: titan­iumGroup)
        ]
        
        return periodicTable
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
}

extension ElementViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        } else {
            return pt.count
        }
        
        //return pt.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //8
        if isFiltering {
            return filteredEles.count
        }
        
        //return elements.count
        
        return pt[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementTableViewCell
        //9
        let element: Element
        
        if isFiltering {
            element = filteredEles[indexPath.row]
        } else {
            element = pt[indexPath.section].elements[indexPath.row]
        }
        
        //let element = pt[indexPath.section].elements[indexPath.row]
        elementCell.elementLabel?.text = element.elementName
        elementCell.elementSymbolLabel?.text = element.elementSymbol
        elementCell.selectionStyle = .none
        return elementCell
    }
}

extension ElementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isFiltering {
            return 0
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodicTableHeaderTableViewCell") as! PeriodicTableHeaderTableViewCell
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        cell.groupNameLabel.text = pt[section].groupName
        headerView.addSubview(cell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodicTableFooterTableViewCell") as! PeriodicTableFooterTableViewCell
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        cell.groupEndLabel.text = "------\(pt[section].groupName) ends-----"
        footerView.addSubview(cell)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isFiltering {
            return 0
        } else {
            return 44
        }
    }
}


//2
extension ElementViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!) //6 call
    }
    
}
