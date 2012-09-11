//
//  EDViewController.m
//  Edward iPhone Hands
//
//  Created by Oskar Hagberg on 2012-09-11.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDViewController.h"

@implementation DrinkCell



@end

@interface EDViewController ()



@end

@implementation EDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCollectionViewController:nil];
    [super viewDidUnload];
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrinkCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DrinkCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"beer"];
        cell.textLabel.text = @"Beer";
    } else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"martini"];
        cell.textLabel.text = @"Martini";
    } else if (indexPath.section == 2) {
        cell.imageView.image = [UIImage imageNamed:@"wine"];
        cell.textLabel.text = @"Wine";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
