import UIKit

class ViewController: UITableViewController {
    var pictures: [String] = [String]()
    
    func sortPictures() {
        self.pictures.sort()
    }

    override func viewDidLoad() {
        super.viewDidLoad() // aktivira viewDidLoad ot UIViewContrl predi moq kod
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default // fm allows me to use the file system
        let path = Bundle.main.resourcePath! // the path for all files from this project
        let items = try! fm.contentsOfDirectory(atPath: path) // all files from this project
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        sortPictures()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.imageCount = pictures.count
            vc.imagePosition = indexPath.row + 1
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

