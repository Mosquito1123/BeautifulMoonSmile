//
//  LunarHeaderView.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import UIKit

final class LunarHeaderView: UIView {
    
    @IBOutlet weak var phaseView: LunarPhaseView!
    @IBOutlet weak var phaseNameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var illuminationLabel: UILabel!
    
    @IBOutlet weak var riseTitleLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    
    @IBOutlet weak var setTitleLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    var viewModel: LunarViewModel? {
        didSet {
            self.riseTitleLabel.isHidden = false
            self.riseLabel.text = viewModel?.rise
            
            self.setTitleLabel.isHidden = false
            self.setLabel.text = viewModel?.set
            
            self.ageLabel.text = viewModel?.age
            self.illuminationLabel.text = viewModel?.illumination
            
            if let phase = viewModel?.phase {
                guard let font = UIFont(name: "EuphemiaUCAS", size: 38.0) else { return }
                let color = UIColor.white
                let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
                self.phaseNameLabel.attributedText = NSAttributedString(string: phase, attributes: attributes)
            }
            
            UIView.animate(withDuration: 0.5) {
                self.phaseView.alpha = 1.0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.phaseView.alpha = 0.0
        self.phaseNameLabel.text = NSLocalizedString("Loading...", comment: "Loading...")
        self.ageLabel.text = ""
        self.illuminationLabel.text = ""
        self.riseLabel.text = ""
        self.setLabel.text = ""
        self.riseTitleLabel.isHidden = true
        self.setTitleLabel.isHidden = true
        
        self.phaseNameLabel.textColor = UIColor.white
        self.ageLabel.textColor = UIColor.white
        self.illuminationLabel.textColor = UIColor.white
        self.riseLabel.textColor = UIColor.white
        self.setLabel.textColor = UIColor.white
        
        self.backgroundColor = UIColor.clear
    }
}
