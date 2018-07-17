


import UIKit
class PeopleViewController: UITableViewController {
    var people: [NSDictionary] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        getData(from: "http://swapi.co/api/people/")
    }
    
    func getData(from url: String) {
        StarWarsModel.getAllPeople(url: url, completionHandler:  {
            
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                    let newPeople = jsonResult["results"] as! [NSDictionary]
                        
                    self.people.append(contentsOf: newPeople)
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLabel?.text = people[indexPath.row]["name"] as! String
        cell.massLabel?.text = "Mass: \(people[indexPath.row]["mass"] as! String)"
        cell.birthLabel?.text = "Birth Year: \(people[indexPath.row]["birth_year"] as! String)"
        cell.genderLabel?.text = "\(people[indexPath.row]["gender"] as! String)"
        
        
        return cell
    }
}
