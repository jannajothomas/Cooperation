//
//  GameComponents.swift
//  Cooperation
//
//  Created by Susan Jensen on 12/24/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import GameplayKit

class GameComponents: GKGameModel {
    var players: [GKGameModelPlayer]?
    
    var activePlayer: GKGameModelPlayer?
    
    func setGameModel(_ gameModel: GKGameModel) {
        <#code#>
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        <#code#>
    }
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        <#code#>
    }
    
    func isEqual(_ object: Any?) -> Bool {
        <#code#>
    }
    
    var hash: Int
    
    var superclass: AnyClass?
    
    func `self`() -> Self {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func isProxy() -> Bool {
        <#code#>
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        <#code#>
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        <#code#>
    }
    
    var description: String
    
    func copy(with zone: NSZone? = nil) -> Any {
        <#code#>
    }
    

}
