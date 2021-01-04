//
//  Move.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/24/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int

    init(column: Int) {
        self.column = column
    }
}

/*  If you remember nothing else, remember this: to simulate a move, GameplayKit takes copies of our board state, finds all possible moves that can happen, and applies them all on different copies.*/
