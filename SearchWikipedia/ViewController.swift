//
//  ViewController.swift
//  SearchWikipedia
//
//  Created by nolbal_dayeon on 2020/06/26.
//  Copyright © 2020 dayeonJung. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    
    let session: URLSession = URLSession.shared
    
    let searchController = UISearchController(searchResultsController: nil)

    var searchResults: [String] = []
    var input: String = ""
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "검색어를 입력하세요."
        self.navigationItem.searchController = self.searchController

        self.tableview.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")

    }


    
    func search(word: String, completion: @escaping (Array<String>?, String?) -> Void) {
        
        var paramDic: [String: String] = [:]
        paramDic["action"] = "opensearch"
        paramDic["namespace"] = "0"
        paramDic["limit"] = "10"
        paramDic["format"] = "json"
        
        paramDic["search"] = word
        
        var components = URLComponents()
        components.queryItems = paramDic.map {
             URLQueryItem(name: $0, value: $1)
        }

        var urlStr: String = "https://en.wikipedia.org/w/api.php"
        urlStr.append(components.url!.absoluteString)
        
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        self.session.dataTask(with: request) { (data, response, error) in

            if let hasError = error {
                completion(nil, hasError.localizedDescription)
                return
            }
            
            if let hasData = data {
                let responseData = try? JSONSerialization.jsonObject(with: hasData, options: .mutableContainers) as? Array<Any>
                let results = responseData?[1] as? Array<String>
                completion(results, nil)
                return
            }
            
        }.resume()
    }
    
    
}



extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        self.input = searchController.searchBar.text ?? ""
        self.search(word: self.input) { (results, error) in
            if let errorMessage = error {
                print("위키피디아 검색을 실패했습니다.\n" + errorMessage)
            } else {
                guard let searchResults = results else {
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                    return
                }
                
                self.searchResults = searchResults
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        }
    
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text, text.count > 0 {
            let record = SearchRecordModel()
            record.date = Date()
            record.searchingWord = text
            
            DispatchQueue.main.async {
                autoreleasepool {
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(record)
                    }
                }
            }

        }
        
        
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.input == "" {
            let realm = try! Realm()
            let results = realm.objects(SearchRecordModel.self)
            
            return results.count
        }
        
        return self.searchResults.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        if self.input == "" {
            let realm = try! Realm()
            let results = realm.objects(SearchRecordModel.self)
            cell.setRecentSearchingRecordUI(record: results[indexPath.row])
        }
        else {
            cell.setSearchingResultUI(input: self.input, searchResult: self.searchResults[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.input == "" ? "최근 검색 기록" : nil
        
    }
    
    
}
