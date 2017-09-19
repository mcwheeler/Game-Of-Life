//
//  Grid.swift
//  Gameoflife
//
//  Created by Michael Wheeler on 9/19/17.
//  Copyright © 2017 Michael Wheeler. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    let rows = 8
    let columns = 10
    
    var cellWidth = 0
    var cellHeight = 0
    
    var gridArray = [[Creature]]()
    
    var generation = 0
    var population = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        let gridX = Int(location.x) / cellWidth
        let gridY = Int(location.y) / cellHeight
        
        let creature = gridArray[gridX][gridY]
        creature.isAlive = !creature.isAlive
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        isUserInteractionEnabled = true
        
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        
        populateGrid()
    }
    
    func addCreatureAtGrid(x: Int, y: Int){
        let creature = Creature()
        
        let gridPosition = CGPoint(x: x*cellWidth, y: y*cellHeight)
        creature.position = gridPosition
        
        creature.isAlive = false
        
        addChild(creature)
        
        gridArray[x].append(creature)
    }
    
    func populateGrid(){
        for gridX in 0..<columns {
            gridArray.append([])
            
            for gridY in 0..<rows {
                addCreatureAtGrid(x: gridX, y: gridY)
            }
        }
    }
    
    func countNeighbors(){
        
        for gridX in 0..<columns{
            
            for gridY in 0..<rows{
                
                let currentCreture = gridArray[gridX][gridY]
                
                currentCreture.neighborCount = 0
                
                for innerGridX in (gridX - 1)...(gridX + 1){
                    
                    if innerGridX<0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY - 1)...(gridY + 1){
                        
                        if innerGridY<0 || innerGridY >= rows { continue }
                        
                        if innerGridX == gridX && innerGridY == gridY { continue }
                        
                        let adjectentCreature:Creature = gridArray[innerGridX][innerGridY]
                        
                        if adjectentCreature.isAlive{
                            currentCreture.neighborCount += 1
                        }
                    }
                }
            }
        }
    }
    
    func updateCreatures(){
        population = 0
        
        for gridX in 0..<columns {
            
            for gridY in 0..<rows {
                
                let currentCreature = gridArray[gridX][gridY]
                
                switch currentCreature.neighborCount {
                case 3:
                    currentCreature.isAlive = true
                    break;
                case 0...1, 4...8:
                    currentCreature.isAlive = false
                    break;
                default:
                    break;
                }
                
                if currentCreature.isAlive { population = 1 }
            }
        }
    }
    
    func evolve(){
        
        countNeighbors()
        
        updateCreatures()
        
        generation += 1
    }
}
