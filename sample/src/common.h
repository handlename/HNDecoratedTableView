#import <Foundation/Foundation.h>

#ifdef DEBUG
#  define LOG(...) NSLog(__VA_ARGS__)
#  define LOG_CURRENT_METHOD NSLog(@"%s", __PRETTY_FUNCTION__)
#else
#  define LOG(...) ;
#  define LOG_CURRENT_METHOD ;
#endif

#define L(s) NSLocalizedString(s, nil)
