//
//  ListTableViewController.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/08.
//

import UIKit
import RealmSwift
class ListTableViewController: UITableViewController {
    let realm = try! Realm()
    var data: Results<User>!
    var token: NotificationToken!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        data = realm.objects(User.self)
        token = realm.observe{ notification,realm in
            self.tableView.reloadData()
        }
       //下に引っ張ると更新される
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshTable), for: UIControl.Event.valueChanged)
           self.refreshControl = refreshControl
       
    }
    @objc func refreshTable() {
        tableView.reloadData()
    
         // クルクルを止める
         refreshControl?.endRefreshing()
     }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(User.self).count
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListTableViewCell
        let data = realm.objects(User.self)
        cell?.name.text = data[indexPath.row].name
        cell?.Address.text = data[indexPath.row].address
        cell?.number.text = data[indexPath.row].tag
        cell?.Phone.text = data[indexPath.row].tel
        
        
        return cell!
        
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Helper().deleteData(user: data[indexPath.row], token: token)
        }
        
        tableView.reloadData()
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
