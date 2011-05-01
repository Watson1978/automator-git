//
//  git_push.m
//  git_push
//
//  Created by Watson on 11/05/02.
//  Copyright (c) 2011 Watson, All Rights Reserved.
//

#import "git_push.h"


@implementation git_push

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
    NSEnumerator *enumerate = [input objectEnumerator];
    NSString *path = [enumerate nextObject];
    NSString *repo = [repository stringValue];
    NSString *cmd  = [NSString stringWithFormat: @"PATH=/opt/local/bin:/usr/local/bin:/usr/local/git/bin:/usr/bin; git push %@", repo];

    NSTask *task  = [[NSTask alloc] init];
    NSPipe *pipe  = [[NSPipe alloc] init];

    [task setLaunchPath: @"/bin/sh"];
    [task setCurrentDirectoryPath: path];
    [task setArguments: [NSArray arrayWithObjects: @"-c", cmd, nil]];

    [task setStandardError: pipe];
    [task launch];

    NSFileHandle *handle = [pipe fileHandleForReading];
    NSData *data = [handle  readDataToEndOfFile];
    NSString *result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];

    [cmd release];
    [task release];
    [pipe release];

    return input;
}

@end
