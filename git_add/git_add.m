//
//  git_add.m
//

#import "git_add.h"

@implementation git_add

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
    NSEnumerator *enumerate = [input objectEnumerator];
    NSString *path = [enumerate nextObject];

    NSTask *task  = [[NSTask alloc] init];
    NSPipe *pipe  = [[NSPipe alloc] init];

    [task setLaunchPath: @"/bin/sh"];
    [task setCurrentDirectoryPath: path];
    [task setArguments: [NSArray arrayWithObjects: @"-c", @"PATH=/opt/local/bin:/usr/local/bin:/usr/local/git/bin:/usr/bin; git add .", nil]];

    [task setStandardError: pipe];
    [task launch];

    NSFileHandle *handle = [pipe fileHandleForReading];
    NSData *data = [handle  readDataToEndOfFile];
    NSString *result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];

    [task release];
    [pipe release];

    if([result length] > 0) {
	NSArray *objsArray = [NSArray arrayWithObject:result];
	NSArray *keysArray = [NSArray arrayWithObject:@"OSAScriptErrorMessage"];
	*errorInfo = [NSDictionary dictionaryWithObjects:objsArray forKeys:keysArray];
	return nil;
    }
    return input;
}

@end
