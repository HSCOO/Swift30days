//
//  Interest.swift
//  Swift05
//
//  Created by 胡生才 on 2019/6/21.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class Interest{
    var title = ""
    var feturedImage: UIImage!
    
    init(title: String, feturedImage:UIImage!) {
        self.title = title
        self.feturedImage = feturedImage
    }
    
    static func createInterests() -> [Interest]{
        return [
            Interest(title: "Hello there, i miss u.", feturedImage: UIImage(named: "hello")!),
            Interest(title: "🐳🐳🐳🐳🐳", feturedImage: UIImage(named: "dudu")!),
            Interest(title: "Training like this, #bodyline", feturedImage: UIImage(named: "bodyline")!),
            Interest(title: "I'm hungry, indeed.", feturedImage: UIImage(named: "wave")!),
            Interest(title: "Dark Varder, #emoji", feturedImage: UIImage(named: "darkvarder")!),
            Interest(title: "I have no idea, bitch", feturedImage: UIImage(named: "hhhhh")!)
        ]
    }
    
}
