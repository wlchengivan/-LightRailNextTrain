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
for x in range(60, 61):
    stationID = stations.iloc[x][0]
    nameEng = stations.iloc[x][1]
    nameChi = stations.iloc[x][2]

    req = requests.get(url + str(stationID))

    print(req.json())

