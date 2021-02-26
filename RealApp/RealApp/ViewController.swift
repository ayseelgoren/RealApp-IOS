//
//  ViewController.swift
//  RealApp
//
//  Created by user186492 on 23.02.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var photos = [Photo]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadLogo()
        getPhotos()
    }

    /* Tableview */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.myText.text = photos[indexPath.row].title
        cell.myImage.load(url: URL(string: photos[indexPath.row].url)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = photos[indexPath.row]
        
        performSegue(withIdentifier: "toDetail", sender: row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.photo = sender as! Photo
        }
    }
    
    
    /* Methods */
    func loadLogo() {
        if let image = UIImage(named: "istanbul.png") {
            let newLogo = Util.app.resizeImageWithAspect(image: image, scaledToMaxWidth: 350, maxHeight: 200)
            let imageView = UIImageView(image: newLogo)
            self.navigationItem.titleView = imageView
        }
    }
    
    func getPhotos() {
        photos = []
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription ?? "error")
            }else {
                
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                }
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as?  [[String : Any]] {
                        //print(json)
                        for dic in json {
                            self.photos.append(Photo(dictionary: dic))
                        }
                        
                        self.photos = Array(self.photos.prefix(10))
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                }catch let error as NSError{
                    print(error)
                }
                
            }
            
        }
        task.resume()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
