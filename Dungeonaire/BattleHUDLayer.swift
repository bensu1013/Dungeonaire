//
//  BattleHUDLayer.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/5/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class BattleHUDLayer: UIView {
    
    @IBOutlet weak var unit1: UILabel!
    
    @IBAction func skill1(_ sender: Any) {
        print("pressed")
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        addSubview(view)
    }
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! UIView
 
      
        
        return view
    }

}
