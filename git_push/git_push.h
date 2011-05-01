//
//  git_push.h
//  git_push
//
//  Created by Watson on 11/05/02.
//  Copyright (c) 2011 __MyCompanyName__, All Rights Reserved.
//

#import <Cocoa/Cocoa.h>
#import <Automator/AMBundleAction.h>

@interface git_push : AMBundleAction 
{
    IBOutlet id repository;
}

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
