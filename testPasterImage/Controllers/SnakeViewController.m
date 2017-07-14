//
//  SnakeViewController.m
//  testPasterImage
//
//  Created by shiqianren on 2017/4/10.
//  Copyright © 2017年 王迎博. All rights reserved.
//

#import "SnakeViewController.h"
#import "GameView.h"
#import "Snake.h"

#define LEVELCOUNT 10   //多少分为1级
#define MAXLEVEL 9     //最高多少级
@interface SnakeViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet GameView *gameView;
@property (nonatomic, strong) Snake *snake;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (nonatomic, strong) UIImageView *food;
@property (nonatomic, assign) BOOL isGameOver;
@end

@implementation SnakeViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImageView *)food {
    if (!_food) {
        _food = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NODEWH, NODEWH)];
        _food.image = [UIImage imageNamed:@"icon_星星2"];
        [_gameView addSubview:_food];
    }
    return _food;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.snake = [Snake snake];
    __weak typeof(self) weakSelf = self;
    _snake.moveFinishBlock = ^(){
        [weakSelf isEatedFood];
        [weakSelf isDestroy];
        [weakSelf.gameView setNeedsDisplay];
    };
    _gameView.snake = _snake;
    [self createFood];
}

- (void)createFood {
    int x = (arc4random() % 20) * NODEWH + NODEWH * 0.5;
    int y = (arc4random() % 30) * NODEWH + NODEWH * 0.5;
    CGPoint center = CGPointMake(x, y);
    for (Node *node in _snake.nodes) {
        if (CGPointEqualToPoint(center, node.coordinate)) {
            [self createFood];
            return;
        }
    }
    self.food.center = center;
}


- (void)isEatedFood {
    if (CGPointEqualToPoint(_food.center, _snake.nodes.firstObject.coordinate)) {
        NSInteger score = _scoreLabel.text.intValue + 1;
        _scoreLabel.text = [NSString stringWithFormat:@"%ld", score];
        if (score <= LEVELCOUNT * MAXLEVEL && (score % LEVELCOUNT == 0)){
            NSInteger level = score / LEVELCOUNT;
            [_snake levelUpWithSpeed:level];
            _levelLabel.text = [NSString stringWithFormat:@"%ld", level];
        }
        [self createFood];
        [_snake growUp];
    }
}

- (void)isDestroy {
    Node *head = _snake.nodes.firstObject;
    for (int i = 1; i < _snake.nodes.count; i++) {
        Node *node = _snake.nodes[i];
        if (CGPointEqualToPoint(head.coordinate, node.coordinate)) {
            [self gameOver];
        }
    }
    if (head.coordinate.x < 5 || head.coordinate.x > 195) {
        [self gameOver];
    }
    if (head.coordinate.y < 5 || head.coordinate.y > 295) {
        [self gameOver];
    }
}

- (void)gameOver {
    [_snake pause];
    NSString *message = [NSString stringWithFormat:@"总得分：%@，不服再来？", _scoreLabel.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"不服", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        _startBtn.selected = NO;
        _isGameOver = YES;
    } else {
        _scoreLabel.text = @"0";
        _levelLabel.text = @"0";
        [self createFood];
        [_snake reset];
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    if (_startBtn.selected) self.snake.direction = (MoveDirection)sender.tag;
}

- (IBAction)pause:(UIButton *)sender {
    if (sender.selected) {
        [_snake pause];
    } else {
        if (_isGameOver) {
            _scoreLabel.text = @"0";
            _levelLabel.text = @"0";
            [_snake reset];
            _isGameOver = NO;
        } else {
            [_snake start];
        }
    }
    sender.selected = !sender.selected;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
