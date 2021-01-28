import UIKit

class ViewController: UIViewController {
    
    var tvc: String?
    var tableVC: TableViewController?
    
    
    @IBOutlet weak var textView: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfoTVC()
        customView()
        
        swipeObservers()
        tapObserver()
    }
    //MARK: func
    func customView() {
        self.title = "toDoList"
        navigationController?.navigationBar.barTintColor = UIColor.secondarySystemBackground
    }
    
    func getInfoTVC() {
        guard let tvc = self.tvc else { return }
        textView.text = tvc
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    //MARK: Action
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
    }
    
    //MARK: Extention -> ExtentionVC
}

