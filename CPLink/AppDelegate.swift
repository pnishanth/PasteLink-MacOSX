//
//  AppDelegate.swift
//  CPLink
//
//  Created by Nishanth P on 2/11/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        item?.image = NSImage(named:"link")
        item?.action = #selector(AppDelegate.cplink)
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Link",action:#selector(AppDelegate.cplink),keyEquivalent: "L"))
        menu.addItem(NSMenuItem(title: "Quit!",action:#selector(AppDelegate.Quit), keyEquivalent: "Q"))
        
        item?.menu = menu
        
    }
    
    func cplink(){
        
        if let items = NSPasteboard.general().pasteboardItems
        {
            for item in items {
                
                for type in item.types{
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: type){
                            
                            NSPasteboard.general().clearContents()
                            var correctUrl = ""
                            
                            if url.hasPrefix("http://") || url.hasPrefix("https://"){
                                
                                correctUrl = url
                                
                            }else{
                                
                                correctUrl = "http://\(url)"
                                
                            }
                            
                            NSPasteboard.general().setString("<a href=\"\(correctUrl)\">\(url)</a>",forType:"public.html")
                            
                            NSPasteboard.general().setString(url,forType:"public.utf8-plain-text")

                        }
                    }
                }
                
            }
        }

        
        
        
    }
    
    func Quit(){
        print("Quit")
        NSApplication.shared().terminate(self)
    }

    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

