//
//  git_pull.h
//  git_pull
//
//  Created by Watson on 11/05/02.
//  Copyright (c) 2011 __MyCompanyName__, All Rights Reserved.
//

#import <Cocoa/Cocoa.h>
#import <Automator/AMBundleAction.h>

@interface git_pull : AMBundleAction 
{
    IBOutlet id repository;
    IBOutlet id rebase;
}

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
