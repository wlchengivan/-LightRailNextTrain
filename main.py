from numpy.core.fromnumeric import reshape
import requests
from bs4 import BeautifulSoup
import pandas as pd
import urllib, json, requests
from textblob import TextBlob
import sys
import tweepy
import matplotlib.pyplot as plt
import numpy as np
import ast
import os

#https://rt.data.gov.hk/v1/transport/mtr/lrt/getSchedule?station_id=540

stations = pd.read_csv("NewStation.csv", index_col="index")
url= "https://rt.data.gov.hk/v1/transport/mtr/lrt/getSchedule?station_id="

#for x in range(0, len(stations)):
for x in range(12, 13):
    stationID = stations.iloc[x][0]
    nameEng = stations.iloc[x][1]
    nameChi = stations.iloc[x][2]

    req = requests.get(url + str(stationID))

    platformList = req.json()['platform_list']

    print(nameChi)

    for y in range(0, len(platformList)):
        try:
            print(str(platformList[y]['platform_id']) + "號月台")
            routes = platformList[y]['route_list']
            for z in range(0, len(routes)):
                route = routes[z]
                print(route['route_no'] + " " + route['dest_ch'] + " " + route['time_ch'])
        except:
            print(platformList[y]['end_service_status'])