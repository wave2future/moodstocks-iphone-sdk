/**
 * Copyright (c) 2010 Moodstocks SAS
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "RootViewController.h"

/**
 * PLEASE MAKE SURE TO REPLACE WITH YOU KEY/SECRET PAIR
 *
 * For more details, please refer to:
 * http://github.com/Moodstocks/moodstocks-api-kits/wiki/Developer-documentation
 */
static NSString* kMAPIKey    = @"ApIkEy";
static NSString* kMAPISecret = @"SeCrEtKeY";

@implementation RootViewController

@synthesize status  = _status;
@synthesize message = _message;
@synthesize matches = _matches;

- (void)takePicture {
    MImagePickerController * picker = [[MImagePickerController alloc] initWithKey:kMAPIKey andSecret:kMAPISecret];
    picker.delegate = self;
    [self presentModalViewController:picker animated:NO];
    [picker release];
}

#pragma mark -
#pragma mark MImagePickerControllerDelegate

- (void)imagePickerController:(MImagePickerController*)picker didFinishQueryingWithInfo:(NSDictionary *)info {
    [self dismissModalViewControllerAnimated:NO];
    
    NSDictionary* results = [info objectForKey:@"results"];
    
    self.status  = [info objectForKey:@"status"];
    self.message = [info objectForKey:@"message"];
    self.matches = [results objectForKey:@"matches"];
    
    if ([self.status isEqualToString:@"error"]) {
        [[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                               message:self.message
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil] autorelease] show];
    }
    
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(MImagePickerController*)picker {
    [self dismissModalViewControllerAnimated:NO];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                       target:self action:@selector(takePicture)] autorelease];
    self.title = @"Moodstocks SDK Demo";
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger nbRows;
    NSInteger nbMatches = [self.matches count];
    
    switch (section) {
        case 0:
        case 1:
            nbRows = 1;
            break;
        case 2:
            nbRows = nbMatches > 0 ? nbMatches : 1;
            break;
            
        default:
            nbRows = 0;
    }
    
    return nbRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   NSString * title; 
    switch (section) {
        case 0:
            title = @"Status";
            break;
        case 1:
            title = @"Message";
            break;
        case 2:
            title = @"Results";
            break;
            
        default:
            title = @"";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UILabel* textLabel = cell.textLabel;
    
    if ([indexPath section] == 0) {
        textLabel.text = self.status ? self.status : @"N/A";
    }
    else if ([indexPath section] == 1) {
        textLabel.text = (self.message && self.message.length > 0) ? self.message : @"N/A";
    }
    else if ([indexPath section] == 2) {
        if (self.matches && ([self.matches count] > 0)) {
            textLabel.text = [self.matches objectAtIndex:[indexPath row]];
        }
        else {
            textLabel.text = @"N/A";
        }
    }

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // do nothing
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_status release];
    [_message release];
    [_matches release];

    [super dealloc];
}


@end

