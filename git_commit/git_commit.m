//
//  git_commit.m
//

#import "git_commit.h"


@implementation git_commit

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
    NSEnumerator *enumerate = [input objectEnumerator];
    NSString *path    = [enumerate nextObject];
    NSString *message = [commitMessage stringValue];
    NSString *cmd     = [NSString stringWithFormat: @"PATH=/opt/local/bin:/usr/local/bin:/usr/local/git/bin:/usr/bin; git commit -m '%@'", message];

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

    if([result length] > 0) {
	NSArray *objsArray = [NSArray arrayWithObject:result];
	NSArray *keysArray = [NSArray arrayWithObject:@"OSAScriptErrorMessage"];
	*errorInfo = [NSDictionary dictionaryWithObjects:objsArray forKeys:keysArray];
	return nil;
    }
    return input;
}

@end
