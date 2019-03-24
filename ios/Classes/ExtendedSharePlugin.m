#import "ExtendedSharePlugin.h"

@interface __SubjectSupplier : NSObject<UIActivityItemSource>

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *subject;

- (instancetype)initWithText:(NSString *)text
                     subject:(NSString *)subject;

@end

@implementation __SubjectSupplier

- (instancetype)initWithText:(NSString *)text
                     subject:(NSString *)subject {
    self = [super init];
    if (self) {
        _text = text;
        _subject = subject;
    }
    return self;
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType {
    return [self text];
}

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {
    return @"";
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType {
    return [self subject];
}

@end

@implementation ExtendedSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.github.rmtmckenzie/extended_share"
            binaryMessenger:[registrar messenger]];
  ExtendedSharePlugin* instance = [[ExtendedSharePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"share" isEqualToString:call.method]) {
      if (![[call arguments] isKindOfClass:[NSDictionary class]]) {
          result([FlutterError errorWithCode:@"error" message:@"Arguments must be a dictionary" details:nil]);
          return;
      }
      NSDictionary *arguments = [call arguments];
      
      NSString *text = arguments[@"text"];
      if (text == nil || text.length == 0) {
          result([FlutterError errorWithCode:@"error" message:@"Text must not be empty" details:nil]);
          return;
      }
      
      NSString *subject = arguments[@"subject"];
      
      [self share:text withSubject:subject];
      result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)share: (NSString*) text
  withSubject: (NSString*) subject {
    __SubjectSupplier *supplier = [[__SubjectSupplier alloc] initWithText:text subject:subject];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[supplier] applicationActivities:nil];

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    vc.popoverPresentationController.sourceView = rootViewController.view;
    [rootViewController presentViewController:vc animated:true completion:nil];
}

@end
