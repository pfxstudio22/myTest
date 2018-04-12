//
//  ViewController.m
//  AnimationLogo
//
//  Created by succorer on 2018. 1. 31..
//  Copyright © 2018년 Hanwha S&C. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIImageView *logo2;
@property (weak, nonatomic) IBOutlet UIImageView *logo3;
@property (weak, nonatomic) IBOutlet UIImageView *logo4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self bounceAnimation];
    
    [self scaleAnimation];
    [self stepAnimation];
    
    [self colorAnimation];
}

- (void)rotateAnimationWithImageView:(UIImageView *)imageView {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)bounceAnimation {
    static float delay = 0.5;
    static float yPos = 10;

   [self rotateAnimationWithImageView:self.logo1];
    [UIView animateWithDuration:delay
                     animations:^
    {
       self.logo1.center = CGPointMake(self.logo1.center.x, self.logo1.center.y - yPos);
    }
    completion:^(BOOL completed)
    {
         if (completed)
         {
             //completed move right..now move left
             [UIView animateWithDuration:delay
                              animations:^
              {
                  self.logo1.center = CGPointMake(self.logo1.center.x, self.logo1.center.y + yPos);
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self bounceAnimation];
                  });
              }];
         }
    }];
}

- (void)scaleAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.4;
    animation.repeatCount = 2;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0]; //1배
    animation.toValue = [NSNumber numberWithFloat:1.2]; // 2배
    [self.logo2.layer addAnimation:animation forKey:@"scale-layer"];
}

- (void)stepAnimation {
    /* 애니메이션1（x축방향으로 이동） */
   static float delay = 0.5;
   static float xPos = 60;
   
   [self rotateAnimationWithImageView:self.logo3];
   [UIView animateWithDuration:delay
                    animations:^
    {
       CGRect frame = self.logo3.frame;
       self.logo3.frame = CGRectMake(frame.origin.x + xPos, frame.origin.y, frame.size.width, frame.size.height);

    }
                    completion:^(BOOL completed)
    {
       if (completed)
       {
          //completed move right..now move left
          [UIView animateWithDuration:delay animations:^{
             
          } completion:^(BOOL finished) {
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CGRect frame = self.logo3.frame;
                self.logo3.frame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height);
                
                [self stepAnimation];
             });
          }];
       }
    }];
}

- (void)colorAnimation {
   self.logo4.image = [self.logo4.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
   float red = (arc4random() % 255) / 255.0f;
   float green = (arc4random() % 255) / 255.0f;
   float blue = (arc4random() % 255) / 255.0f;
   [UIView animateWithDuration:0.5 animations:^{
      self.logo4.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
   } completion:^(BOOL finished) {
      [UIView animateWithDuration:1 animations:^{
         float red = (arc4random() % 255) / 255.0f;
         float green = (arc4random() % 255) / 255.0f;
         float blue = (arc4random() % 255) / 255.0f;
         self.logo4.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
      } completion:^(BOOL finished) {
         [self colorAnimation];
      }];
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
