//
//  Skater.swift
//  SchoolhouseSkateboarder
//
//  Created by Виталий on 12/07/2019.
//  Copyright © 2019 Aperantim. All rights reserved.
//

import SpriteKit

class Skater: SKSpriteNode {
    var velocity = CGPoint.zero
    var minimumY: CGFloat = 0.0
    var jumpSpeed: CGFloat = 20.0
    var isOnGround = true
    
    func setupPhysicsBody() {
        
        if let skaterTexture = texture {
            physicsBody = SKPhysicsBody(texture: skaterTexture, size: size)
            
            physicsBody?.isDynamic = true //подтверждаем, что движения этого объекта должны управляться физическим движком.
            physicsBody?.density = 6.0
            physicsBody?.allowsRotation = false
            physicsBody?.angularDamping = 1.0 //Угловая амплитуда описывает, насколько сильно физическое тело сопротивляется вращению.
            physicsBody?.categoryBitMask = PhysicsCategory.skater //Задаем соответствие между категорией скейтбордистки и фи- зической категорией skater
            physicsBody?.collisionBitMask = PhysicsCategory.brick //устанавливаем значение collisionBitMask равным значению ка- тегории brick
            physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem //Сообщаем SpriteKit, что хотим знать, когда у скейтбордистки возникает контакт с любым из этих типов объектов.
            
            
        }
    }
    
    //add sparks
    func createSparks() {
        
        // Находим файл эмиттера искр в проекте
        let bundle = Bundle.main
        if let sparksPath = bundle.path(forResource: "sparks", ofType: "sks") {
        
        // Создаем узел эмиттера искр

            let sparksNode = NSKeyedUnarchiver.unarchiveObject(withFile: sparksPath) as! SKEmitterNode
            sparksNode.position = CGPoint(x: 0.0, y: -50.0)
            addChild(sparksNode)
            
            // Производим действие, ждем полсекунды, а затем удаляем эмиттер
            let waitAction = SKAction.wait(forDuration: 0.5)
            let removeAction = SKAction.removeFromParent()
            let waitThenRemove = SKAction.sequence([waitAction, removeAction])
            sparksNode.run(waitThenRemove)
        
        }
    }
    
}


