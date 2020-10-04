#!/bin/bash
git add .
git commit -m "new change"
git push -u origin master & git push heroku master
