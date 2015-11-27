//
//  RecentSearchesViewController.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/27/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit

class RecentSearchesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentsStore.getSize()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("search", forIndexPath: indexPath)
        cell.textLabel?.text = RecentsStore.getSearchAt(indexPath.row)
        return cell // we know that is was definitely initialized
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("Search recent", sender: RecentsStore.getSearchAt(indexPath.row))
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "Search recent":
            if let destVC = segue.destinationViewController  as?TweetTableViewController{
                destVC.searchText = sender as? String
            }
            break
        default:
            break
        }
    }
    
}
