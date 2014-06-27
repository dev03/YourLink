//  Created by Developer on 10/13/11.
//  Copyright 2011 Magnifo. All rights reserved.

#import <Foundation/Foundation.h>


@interface ValidationManager : NSObject {

}

-(NSString*)validationWithFixedParameter:(NSString*)parameter Length:(int)lengthParameter;
-(NSString*)validationWithRangeParameter:(NSString*)parameter fromLength:(int)lenghtParameter toLength:(int)outLength;
//-(void)showAlert:(NSString *)title msg:(NSString *)msg;
- (BOOL) validateEmail: (NSString *) candidate;
- (BOOL)validateNumeric:(NSString *) numericString;
//-(void)showAlertSingle:(NSString *)title msg:(NSString *)msg;
//-(NSString *)validateCreditCard:(NSString *)enteredCard;
//-(NSString*)validationWithFixedParameterForSMSCode:(NSString*)parameter Length:(int)lengthParameter;
//-(NSString*)validationPasswordWithRangeParameter:(NSString*)parameter fromLength:(int)lenghtParameter toLength:(int)outLength;
//-(NSString*)validationWithFixedParameterForProduct:(NSString*)parameter Length:(int)lengthParameter;
//-(NSString*)validationCVCFixedParameter:(NSString*)parameter Length:(int)lengthParameter;
//- (BOOL)connectedToInternet1;
//-(NSString*)validationWithFixedParameterForProductCode:(NSString*)parameter;
//-(NSString*)validationWithMinimumRange:(NSString*)parameter minimumLength:(int)minimumParameter;
//- (BOOL) validateUrl: (NSString *) candidate ;
@end
