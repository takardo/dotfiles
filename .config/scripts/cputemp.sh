#!/bin/bash

sensors | awk '/Tctl/ {print $2}'
