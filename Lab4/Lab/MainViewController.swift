import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = UIButton.Appearence.cornerRadius
        startButton.layer.shadowOpacity = UIButton.Appearence.shadowOpacity
        startButton.layer.shadowOffset = UIButton.Appearence.shadowOffset
        
    }
  

}
