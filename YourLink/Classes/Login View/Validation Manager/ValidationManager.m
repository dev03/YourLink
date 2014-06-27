//  Created by Developer on 10/13/11.
//  Copyright 2011 Magnifo. All rights reserved.

#import "ValidationManager.h"


@implementation ValidationManager

NSString *returnMsg;

-(NSString*)validationWithFixedParameter:(NSString*)parameter Length:(int)lengthParameter
{
	if([parameter length] >= lengthParameter)
		return @"";
	else
	{
		returnMsg = [NSString stringWithFormat:@"length of the field must be greater then % d characters.",lengthParameter];
		return returnMsg;
	}
}

-(NSString*)validationWithRangeParameter:(NSString*)parameter fromLength:(int)lenghtParameter toLength:(int)outLength
{
	if(([parameter length] >= lenghtParameter) && ([parameter length] <= outLength))
		return @"";
	else
	{
		returnMsg = [NSString stringWithFormat:@"length of the field must be between %d and %d characters.",lenghtParameter,outLength];
		return returnMsg;
	}
}

/*-(NSString*)validationWithFixedParameterForProduct:(NSString*)parameter Length:(int)lengthParameter
{
	if([parameter length] == lengthParameter)
		return @"";
	else 
	{
		returnMsg = [NSString stringWithFormat:@"6 karakter uzunluğunda olmalıdır."];
		return returnMsg;
	}
}

-(NSString*)validationWithFixedParameterForProductCode:(NSString*)parameter
{
	if([parameter length]==0)
    {
        returnMsg = [NSString stringWithFormat:@"Ürün Kodu alanını boş bırakmayınız."];
		return returnMsg;
    }
	else 
	{
		return @"";
	}	
}

-(NSString*)validationWithFixedParameterForSMSCode:(NSString*)parameter Length:(int)lengthParameter
{
	if([parameter length] == lengthParameter)
		return @"";
	else 
	{
		returnMsg = [NSString stringWithFormat:@"SMS Doğrulama Kodu Geçersiz."];
		return returnMsg;
	}	
}

 -(NSString*)validationCVCFixedParameter:(NSString*)parameter Length:(int)lengthParameter
 {
     if([parameter length] == lengthParameter)
        return @"";
     else 
     {
         returnMsg = [NSString stringWithFormat:@"alanının uzunluğu %d karakter olmalıdır.",lengthParameter];
        return returnMsg;
 
     }
 
 }
 
-(NSString*)validationPasswordWithRangeParameter:(NSString*)parameter fromLength:(int)lenghtParameter toLength:(int)outLength
{
	if(([parameter length] >= lenghtParameter) && ([parameter length] <= outLength))
		return @"";
	else
	{
		returnMsg = [NSString stringWithFormat:@"Şifre alanının uzunluğu %d ile %d arasında olmalıdır. ",lenghtParameter,outLength];
		return returnMsg;
	}	
	
}

-(NSString*)validationWithMinimumRange:(NSString*)parameter minimumLength:(int)minimumParameter
{
	if(([parameter length] >= minimumParameter))
		return @"";
	else
	{
		returnMsg = [NSString stringWithFormat:@"Adresinizin uzunluğu en az %d karakterden oluşmalıdır.",minimumParameter];
		return returnMsg;
	}
	
}*/

- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

/*- (BOOL) validateUrl: (NSString *) candidate
{
    NSURL *candidateURL = [NSURL URLWithString:candidate];
    if (candidateURL && candidateURL.scheme && candidateURL.host)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}*/

- (BOOL)validateNumeric:(NSString *)numericString
{
    NSString *regexExpression = @"^[-+]?\\d{0,9}$"; 
    NSPredicate *matchTextPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexExpression]; 
    return [matchTextPredicate evaluateWithObject:numericString];
}

/*-(void)showAlert:(NSString *)title msg:(NSString *)msg
{	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"İptal" otherButtonTitles:@"Tamam", nil];
	[alert show];
}

-(void)showAlertSingle:(NSString *)title msg:(NSString *)msg
{	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
	[alert show];
}

- (BOOL)connectedToInternet1
{
	NSString *URLString=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSUTF8StringEncoding error:nil];
	 return ( URLString != NULL ) ? YES : NO;
	return YES;
}

-(NSString *)validateCreditCard:(NSString *)enteredCard
{
	NSError *error = NULL; 
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})$" options:NSRegularExpressionCaseInsensitive error:&error];
	NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:enteredCard options:0 range:NSMakeRange(0, [enteredCard length])];
	if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) 
		{
			NSString *substringForFirstMatch = [enteredCard substringWithRange:rangeOfFirstMatch];
			NSLog(@"Extracted URL: %@",substringForFirstMatch);
			return substringForFirstMatch;
		}
	
	return NULL;
}*/

@end
