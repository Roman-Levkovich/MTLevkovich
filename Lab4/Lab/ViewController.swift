import UIKit

class ViewController: UIViewController {
    var emojiArray = ["💂", "🧑‍⚕️", "💂", "🧑‍⚕️","💂", "🧑‍⚕️","💂", "🧑‍⚕️","💂", "🧑‍⚕️","💂", "🧑‍⚕️","💂", "🧑‍⚕️","💂", "🧑‍⚕️"]
    var select = [Int]()
    var result = 0
    
    @IBOutlet var gameButton: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameButton.shuffle()
        backButton.addTarget(self, action: #selector(setBack), for: .touchUpInside)
        againButton.layer.cornerRadius = UIButton.Appearence.cornerRadius
        againButton.layer.shadowOffset = UIButton.Appearence.shadowOffset
        againButton.layer.shadowOpacity = UIButton.Appearence.shadowOpacity
        for gameButtonOne in gameButton{
            gameButtonOne.addTarget(self,
                                    action: #selector(selectButton),
                                    for: .touchUpInside)
            gameButtonOne.backgroundColor = .orange
            gameButtonOne.layer.cornerRadius = UIButton.Appearence.cornerRadius
            gameButtonOne.layer.shadowOpacity = UIButton.Appearence.shadowOpacity
            gameButtonOne.layer.shadowOffset = UIButton.Appearence.shadowOffset
            gameButtonOne.layer.shadowColor = UIColor.lightGray.cgColor
        }
        
    }
    @objc
    func setBack(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String.segueKey.mainViewController.rawValue) else{return }
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    @objc
    func selectButton(_ sender: UIButton){
        print(emojiArray.count)
        for gameButtonOne in gameButton.indices{
            if sender.tag == gameButton[gameButtonOne].tag{
                gameButton[gameButtonOne].setTitle(emojiArray[gameButtonOne],
                                                   for: .normal)
                gameButton[gameButtonOne].backgroundColor = .lightGray
                if select.count == 1{
                    if select.first == gameButtonOne{
                    }else{
                       select.append(gameButtonOne)
                    }
                }else{
                     select.append(gameButtonOne)
                }
            }
        }
        if select.count == 2 {
            print(select)
            guard   let last = select.last,
                    let first = select.first else{return }
            if gameButton[last].currentTitle == gameButton[first].currentTitle {
                gameButton[last].setTitle("",
                                       for: .normal)
                gameButton[first].setTitle("",
                                        for: .normal)
                gameButton[last].backgroundColor = .white
                gameButton[first].backgroundColor = .white
                gameButton[last].isEnabled = false
                gameButton[first].isEnabled = false
                result+=1
                scoreLabel.text = "Score: \(result)"
            }
            else{
                gameButton[last].setTitle("", for: .normal)
                gameButton[first].setTitle("", for: .normal)
                gameButton[last].backgroundColor = .orange
                gameButton[first].backgroundColor = .orange
                
            }
            select.removeAll()
        }
        if result == 8{
            let alertController = UIAlertController(title: "Message",
                                                    message: "Игра окончена",
                                                    preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "Okey",style: .default){ alert in
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String.segueKey.mainViewController.rawValue) as? MainViewController else{return }
                vc.modalPresentationStyle = .fullScreen
                self.show(vc, sender: nil)
            }
             
            let againAction = UIAlertAction(title: "Еще раз",
                                            style: .default) { (alert) in
                self.select.removeAll()
                self.emojiArray.shuffle()
                self.result = 0
                self.scoreLabel.text = "Score: 0"
                for gameButtonOne in self.gameButton{
                    gameButtonOne.backgroundColor = .orange
                    gameButtonOne.isEnabled = true
                    gameButtonOne.setTitle("", for: .normal)
                }
            }
            alertController.addAction(okeyAction)
            alertController.addAction(againAction)
            present(alertController,
                    animated: true,
                    completion: nil)
        }
        
    }
   
    @IBAction func again(_ sender: UIButton) {
        select.removeAll()
        emojiArray.shuffle()
        result = 0
        scoreLabel.text = "Score: "
        for gameButtonOne in gameButton{
            gameButtonOne.isEnabled = true
            gameButtonOne.backgroundColor = .orange
            gameButtonOne.setTitle("", for: .normal)
            
        }
    }
}


extension UIButton{
    public struct Appearence{
        static let shadowOffset = CGSize(width: 2, height: 2)
        static let shadowOpacity: Float = 0.5
        static let cornerRadius: CGFloat = 5
    }
    
}

extension String{
    enum segueKey: String{
        case mainViewController = "MainViewController"
    }
}
