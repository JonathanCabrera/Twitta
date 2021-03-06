//
//  User.h
//  twitter
//
//  Created by Jonathan Cabrera on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePhoto;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
