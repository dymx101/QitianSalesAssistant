//
//  TDHomeVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDHomeVC.h"

#import "TDCardListVC.h"
#import "TDVendorsVC.h"
#import "TDAddMoneyVC.h"
#import "TDCreditVC.h"
#import "TDCreditVC.h"
#import "TDConsumeVC.h"
#import "TDMailVC.h"
#import "TDLifeVC.h"
#import "TDRegisterVC.h"
#import "TDDummyVC.h"
#import "TDLoginVC.h"
#import "TDLogVendorsVCViewController.h"
#import "TDGpsTrackVC.h"

typedef enum {
    kVcRegister = 1000
    , kVcCardList
    , kVcVendors
    , kVcAddMoney
    , kVcCredit
    , kVcConsume
    , kVcMail
    , kVcLife
    , kVcPhoneFee
}EVcType;



@interface TDHomeVC () <UIScrollViewDelegate> {
    UIScrollView            *_scrollView;
    NSMutableArray         *_tileButtons;
    
    UIPageControl           *_pageControl;
}

@end

@implementation TDHomeVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"销售管家";
    //self.view.backgroundColor = [FDColor sharedInstance].lightGray;
    _tileButtons = [NSMutableArray array];
    
    [self installLogoToNavibar];
    [self installMapAndSearchToNavibar];
	
    [self createSubviews];
    [self layout8Tiles];
    //[self layoutSubviews];
}



-(void)createSubviews {
    
    _scrollView = [UIScrollView new];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
//    _pageControl = [UIPageControl new];
//    _pageControl.numberOfPages = 2;
//    _pageControl.userInteractionEnabled = NO;
//    _pageControl.pageIndicatorTintColor = [FDColor sharedInstance].white;
//    _pageControl.currentPageIndicatorTintColor = [FDColor sharedInstance].caribbeanGreen;
//    [self.view addSubview:_pageControl];
    
    //
    
    int tag = kVcRegister;
    
    UIButton *btnTile = [UIButton new];//[self tileButtonWithTitle:@"用户\n注册" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_facebook"] forState:UIControlStateNormal];
    btnTile.tag = tag;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"卡片\n管理" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_twitter"] forState:UIControlStateNormal];
    btnTile.tag = tag;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"商户\n浏览" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_linkedin"] forState:UIControlStateNormal];
    btnTile.tag = tag;//kVcVendors;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"消费\n充值" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_yahoo"] forState:UIControlStateNormal];
    btnTile.tag = tag;//kVcAddMoney;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"积分\n活动" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_hoovers"] forState:UIControlStateNormal];
    btnTile.tag = tag;//kVcCredit;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"消费\n预定" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_youtube"] forState:UIControlStateNormal];
    btnTile.tag = tag;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"邮件\n管理" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_salesforce"] forState:UIControlStateNormal];
    btnTile.tag = tag;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"生活\n缴费" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_crunchbase"] forState:UIControlStateNormal];
    btnTile.tag = tag;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    tag++;
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"生活\n缴费" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"btn_yammer"] forState:UIControlStateNormal];
    btnTile.tag = tag;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];

}

