//
//  git_add.h
//

#import <Cocoa/Cocoa.h>
#import <Automator/AMBundleAction.h>
#import <Automator/AMAction.h>

@interface git_add : AMBundleAction 
{
}

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
