//
//  ViewController.swift
//  Lab5
//
//  Created by Sasha Putsikovich on 26.11.2020.
//

import UIKit

struct Movie{
    var title: String?
    var disck: String?
    var imagePath: String?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else{return UITableViewCell()}
        cell.dLabel.text = movies[indexPath.row].disck
        cell.tLabel.text = movies[indexPath.row].title
        guard let imagePath = setImage(path: movies[indexPath.row].imagePath!) else {return UITableViewCell()}
                                       
        cell.imageView?.image = UIImage(data: imagePath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    let urlSt = "https://api.themoviedb.org/3/movie/top_rated?api_key=d3c585cce88b277f42e68ce10aa4358f&language=en-US&page=1"
    let urlImage = "https://image.tmdb.org/t/p/w500"
  
    var movies = [Movie]()
    @IBOutlet weak var table: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        parse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func parse(){
        if let url = URL(string: urlSt){
            let session = URLSession.shared
            
            session.dataTask(with: url) { (data, resp, error) in
                if let data = data{
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    print(data)
                let result = json?["results"] as! [[String: Any]]
                  //  print(result)
                for movie in result{
                    print(movie)
                    if let disckrs = movie["overview"] as? String,
                     let titleN = movie["title"] as? String,
                    let imageUrl = movie["poster_path"] as? String{
                        print(titleN)
                        let movie = Movie(title: titleN, disck: disckrs, imagePath: imageUrl)
                        self.movies.append(movie)
                        print(self.movies)
                    }
                }
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                }
            }.resume()
        
        }
    }
    func setImage(path: String)->Data?{
        guard let url = URL(string: urlImage+path) else{return nil}
        guard let data = try? Data(contentsOf: url) else{return nil}
        return data
    }


}

