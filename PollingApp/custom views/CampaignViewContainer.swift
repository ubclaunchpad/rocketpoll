//
//  CampaignViewContainer.swift
//  PollingApp
//
//  Created by Gabriel Uribe on 2/6/16.
//  Copyright © 2016 Gabriel Uribe. All rights reserved.
//

import UIKit

class CampaignViewContainer: DynamicScrollView {
  
  init() {
    super.init(aClass: object_getClass(CampaignView()))
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  func populateCampaignViews(questions: [Question]) {
    let campaignViewHeight: CGFloat = 100
    var campaignViewFrame = CGRectMake(0, 0, bounds.width, campaignViewHeight)
    
    for question in questions {
      let campaignView = CampaignView.instanceFromNib(campaignViewFrame)
      campaignView.setQuestionText(question)
      addSubview(campaignView)
      
      campaignViewFrame.origin.y += campaignViewHeight
    }
    updateContentSize(campaignViewFrame.origin.y + campaignViewHeight)
  }
  
}
