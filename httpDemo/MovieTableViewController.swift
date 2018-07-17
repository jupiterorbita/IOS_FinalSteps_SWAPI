

import UIKit

class MovieTableViewController: UITableViewController {
    var films: [NSDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 350
        getData(from: "http://swapi.co/api/films/")
        
    }
    
    func getData(from url: String) {
        StarWarsModel.getAllFilms(url: url, completionHandler:  {
            
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                    let newFilms = jsonResult["results"] as! [NSDictionary]
                    
                    self.films.append(contentsOf: newFilms)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    if let nextUrl = jsonResult["next"] as? String {
                        print(nextUrl)
                        self.getData(from: nextUrl)
                    }
                }
            }
            catch {
                print("Something went wrong")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    
    
//    func getAllData(from url: String){
//        let url = URL(string: url)
//        let session = URLSession.shared
//        let task = session.dataTask(with: url!){
//            data, response, error in
//            print("in here")
//            print(data ?? "no data")
//
//            do {
//                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
//                    let newFilms = jsonResult["results"] as! [NSDictionary]
//                    self.films.append(contentsOf: newFilms)
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                    if let nextUrl = jsonResult["next"] as? String {
//
//                        print(nextUrl)
//                        self.getAllData(from: nextUrl)
//                    }
//                }
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! CustomFilmTableViewCell
        cell.titleLabel?.text = films[indexPath.row]["title"] as! String
        cell.directorLabel?.text = "Directed by: \(films[indexPath.row]["director"] as! String)"
        cell.dateLabel?.text = films[indexPath.row]["release_date"] as! String
        cell.crawlView?.text = films[indexPath.row]["opening_crawl"] as! String

        
        
        
        
        return cell
    }

}
