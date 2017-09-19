//
//  GameScene.swift
//  Gameoflife
//
//  Created by Michael Wheeler on 9/19/17.
//  Copyright © 2017 Michael Wheeler. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var stepButton: MSButtonNode!
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    
    var gridNode: Grid!
    
    override func didMove(to view: SKView){
        stepButton = childNode(withName: "stepButton") as! MSButtonNode
        populationLabel = childNode(withName: "populationLabel") as! SKLabelNode
        generationLabel = childNode(withName: "generationLabel") as! SKLabelNode
        playButton = childNode(withName: "playButton") as! MSButtonNode
        pauseButton = childNode(withName: "pauseButton") as! MSButtonNode
        
        gridNode = childNode(withName: "gridNode") as! Grid
        
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
        let delay = SKAction.wait(forDuration: 0.5)
        
        let callMethod = SKAction.perform(#selector(stepSimulation), onTarget: self)
        
        let stepSquence = SKAction.sequence([delay,callMethod])
        
        let simulation = SKAction.repeatForever(stepSquence)
        
        self.run(simulation)
        
        self.isPaused = true
        
        playButton.selectedHandler = { [unowned self] in self.isPaused = false}
        
        pauseButton.selectedHandler = { [unowned self] in self.isPaused = true}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func stepSimulation() {
        gridNode.evolve()
        
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
}
