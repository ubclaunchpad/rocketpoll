//
//  CampaignViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CampaignViewContainer: UIScrollView {
  
  func populateCampaignViews(questions: [Question]) {
    // TODO:
    // for Question in database: use CampaignView.instanceFromNib() and add to current view
    // you'll want to attach a frame to the campaignview and this frame will be incremented in the y position
    
    let campaignViewHeight: CGFloat = 100
    let campaignViewFrame = CGRectMake(0, 0, frame.size.width, campaignViewHeight) // 100 is the height of the campaignView
    
    for question in questions {
      print(question)

      let campaignView = CampaignView.instanceFromNib(campaignViewFrame)
      addSubview(campaignView)
      
      frame.origin.y += campaignViewHeight
    }
    
  }
  
}
