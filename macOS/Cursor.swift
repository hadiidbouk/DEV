//
//  Cursor.swift
//  DEV (macOS)
//
//  Created by Hadi on 27/03/2021.
//

import SwiftUI

func changeCursor(to cursor: NSCursor, _ inside: Bool) {
    inside ? cursor.push() : NSCursor.pop()
}
