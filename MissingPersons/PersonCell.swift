//
//  PersonCell.swift
//  MissingPersons
//
//  Created by Alex Nguyen on 2016-05-06.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    @IBOutlet weak var personImg: UIImageView!
    var person: Person!
    
    func configureCell(person: Person) {
        self.person = person
        if let url = NSURL(string: "\(baseURL)\(person.personImageUrl!)") {
            downloadImg(url)
        }
    }
    
    func downloadImg(url: NSURL) {
        getDataFromUrl(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                self.personImg.image = UIImage(data: data)
                self.person.personImage = self.personImg.image
            }
        }
    }
    
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
        }.resume()
    }
    func setSelected() {
        personImg.layer.borderWidth = 2.0
        personImg.layer.borderColor = UIColor.yellowColor().CGColor
        self.person.downloadFaceId()
    }
}
