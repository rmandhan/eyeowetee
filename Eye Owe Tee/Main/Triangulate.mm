//
//  Triangulate.m
//  Eye Owe Tee
//
//  Created by Rakesh Mandhan on 2018-03-26.
//  Copyright © 2018 Rakesh Mandhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Triangulate.h"
#import "trilateration.hpp"
#include <iostream>

@implementation Triangulate

- (int)triangulate {
    
    // SOURCE: https://github.com/Navigine/Indoor-navigation-algorithms
    
    //fill map beacons and beaconEntries
    Trilateration trilateration;
    //fill beacon measurements depending from scenario
    std::vector<BeaconMeas> beaconMeasurements;
    //fill mapBeacons entries depending from scenario
    std::vector <Beacon> mapBeacons;
    
    Beacon beacon;
    
    //test scenario. Set 3 beacons on the map
    beacon.fillData( 54.69, 29.51, "(53580,22667,F7826DA6-4FA2-4E98-8024-BC5B71E0893E)",
                    "beacon1", "floor13" );
    mapBeacons.push_back( beacon );
    
    beacon.fillData( 54.68, 29.51, "(49599,56896,F7826DA6-4FA2-4E98-8024-BC5B71E0893E)",
                    "beacon2", "floor13" );
    mapBeacons.push_back( beacon );
    
    beacon.fillData( 49.05, 32.16, "(57506,19633,F7826DA6-4FA2-4E98-8024-BC5B71E0893E)",
                    "beacon3", "floor13" );
    mapBeacons.push_back( beacon );
    
    
    //specify beacon Measurements
    BeaconMeas measurement;
    
    measurement.setBeaconId( "(53580,22667,F7826DA6-4FA2-4E98-8024-BC5B71E0893E)" );
    measurement.setRssi( -86.57 );
    measurement.setDistance( 4.47 );
    beaconMeasurements.push_back( measurement );
    
    
    measurement.setBeaconId( "(49599,56896,F7826DA6-4FA2-4E98-8024-BC5B71E0893E)" );
    measurement.setRssi( -90.80 );
    measurement.setDistance( 14.13 );
    beaconMeasurements.push_back( measurement );
    
    
    measurement.setBeaconId( "(57506,19633,F7826DA6-4FA2-4E98-8024-BC5B71E0893E)");
    measurement.setRssi( -86.41 );
    measurement.setDistance( 15.85 );
    beaconMeasurements.push_back( measurement );
    
    //measurement from unknown beacon
    measurement.setBeaconId( "22211,00231" );
    measurement.setRssi( -21.41 );
    measurement.setDistance( 15.85 );
    beaconMeasurements.push_back( measurement );
    
    
    if (beaconMeasurements.size() == 0)
    {
        printf( "Number of measurements == 0\n" );
        return 0;
    }
    
    trilateration.updateMeasurements( beaconMeasurements );
    
    trilateration.setCurrentLocationId( 0 );
    
    trilateration.fillLocationBeacons(mapBeacons );
    
    int errorCode = trilateration.calculateCoordinates();
    
    
    double x = trilateration.getX();
    double y = trilateration.getY();
    printf( "x = %lf y = %lf \n", trilateration.getX(), trilateration.getY() );
    
    if (x != 53.692 && y != 29.977 && errorCode)
    {
        printf( "test not passed !\n check whether you changed "
               "something in code\n");
    }
    else
    {
        printf("test passed!\n");
    }
    
    if (errorCode)
        return errorCode;
    
    std::cin.get();
    return 0;
}

@end
