//
//  git_commit.m
//

#import "git_commit.h"


@implementation git_commit

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
	// Add your code here, returning the data to be passed to the next action.
	NSEnumerator *enumerate = [input objectEnumerator];
	NSString *path    = [enumerate nextObject];
	NSString *message = [commitMessage stringValue];
    NSString *cmd     = [NSString stringWithFormat: @"PATH=/opt/local/bin:/usr/local/bin:/usr/local/git/bin; git commit -m '%@'", message];

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
	
	[task release];
	[pipe release];
	
	if([result length] > 0) {
		NSArray *objsArray = [NSArray arrayWithObject:result];
		NSArray *keysArray = [NSArray arrayWithObject:@"OSAScriptErrorMessage"];
		*errorInfo = [NSDictionary dictionaryWithObjects:objsArray forKeys:keysArray];
		return nil;
	}
	return input;
	
	return input;
}

@end
