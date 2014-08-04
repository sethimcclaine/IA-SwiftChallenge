//
//  GameScene.swift
//  swiftChallenge
//
//  Created by Seth McClaine on 7/29/14.
//  Copyright (c) 2014 InspiringApps. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var background:SKSpriteNode = SKSpriteNode(imageNamed: "bg");
    var blackDot:SKSpriteNode = SKSpriteNode(imageNamed: "blackDot");
    var blueDot:SKSpriteNode = SKSpriteNode(imageNamed: "blueDot");
    var redDot:SKSpriteNode = SKSpriteNode(imageNamed: "redDot");
    var greenDot:SKSpriteNode = SKSpriteNode(imageNamed: "greenDot");
    var blackDot2:SKSpriteNode = SKSpriteNode(imageNamed: "blackDot");
    var resetBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton;
    var currentNodeTouched = SKNode()
    
    override func didMoveToView(view: SKView) {
        println("test");
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Zapfino")
        myLabel.text = "Inspiring Apps";
        myLabel.fontSize = 36;
        myLabel.fontColor = SKColor.grayColor()
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height * 0.75);
        
        self.addChild(myLabel)

        //Update background color
        self.backgroundColor = SKColor.whiteColor();
        
       
        let dotHeight = blackDot.size.height
        let hCenter = self.frame.size.width/2;
        let dotWidth = blackDot.size.width;
        let scale = ((frame.size.height/2) / background.size.width) * blackDot.size.width;
        
        //Update dot sizes to scale
        blackDot.size.width = scale;
        blackDot.size.height = scale;
        blueDot.size.width = scale;
        blueDot.size.height = scale;
        redDot.size.width = scale;
        redDot.size.height = scale;
        greenDot.size.width = scale;
        greenDot.size.height = scale;
        blackDot2.size.width = scale;
        blackDot2.size.height = scale;
        
        //position background
        background.size.width = frame.size.height/2;
        background.size.height = frame.size.height/2;
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        
        //Give a "class" name
        blackDot.name = "dot";
        blueDot.name = "dot";
        redDot.name = "dot";
        greenDot.name = "dot";
        blackDot2.name = "dot";
        
        
        //Give initial position
        blackDot.position = CGPointMake(hCenter - (dotWidth * 2), dotHeight);
        blueDot.position = CGPointMake(hCenter - dotWidth, dotHeight);
        redDot.position = CGPointMake(hCenter, dotHeight);
        greenDot.position = CGPointMake(hCenter + dotWidth, dotHeight);
        blackDot2.position = CGPointMake(hCenter + (dotWidth * 2), dotHeight);
    
        self.addChild(background);
        self.addChild(blackDot);
        self.addChild(blueDot);
        self.addChild(redDot);
        self.addChild(greenDot);
        self.addChild(blackDot2);
        //Reset Button
        resetBtn.frame = CGRectMake(230, 50, 50, 25);
        resetBtn.backgroundColor = UIColor.lightGrayColor();
        resetBtn.setTitle("Reset", forState: UIControlState.Normal)
        resetBtn.addTarget(self, action: "resetAction:", forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(resetBtn);
    }
    
    func resetAction(sender:UIButton!)
    {
        println("Button tapped")
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        var nodeTouched = SKNode();
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            nodeTouched = self.nodeAtPoint(location);
            println(nodeTouched);
            if(nodeTouched.name? == "dot") {
                //character.position=location
                currentNodeTouched = nodeTouched
            } else {
                currentNodeTouched.name = ""
            }
        }
    }
   
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            var nodeTouched = SKNode()
            nodeTouched = self.nodeAtPoint(location)
            
            if(currentNodeTouched.name == "dot") {
                currentNodeTouched.position = location
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            var nodeTouched = SKNode()
            nodeTouched = self.nodeAtPoint(location)
            
            if(currentNodeTouched.name == "dot") {
                currentNodeTouched.position = location
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
