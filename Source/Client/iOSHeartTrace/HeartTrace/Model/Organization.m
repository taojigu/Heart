//
//  Organization.m
//  HeartTrace
//
//  Created by user on 13-12-30.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "Organization.h"
#import "ElementsContainer.h"

@implementation Organization

@synthesize organizationId;
@synthesize name;
@synthesize productElementContainer;

-(id)init{
    self=[super init];
    ElementsContainer*tmpContainer=[[ElementsContainer alloc]init];
    self.productElementContainer=tmpContainer;
    [tmpContainer release];
    return self;
}


-(void)dealloc{
    [self.productElementContainer release];
    [self.organizationId release];
    [self.name release];
    [super dealloc];
}
+(Organization*)fakeOrganization:(NSInteger)index{
    
    Organization*result=[[[Organization alloc]init]autorelease];
    result.name=[NSString stringWithFormat:@"OrganizaitonName %i",index];
    result.organizationId=[NSString stringWithFormat:@"OrganizationID %i",index];
    return result;
}
@end
