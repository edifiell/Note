import UIKit

class TableViewController: UITableViewController,UISearchBarDelegate, UISearchControllerDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addHideButton: UIBarButtonItem!
    
    // MARK: Public properties
    var user: [String] = []
    let save = UserDefaults.standard
       
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyBoardTappedArround()
        prepareSearchBar()
        
        customTVC()
        respawnSave()
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text == "" {
            respawnSave()
            dismissKeyBoard()
            addHideButton.isEnabled = true
            
        } else {
            addHideButton.isEnabled = false
            
        }
            return user.count
    } 

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let users = user[indexPath.row]
        cell.textLabel?.text = users
        cell.textLabel?.numberOfLines = 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            user.remove(at: indexPath.row)
            save.setValue(user, forKey: "1")
            tableView.reloadData()
        }
    }
    
       override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
           let moveEmoji = user.remove(at: sourceIndexPath.row)
           user.insert(moveEmoji, at: destinationIndexPath.row)
           save.setValue(user, forKey: "1")
           tableView.reloadData()
 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    // MARK: - Func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondView = segue.destination as? ViewController else { return }
        
        let selectedRow = tableView.indexPathForSelectedRow!.row
        secondView.tvc = user[selectedRow]
        navigationController?.navigationBar.barTintColor = UIColor.secondarySystemBackground
    }
    
    //navigator bar
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if editing {
            editButtonItem.title = "Done"
            editButtonItem.tintColor = .systemRed
            addHideButton.isEnabled = false
        } else {
            
            editButtonItem.title = "Edit"
            editButtonItem.tintColor = .systemBlue
            addHideButton.isEnabled = true
        }
    }
    
    func customTVC() {
        self.title = "toDoList"
        _ = self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func respawnSave() {
        user = save.stringArray(forKey: "1") ?? []
    }
    
    // MARK: SearchBar func
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          user = searchText.isEmpty ? user : user.filter { (item: String) -> Bool in
              return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
          }
          tableView.reloadData()
      }
    
    func prepareSearchBar() {
        self.searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
    }

    // MARK: @IBAction
    @IBAction func UnwindToMainScreen (Segue:UIStoryboardSegue) {
        guard let svr = Segue.source as? ViewController else { return }
        let selectedRow = tableView.indexPathForSelectedRow!.row
        
        user[selectedRow] = svr.textView.text
        save.setValue(user, forKey: "1")
       
        tableView.reloadData()
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        }
    
    @IBAction func UnwindToMainScreenBack (Segue:UIStoryboardSegue) {
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New task", message: "Enter task", preferredStyle: .alert)
        
        let saveTask = UIAlertAction(title: "Save", style: .default) { [self]
                   action in
                   let tf = alertController.textFields?.first
                   if var newTask = tf?.text {
                    if newTask != "" {
                        newTask = tf!.text!
                        user.insert(newTask, at: 0)
                        save.setValue(user, forKey: "1").self
                        dismissKeyBoard()
                        tableView.reloadData()
                    } else {
                        let zeroValueAC = UIAlertController(title: "Warning!", message: "You cannot enter an empty word", preferredStyle: .alert)
                        let cancelAction2 = UIAlertAction(title: "Cancel", style: .default) {_ in}
                        
                        zeroValueAC.addAction(cancelAction2)
                        present(zeroValueAC, animated: true, completion: nil)
                    }
               }
         }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {_ in}
        
        alertController.addTextField { _ in }
        alertController.addAction(cancelAction)
        alertController.addAction(saveTask)
        
        present(alertController, animated: true, completion: nil)
        self.tableView.reloadData()
   }
    
    //hide keyboard for searchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("chida")
    }
}

// MARK: extention -> hide ketboard when tap to view
extension UITableViewController {
    func hideKeyBoardTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    
    
}


