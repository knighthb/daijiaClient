//
//  DJDriverModel.m
//  58DaijiaClient
//  司机model
//  Created by huangbin on 14-4-3.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverModel.h"

/*
 address = "<null>";
 cityName = "\U5317\U4eac";
 coordinate = "<null>";
 distance = 0;
 driverlicense = "<null>";
 drivernum = 0;
 driveryear = 9;
 grade = "<null>";
 headshot = "http://img1.58.com/nowater/product/n_s02206325280817715002_100_75.jpg";
 id = 0;
 idnumber = "<null>";
 licensetime = "<null>";
 local =             {
 area = "<null>";
 city = "\U5317\U4eac";
 local = "<null>";
 };
 name = "\U6768\U7389\U82b9";
 onwork = 0;
 phone = "<null>";
 price = tongyi;
 range = 0m;
 remark = "<null>";
 source = 58;
 tel = 15201330385;
 url = "app/0/product/19061703902884.shtml";
 userid = 22397121609473;
 */
@implementation DJDriverModel
@synthesize driverId;
@synthesize name;
@synthesize homeCity;
@synthesize year;
@synthesize phoneNum;
@synthesize pic;
@synthesize distance;
@synthesize picUrl;
-(float) latitude
{
    return latitude;
}
-(void) setLatitude:(float) lat
{
    latitude = lat;
}
-(float) longitude
{
   return longitude;
}
-(void) setLongitude : (float) lon
{
    longitude = lon;
}

-(void) deserialize:(NSDictionary *) dic
{
    self.name = [dic objectForKey:@"name"];
    self.homeCity = [dic objectForKey:@"cityName"];
    self.year = [[dic objectForKey:@"driveryear"] integerValue];
    self.phoneNum = [dic objectForKey:@"tel"];
    self.source = [dic objectForKey:@"source"];
    self.distance = [dic objectForKey:@"range"];
    self.longitude = [[dic objectForKey:@"lng"] floatValue];
    self.latitude = [[dic objectForKey:@"lat"] floatValue];
    
    [self transf2Gaode] ;
    
    self.driverId = [dic objectForKey:@"userid"];
    self.picUrl = [dic objectForKey:@"headshot"];
    NSLog(@"picUrl=%@",self.picUrl);
    
}

const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;


-(void) transf2Gaode{
    double x = self.longitude - 0.0065 ;
    double y = self.latitude - 0.006;
    
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    
    self.longitude = z * cos(theta);
    
    self.latitude = z * sin(theta);

    
}

@end
