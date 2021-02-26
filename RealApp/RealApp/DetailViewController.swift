//
//  DetailViewController.swift
//  RealApp
//
//  Created by user186492 on 25.02.2021.
//

import UIKit

class DetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var photoNameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var photo = Photo(dictionary: [:])
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoNameLabel.text = photo.title
        if let url = URL(string: photo.url) {
            photoImage.contentMode = .scaleAspectFill
            photoImage.load(url: url)
            
        }
        
        loadLogo()
        getComments()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTableViewCell
        cell.nameLabel.text = comments[indexPath.row].email
        cell.commentLabel.text = comments[indexPath.row].name
        cell.myImage.load(url: URL(string: photo.thumbnailUrl)!)
        return cell
    }
    

    func loadLogo() {
        if let image = UIImage(named: "istanbul.png") {
            let newLogo = Util.app.resizeImageWithAspect(image: image, scaledToMaxWidth: 350, maxHeight: 200)
            let imageView = UIImageView(image: newLogo)
            self.navigationItem.titleView = imageView
        }
    }
    
    func getComments() {
        comments = []
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(photo.id)/comments")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription ?? "error")
            }else {
                
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                }
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as?  [[String : Any]] {
                       // print(json)
                        for dic in json {
                            self.comments.append(Comment(dictionary: dic))
                        }
                        
                        
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
