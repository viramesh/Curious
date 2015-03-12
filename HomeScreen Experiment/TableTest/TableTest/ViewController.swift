//
//  ViewController.swift
//  TableTest
//
//  Created by viramesh on 3/11/15.
//  Copyright (c) 2015 vbits. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var photoFeed: UITableView!
    var photos: [NSDictionary]! = []
    var photoImages: [UIImageView] = []
    var usernames: [String] = []
    
    var topPhotoIndexRow:Int = 0
    var newHeight:CGFloat! = 200
    var newAlpha:CGFloat!
    var newScale:CGFloat!
    
    var TOP_alpha:CGFloat! = 0.2
    var BOTTOM_alpha:CGFloat! = 0.7
    var TOP_scale:CGFloat! = 1.5
    var BOTTOM_scale:CGFloat! = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoFeed.delegate = self
        photoFeed.dataSource = self
        
        newAlpha = TOP_alpha
        newScale = TOP_scale
        
        var clientId = "021a043c6d1a47008bef8e044e9da742"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=021a043c6d1a47008bef8e044e9da742")!
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            if(data != nil) {
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as [NSDictionary]
            self.initializeData()
            }

        }
        
    }
    
    func initializeData() {
        for var i=0; i<photos.count; ++i {
            var photo = photos[i] as NSDictionary
            var user = photo["user"] as NSDictionary
            usernames.append(user["full_name"] as String!)
            
            var photoURLs = photo["images"] as NSDictionary
            var stdImage = photoURLs["standard_resolution"] as NSDictionary
            var photoImage = UIImageView()
            photoImage.setImageWithURL(NSURL(string: stdImage["url"] as String!))
            photoImages.append(photoImage)
        }
        
        let delay = 1.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.photoFeed.reloadData()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("demoCellId", forIndexPath: indexPath) as DemoTableViewCell
        
        cell.name.text = usernames[indexPath.row]
        cell.poster.image = photoImages[indexPath.row].image
        
        if(indexPath.row < topPhotoIndexRow) {
            cell.mask.alpha = TOP_alpha
            cell.name.transform = CGAffineTransformMakeScale(TOP_scale, TOP_scale)
            cell.name.center.y = 100
        }
        else if(indexPath.row == topPhotoIndexRow) {
            cell.mask.alpha = newAlpha
            cell.name.transform = CGAffineTransformMakeScale(newScale, newScale)
            cell.name.center.y = newHeight/2
        }
        else {
            cell.mask.alpha = BOTTOM_alpha
            cell.name.transform = CGAffineTransformMakeScale(BOTTOM_scale, BOTTOM_scale)
            cell.name.center.y = 50
        }
        
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row < topPhotoIndexRow) { return 200 }
        else if(indexPath.row == topPhotoIndexRow) { return newHeight }
        else { return 100 }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var visiblePhotos = photoFeed.indexPathsForVisibleRows() as [NSIndexPath]
        
        var rectInTableView: CGRect = photoFeed.rectForRowAtIndexPath(visiblePhotos[1])
        
        var rectInSuperview: CGRect = photoFeed.convertRect(rectInTableView, toView: photoFeed.superview)
        
        newHeight = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, 200, 200, 100))
        newAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, 200, Float(self.TOP_alpha), Float(self.BOTTOM_alpha)))
        newScale = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, 200, Float(self.TOP_scale), Float(self.BOTTOM_scale)))
        topPhotoIndexRow = visiblePhotos[1].row
        
        photoFeed.reloadData()


    }

}

