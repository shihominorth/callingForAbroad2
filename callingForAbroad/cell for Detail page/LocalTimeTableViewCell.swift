//
//  TableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-17.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class LocalTimeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var LocalTimeLabel: UILabel!
    
    func updateText(date: Date) -> String{
        LocalTimeLabel.text = date.convertToString(dateformat: .dateWithTime)
        
        return date.convertToString(dateformat: .dateWithTime)
    }
    
    func giveText(date: Date) -> String {
        return date.convertToString(dateformat: .dateWithTime)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