-(UIButton *)tileButtonWithTitle:(NSString *)aTitle action:(SEL)anAction {
    UIButton *btnTile = [UIButton new];
    btnTile.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btnTile.titleLabel.textAlignment = NSTextAlignmentCenter;
    //[btnTile setBackgroundColor:aBgColor];
    [btnTile setBackgroundImage:[TDImageLibrary sharedInstance].btnBgOrange forState:UIControlStateNormal];
    [btnTile setTitle:aTitle forState:UIControlStateNormal];
    btnTile.titleLabel.font = [TDFontLibrary sharedInstance].fontTileButton;
    
    if (anAction != NULL) {
        [btnTile addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btnTile;
}

-(void)tileButtonAction:(UIButton *)sender {
    int tag = sender.tag;
    
    TDDummyVC *dummyVC = [TDDummyVC new];
    NSString *naviTitle = nil;
    
    switch (tag) {
        case kVcRegister: {
            TDGpsTrackVC *vc = [TDGpsTrackVC new];
            vc.title = @"GPS";
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
            break;
            
        case kVcCardList: {
            TDLoginVC *vc = [TDLoginVC new];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nc animated:YES completion:nil];
            return;
        }
            break;
            
        case kVcVendors:
            naviTitle = @"工作日报";
            break;
            
        case kVcAddMoney:
            naviTitle = @"产品管理";
            break;
            
        case kVcCredit:
            naviTitle = @"客户管理";
            break;
            
        case kVcConsume:
            naviTitle = @"客户拜访";
            break;
            
        case kVcMail:
            naviTitle = @"订单管理";
            break;
            
        case kVcLife:
            naviTitle = @"信息上报";
            break;
            
        case kVcPhoneFee:
            naviTitle = @"窜货管理";
            break;
            
        default:
            break;
    }
    
    dummyVC.title = naviTitle;
    [self.navigationController pushViewController:dummyVC animated:YES];
}

#define PADDING_TOP              (20)
#define PADDING_Y               (20)
#define BUTTON_SIZE             (60)
#define BUTTON_OFFSET_X_CENTER  (50)
#define PAGE_WIDTH              (320)

-(void)layout8Tiles {
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView alignToView:self.view];
    
    NSArray *firstLineButtons = [_tileButtons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
    NSArray *secondLineButtons = [_tileButtons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 3)]];
    NSArray *thirdLineButtons = [_tileButtons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(6, 3)]];
    
    NSString *leadingSpaceStr = @(67).stringValue;
    NSString *horizGapStr = @(40).stringValue;
    float offsetY = 30;
    
    int i = 0;
    for (UIButton *btn in firstLineButtons) {
        [btn alignTopEdgeWithView:_scrollView predicate:@(offsetY).stringValue];

        if (i == 0) {
            [btn alignLeadingEdgeWithView:_scrollView predicate:leadingSpaceStr];
        }
        i ++;
    }
    [UIView spaceOutViewsHorizontally:firstLineButtons predicate:horizGapStr];
    offsetY += 70;
    
    //
    i = 0;
    for (UIButton *btn in secondLineButtons) {
        [btn alignTopEdgeWithView:_scrollView predicate:@(offsetY).stringValue];
        
        if (i == 0) {
            [btn alignLeadingEdgeWithView:_scrollView predicate:leadingSpaceStr];
        }
        i ++;
    }
    [UIView spaceOutViewsHorizontally:secondLineButtons predicate:horizGapStr];
    offsetY += 70;
    
    //
    i = 0;
    for (UIButton *btn in thirdLineButtons) {
        [btn alignTopEdgeWithView:_scrollView predicate:@(offsetY).stringValue];
        
        if (i == 0) {
            [btn alignLeadingEdgeWithView:_scrollView predicate:leadingSpaceStr];
        }
        i ++;
    }
    [UIView spaceOutViewsHorizontally:thirdLineButtons predicate:horizGapStr];

}

-(void)layoutSubviews {
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView alignToView:self.view];
    
    int btnCount = _tileButtons.count;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = _tileButtons[i];
        
        //int timesOfSix = i / 6;
        int numPerRow = 2;
        
        NSString *btnSize = (@(BUTTON_SIZE)).stringValue;
        [btn constrainWidth:btnSize height:btnSize];
        
        int offsetX = (i % numPerRow) ? BUTTON_OFFSET_X_CENTER : -BUTTON_OFFSET_X_CENTER;
        NSNumber *offsetCenterX = @(offsetX);//@(offsetX + PAGE_WIDTH * timesOfSix);
        [btn alignCenterXWithView:_scrollView predicate:offsetCenterX.stringValue];
        
        int factor = i;//i % 6;
        NSNumber *paddingTop = @(PADDING_TOP + PADDING_Y * (factor / numPerRow + 1) + (factor / numPerRow) * BUTTON_SIZE);
        [btn alignTopEdgeWithView:_scrollView predicate:paddingTop.stringValue];
        
        
        
        if (i == btnCount - 1) {
//            float paddingX = PAGE_WIDTH / 2 - BUTTON_OFFSET_X_CENTER - BUTTON_SIZE / 2;
//            [btn alignTrailingEdgeWithView:_scrollView predicate:(@(-paddingX)).stringValue];
            [btn alignBottomEdgeWithView:_scrollView predicate:@(-PADDING_TOP).stringValue];
        }
    }
}

#pragma mark - scroll view delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int offsetX = scrollView.contentOffset.x;
    float scrollWidth = scrollView.frame.size.width;
    int page = (offsetX + (scrollWidth / 2)) / scrollWidth;
    _pageControl.currentPage = page;
}

#pragma mark - actions 
-(void)pageValueChanged:(id)sender {
    float offsetX = _pageControl.currentPage * PAGE_WIDTH;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}



@end
