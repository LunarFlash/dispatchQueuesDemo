//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by Hossam Ghareeb on 11/15/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//  http://www.appcoda.com/ios-concurrency/

import UIKit

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "http://algoos.com/wp-content/uploads/2015/08/ireland-02.jpg", "http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg"]

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickOnStart(sender: AnyObject) {
        /****** Concurrent Dispatch Queue *****/
         /*
        // get a reference to the default concurrent queue using dispatch_get_global_queue
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) { () -> Void in
            
            // inside the block we submit a task which is to download the first image.
            let image1 = Downloader.downloadImageWithURL(imageURLs[0])
            
            // Once the image download completes, we submit another task to the main queue to update the image view with the downloaded image. 
            // In other words, we put the image download task in a background thread, but execute the UI related tasks in the main queue.
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView1.image = image1
            })
        }
        
        dispatch_async(queue) { () -> Void in
            let image2 = Downloader.downloadImageWithURL(imageURLs[1])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView2.image = image2
            })
        }
        
        dispatch_async(queue) { () -> Void in
            let image3 = Downloader.downloadImageWithURL(imageURLs[2])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView3.image = image3
            })
        }
        
        dispatch_async(queue) { () -> Void in
            let image4 = Downloader.downloadImageWithURL(imageURLs[3])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView4.image = image4
            })
        }
        */
        
        /****** Serial Dispatch Queue ******/
        /*
        let serialQueue = dispatch_queue_create("com.vento.yi", DISPATCH_QUEUE_SERIAL)
        dispatch_async(serialQueue) { () -> Void in
            let image1 = Downloader.downloadImageWithURL(imageURLs[0])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView1.image = image1
            })
        }
        
        dispatch_async(serialQueue) { () -> Void in
            let image2 = Downloader.downloadImageWithURL(imageURLs[1])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView2.image = image2
            })
        }
        
        dispatch_async(serialQueue) { () -> Void in
            let image3 = Downloader.downloadImageWithURL(imageURLs[2])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView3.image = image3
            })
        }
        dispatch_async(serialQueue) { () -> Void in
            let image4 = Downloader.downloadImageWithURL(imageURLs[3])
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView4.image = image4
            })
        }
        */
        
        /****** NSOperation Queues ******/
        let queue = NSOperationQueue()
        
        queue.addOperationWithBlock { () -> Void in
            
            let image1 = Downloader.downloadImageWithURL(imageURLs[0])
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView1.image = image1
            })
        }
        
        queue.addOperationWithBlock { () -> Void in
            let image2 = Downloader.downloadImageWithURL(imageURLs[1])
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView2.image = image2
            })
        }
        
        queue.addOperationWithBlock { () -> Void in
            let image3 = Downloader.downloadImageWithURL(imageURLs[2])
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView3.image = image3
            })
        }
        
        queue.addOperationWithBlock { () -> Void in
            let image4 = Downloader.downloadImageWithURL(imageURLs[3])
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView4.image = image4
            })
        }
        
        
        
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }

}

