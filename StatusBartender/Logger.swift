//
//  Logger.swift
//  StatusBartender
//  
//  Created by shsw228 on 2023/12/09
//


import Foundation
import os

public enum Logger {
    public static let standard: os.Logger = .init(subsystem: Bundle.main.bundleIdentifier!,
                                                  category: "Standard")
}
