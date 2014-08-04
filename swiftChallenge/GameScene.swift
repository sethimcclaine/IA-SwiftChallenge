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
    var currentNodeTouched = SKNode();
    
    override func didMoveToView(view: SKView) {
        let scale:CGFloat = CGFloat((frame.size.height/2) / background.size.width);
        initLabel()
        initBackground()
        initReset()
        initDots(scale)
    }
    
    //Build and add IA label
    func initLabel() {
        let myLabel = SKLabelNode(fontNamed:"Zapfino")
        myLabel.text = "Inspiring Apps";
        myLabel.fontSize = 36;
        myLabel.fontColor = SKColor.grayColor()
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height * 0.75);
        
        self.addChild(myLabel)
    }
    
    //Build and add background
    func initBackground() {
        self.backgroundColor = SKColor.whiteColor();
        background.size.width = frame.size.height/2;
        background.size.height = frame.size.height/2;
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        background.name = "locked";
        self.addChild(background);
    }
    
    //Build and add reset button
    func initReset() {
        resetBtn.frame = CGRectMake(230, 50, 50, 25);
        resetBtn.backgroundColor = UIColor.lightGrayColor();
        resetBtn.setTitle("Reset", forState: UIControlState.Normal)
        resetBtn.addTarget(self, action: "resetAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(resetBtn);
    }
    
    //Build and add dots
    func initDots(scale: CGFloat) {
        sizeDot(blackDot, scale:scale)
        sizeDot(blueDot, scale:scale)
        sizeDot(redDot, scale:scale)
        sizeDot(greenDot, scale:scale)
        sizeDot(blackDot2, scale:scale)

        unlockDots()
        
        positionDots();
        
        self.addChild(blackDot);
        self.addChild(blueDot);
        self.addChild(redDot);
        self.addChild(greenDot);
        self.addChild(blackDot2);
        
    }
    //position dots in a line at bottom of screen 
    func positionDots() {
       
        let dotHeight = blackDot.size.height
        let hCenter = self.frame.size.width/2;
        let dotWidth = blackDot.size.width;
        
        //Give initial position
        blackDot.position = CGPointMake(hCenter - (dotWidth * 2), dotHeight);
        blueDot.position = CGPointMake(hCenter - dotWidth, dotHeight);
        redDot.position = CGPointMake(hCenter, dotHeight);
        greenDot.position = CGPointMake(hCenter + dotWidth, dotHeight);
        blackDot2.position = CGPointMake(hCenter + (dotWidth * 2), dotHeight);  
    }
    
    //Update dot sizes to scale
    func sizeDot(dot:SKSpriteNode, scale:CGFloat) {
        dot.size.width = CGFloat(scale * dot.size.width);
        dot.size.height = CGFloat(scale * dot.size.height);
        
    }
    //change name to unlock so move event listens to them
    func unlockDots() {
        blackDot.name = "unlocked";
        blueDot.name = "unlocked";
        redDot.name = "unlocked";
        greenDot.name = "unlocked";
        blackDot2.name = "unlocked";
    }
    //move dots back and unlock them
    func resetAction(sender:UIButton!) {
        positionDots();
        unlockDots()
    }
    //update position of dot and check if dot is in right position
    func moveDot(touches: NSSet, event: UIEvent) {
        for touch: AnyObject in touches {
            if(currentNodeTouched.name == "unlocked") {
                currentNodeTouched.position = touch.locationInNode(self)
                checkDotLocation();
            }
        }
    }
    func checkDotLocation() {

    }
    

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        var nodeTouched = SKNode();
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            nodeTouched = self.nodeAtPoint(location);
            println(nodeTouched);
            if(nodeTouched.name? == "unlocked") {
                //character.position=location
                currentNodeTouched = nodeTouched
            } /*else {
                currentNodeTouched.name = ""
            }*/
        }
    }
     
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        moveDot(touches, event:event)
/*
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            var nodeTouched = SKNode()
            nodeTouched = self.nodeAtPoint(location)
            
            if(currentNodeTouched.name == "unlocked") {
                currentNodeTouched.position = location
            }
        }
*/
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        moveDot(touches, event:event)
/*
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            var nodeTouched = SKNode()
            nodeTouched = self.nodeAtPoint(location)
            
            if(currentNodeTouched.name == "unlocked") {
                currentNodeTouched.position = location
            }
        }
*/
    }

}