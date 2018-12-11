//
//  Ticket.swift
//  SaleTickets
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import Foundation

class Ticket: NSObject {
    // 定义票数变量
    var number: Int?
    // 定义单例对象
    static let shareTicket = Ticket()
    
    private override init() {
        
    }
}
