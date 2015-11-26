//
//  TweetDetailsTableViewController.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/26/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit

class TweetDetailsTableViewController: UITableViewController {
    
    // MARK: - Internal DataStructure
    
    var tweet : Tweet? {
        didSet {
            if let tw = tweet {
                var newSections = [Section]()
                // add sections where count is more than 0
                if tw.media.count > 0 {
                    newSections += [Section.Media(tw.media)]
                }
                if tw.userMentions.count > 0 {
                    newSections += [Section.MentionSection("Users mentioned",tw.userMentions)]
                }
                if tw.urls.count > 0 {
                    newSections += [Section.MentionSection("urls",tw.urls)]
                }
                if tw.hashtags.count > 0 {
                    newSections += [Section.MentionSection("HashTag",tw.hashtags)]
                }
                // update old sections
                sections = newSections
            }
        }
    }
    
    private var sections : [Section]? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private enum Section : CustomStringConvertible {
        case Media([MediaItem])
        case MentionSection(String,[Tweet.IndexedKeyword])
        
        func getRowCount() -> Int {
            switch self {
            case .Media(let media):
                return media.count
            case .MentionSection(_,let keywords):
                return keywords.count
            }
        }
        
        var description : String{
            get {
                switch self {
                case .Media:
                    return "Images"
                case .MentionSection(let mentionHeader, _):
                    return mentionHeader
                }
            }
        }
    }
    
    
    // MARK: - Table lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].getRowCount() ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        //= tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        switch sections![indexPath.section] {
        case .Media(let media):
            let imageCell = tableView.dequeueReusableCellWithIdentifier("Image", forIndexPath: indexPath) as! ImageTableViewCell
            
            imageCell.imageUrl = media[indexPath.row].url
            cell = imageCell
            break
        case .MentionSection(_, let keywords):
            let labelCell = tableView.dequeueReusableCellWithIdentifier("Label", forIndexPath: indexPath) as! LabelTableViewCell
            labelCell.label = keywords[indexPath.row].keyword
            cell = labelCell
            
        }
        return cell // we know that is was definitely initialized
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections![section].description
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = sections![indexPath.section]
        switch section {
        case .Media(let media):
            return tableView.bounds.size.width / CGFloat(media[indexPath.row].aspectRatio)
        case .MentionSection:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = sections![indexPath.section]
        switch section {
        case .Media(let media):
            //TODO make it cassini!
            break
        case .MentionSection(let selectionType,let keywords):
            let keyword = keywords[indexPath.row].keyword
            if selectionType == "urls" {
                let url = NSURL(fileReferenceLiteral: keyword)
                UIApplication.sharedApplication().openURL(url)
            } else {
            
            
            }
            unwindForSegue(<#T##unwindSegue: UIStoryboardSegue##UIStoryboardSegue#>, towardsViewController: <#T##UIViewController#>)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
