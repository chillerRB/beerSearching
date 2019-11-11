//
//  BeersSearchingTableViewController.swift
//  BeerSearching
//
//  Created by Chiller on 10/11/2019.
//  Copyright © 2019 Chiller Pruebas. All rights reserved.
//

import UIKit

class BeersSearchingTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var beers = [Beer]()
    
    //Variables para el control de las peticiones web con cada cambio de texto
    private var previousRun = Date()
    private let minInterval = 0.05
    
    //Variabls para paginación
    private var isPaginacion = false
    private var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchBeers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! BeerTableViewCell

        // Configure the cell...
        let beer = beers[indexPath.row]

        cell.configBerCell(beer: beer)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isPaginacion {
            if indexPath.row == beers.count - 1 {
                let searchTerm = searchBar.text ?? ""
                fetchBeerBySearch(textSearched: searchTerm, page: page, perPage: 15)
            }
        }
        
    }




    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "DetailSegue":
            let beerDetailViewController = segue.destination as! ViewController
            let index = tableView.indexPathForSelectedRow!.row
            beerDetailViewController.beer = beers[index]
            
        default:
            print("No destino")
        }
    }
    
    
    //MARK: - Peticiones web
    
    //Petición web de todos los beers, esto será llamado cuando se esta cargando esta vista
    func fetchBeers() {
        BeerController.shared.fetchBeers { (data) in
            if let data = data {
                self.beers = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

}

//MARK: - Extension to UISearchBarDelegate

extension BeersSearchingTableViewController: UISearchBarDelegate {
    
    //Función que permite realizar busquedas cada vez que el texto cambia
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        beers.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchBeerBySearch(textSearched: textToSearch, page: 1, perPage: 15)
        }
    }
    
    //MARK: - Petición web para buscar beers
    //Función que será ejecutado cada vez que el usuario cambie los caracteres en el search bar
    func fetchBeerBySearch(textSearched: String, page: Int, perPage: Int) {
        
        self.beers = []
        
        if !textSearched.isEmpty {
            self.page = 0
            self.isPaginacion = false
            // set up query dictionary
            let query: [String: String] = [
                    "food": textSearched,
                    "page": String(page),//"1",
                    "per_page": String(perPage) //"10"
                ]
            // petición web por cada cambio de texto
            BeerController.shared.fetchBeersByString(query: query) { (storeBeers) in
                if let storeBeers = storeBeers, !storeBeers.isEmpty {
                    self.beers.append(contentsOf: storeBeers)
                    self.page += 1
                    self.isPaginacion = true
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}
