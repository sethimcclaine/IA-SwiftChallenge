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
    
    var blackDotUnlocked:Bool = true;
    var blueDotUnlocked:Bool = true;
    var redDotUnlocked:Bool = true;
    var greenDotUnlocked:Bool = true;
    var blackDot2Unlocked:Bool = true;
    
    var blackCellOpen:Bool = true;
    var blueCellOpen:Bool = true;
    var redCellOpen:Bool = true;
    var greenCellOpen:Bool = true;
    var blackCell2Open:Bool = true;
    
    var blackDotEnd:CGPoint = CGPointMake(378.4, 426.4)     //position:{378.39999, 426.39999}
    var blueDotEnd:CGPoint = CGPointMake(523.2, 518.4)      //position:{523.20001, 518.40002}
    var redDotEnd:CGPoint = CGPointMake(639.2, 504.0)       //position:{639.20001, 504}
    var greenDotEnd:CGPoint = CGPointMake(438.4, 334.4)     //position:{438.39999, 334.3999}
    var blackDot2End:CGPoint = CGPointMake(615.2, 364.8)    //position:{615.20001, 364.80002}
    
    var resetBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton;
    var currentNodeTouched = SKNode();
    //var unlockedDots:NSMutableArray = []
    
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
        background.name = "bg";
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

        nameDots();
        
        unlockDots()
        
        positionDots();
        
        self.addChild(blackDot);
        self.addChild(blueDot);
        self.addChild(redDot);
        self.addChild(greenDot);
        self.addChild(blackDot2);
        
    }
    
    //Position dots in a line at bottom of screen
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
    
    //Name the dots so its easier to see which one we are referencing
    func nameDots() {
        blackDot.name = "blackDot";
        blueDot.name = "blueDot";
        redDot.name = "redDot";
        greenDot.name = "greenDot";
        blackDot2.name = "blackDot2";
    }
    
    //Change unlock vars so dots can move again
    func unlockDots() {
        //Dots
        blackDotUnlocked = true;
        blueDotUnlocked = true;
        redDotUnlocked = true;
        greenDotUnlocked = true;
        blackDot2Unlocked = true;
        //Cells
        blackCellOpen = true;
        blueCellOpen = true;
        redCellOpen = true;
        greenCellOpen = true;
        blackCell2Open = true;
    }
    
    //Move dots back and unlock them
    func resetAction(sender:UIButton!) {
        println("Reset");
        positionDots();
        unlockDots();
    }
    
    //Check if the dot is near a given holding cell
    func compareLocations(pos:CGPoint) -> Bool {
        var maxDif:Int = 25;
        
        var difX:Int = abs(Int(pos.x) - Int(currentNodeTouched.position.x))
        var difY:Int = abs(Int(pos.y) - Int(currentNodeTouched.position.y))
        if(difX < maxDif && difY < maxDif) {
            return true;
        }
        return false;
    }
    
    //if dot is near a valide holding cell lock it, and mark that cell as used
    func checkDotLocation() {
        var name:String = currentNodeTouched.name;
        switch name {
        case "blackDot":
            if (blackCellOpen && compareLocations(blackDotEnd)) {
                blackCellOpen = false;
                blackDotUnlocked = false;
                currentNodeTouched.position = blackDotEnd;
            } else if (blackCell2Open && compareLocations(blackDot2End)) {
                blackCell2Open = false
                blackDotUnlocked = false;
                currentNodeTouched.position = blackDot2End;
            }
            break
        case "blackDot2":
           if (blackCellOpen && compareLocations(blackDotEnd)) {
                blackCellOpen = false;
                blackDot2Unlocked = false;
                currentNodeTouched.position = blackDotEnd;
            } else if (blackCell2Open && compareLocations(blackDot2End)) {
                blackCell2Open = false
                blackDot2Unlocked = false;
                currentNodeTouched.position = blackDot2End;
            }
            break
        case "blueDot":
            if (blueCellOpen && compareLocations(blueDotEnd)) {
                blueCellOpen = false;
                blueDotUnlocked = false;
                currentNodeTouched.position = blueDotEnd;
            }
            break
        case "redDot":
            if (redCellOpen && compareLocations(redDotEnd)) {
                redCellOpen = false;
                redDotUnlocked = false;
                currentNodeTouched.position = redDotEnd;
            }
            break
        case "greenDot":
            if (greenCellOpen && compareLocations(greenDotEnd)) {
                greenCellOpen = false;
                greenDotUnlocked = false;
                currentNodeTouched.position = greenDotEnd;
            }
            break
        default:
            break;
        }
    }
    //Check if dot is available to move
    func isUnlocked(dot:String) -> Bool {
        switch dot {
        case "blackDot":
            return blackDotUnlocked
        case "blueDot":
            return blueDotUnlocked
        case "redDot":
            return redDotUnlocked
        case "greenDot":
            return greenDotUnlocked
        case "blackDot2":
            return blackDot2Unlocked
        default:
            return false;
        }
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var nodeTouched = SKNode();
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            nodeTouched = self.nodeAtPoint(location);
            var unlocked:Bool = isUnlocked(nodeTouched.name)
            if(unlocked) {
                currentNodeTouched = nodeTouched
            }
        }
    }
    //update position of dot and check if dot is in right position
    func moveDot(touches: NSSet, event: UIEvent) {
        for touch: AnyObject in touches {
            var unlocked:Bool = isUnlocked(currentNodeTouched.name)
            if(unlocked) {
                currentNodeTouched.position = touch.locationInNode(self)
                checkDotLocation();
            }
        }
    } 
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        moveDot(touches, event:event)
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        moveDot(touches, event:event)
    }

}