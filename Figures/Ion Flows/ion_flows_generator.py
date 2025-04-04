#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar 13 20:49:21 2025

@author: max
"""


import svgpathtools
import xml.etree.ElementTree as ET

import pandas as pd
import numpy as np
import re
import itertools
import copy

import subprocess


file_base = './ionic_flows.svg'

namespaces = {
    'svg': 'http://www.w3.org/2000/svg',
    'xlink': 'http://www.w3.org/1999/xlink'
    }

file_output_a = 'ionic_flows_modified_a.svg'
file_output_b = 'ionic_flows_modified_b.svg'

file_outputs = [file_output_a, file_output_b]

tree_base = ET.parse(file_base)

filepath_simulation = '../../Simulation Datafiles/Robot_Brain.h5'


#%%
with pd.HDFStore(filepath_simulation) as store:
    timeseries = store['5.455594781168519/timeseries']
    parameters = store['5.455594781168519/parameters']


timeseries = timeseries[~timeseries.index.duplicated(keep='first')]

#%%
p = subprocess.Popen(['inkscape', '--shell'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
p_output_iter = iter(lambda: p.stdout.read(1), '')

# block until we get a prompt character, >
for char in p_output_iter:
    if char == '>':
        break

#%%
time_a = 26000
time_b = 26380

times = [time_a, time_b]

for time, file_output in zip(times, file_outputs):
    tree = copy.deepcopy(tree_base)
    for path_elem in tree.find("svg:g[@id='layer1']", namespaces).iterfind('svg:path', namespaces):
        path = svgpathtools.parse_path(path_elem.get('d'))
        path_variable = path_elem.get('flow')


        if path_variable is None:
            continue

        variables = re.split('([+-]+)', path_variable)


        flow = 0
        for pair in itertools.batched(reversed(variables), 2):
            if len(pair) == 2:
                variable, operator = pair
            elif pair != ('',):
                variable, = pair
                operator = '+'
            else:
                continue

            if operator == '+':
                flow += timeseries[variable].loc[time]
            elif operator == '-':
                flow -= timeseries[variable].loc[time]

        if flow < 0:
            path = path.reversed()

        path_elem.set('d', path.d())

        width = 3.0*abs(flow/9.5e-12)**0.5

        style = path_elem.get('style')
        style_new = re.sub('stroke-width:[^;"]*', f'stroke-width:{width:0.4f}', style)

        path_elem.set('style', style_new)

    tree.write(file_output)



#%% animation

file_base = './ionic_flows_dashed.svg'
file_output = 'Animation/temp.svg'
tree_base = ET.parse(file_base)

frame_count = 150*3

time_start = 16161
time_stop = 18116
times = np.linspace(time_start, time_stop, frame_count)

fps = 30
realtime_factor = (time_stop - time_start)/(frame_count/fps)


# Need a perfect loop so compute the nearest number of repeats
dash_increment_desired = 0.1
repeats = round(frame_count*dash_increment_desired)
dash_increment = repeats/frame_count

#%% reinterpolate the data

timeseries_interpolated = timeseries.reindex(timeseries.index.union(times, sort=True)).interpolate('linear').reindex(times)

#%% setup the offset dict

offset = {}
tree = copy.deepcopy(tree_base)
for path_elem in tree.find("svg:g[@id='layer1']", namespaces).iterfind('svg:path', namespaces):
    path_id = path_elem.get('id')
    offset[path_id] = 0

#%% compute and save the frames
for i, (time, row)in enumerate(timeseries_interpolated.iterrows()):
    print(i)
    tree = copy.deepcopy(tree_base)
    for path_elem in tree.find("svg:g[@id='layer1']", namespaces).iterfind('svg:path', namespaces):
        path = svgpathtools.parse_path(path_elem.get('d'))
        path_variable = path_elem.get('flow')
        path_id = path_elem.get('id')

        if path_variable is None:
            continue

        variables = re.split('([+-]+)', path_variable)


        flow = 0
        for pair in itertools.batched(reversed(variables), 2):
            if len(pair) == 2:
                variable, operator = pair
            elif pair != ('',):
                variable, = pair
                operator = '+'
            else:
                continue

            if operator == '+':
                flow += row[variable]
            elif operator == '-':
                flow -= row[variable]

        if flow < 0:
            path = path.reversed()

        path_elem.set('d', path.d())

        width = 3.0*abs(flow/9.5e-12)**0.5

        offset_old = offset[path_id]

        offset_new = (offset_old - dash_increment*width) % 3

        offset[path_id] = offset_new

        style = path_elem.get('style')
        style_new = re.sub('stroke-width:[^;"]*', f'stroke-width:{width:0.8f}', style)
        style_new = re.sub('stroke-dashoffset:[^;"]*', f'stroke-dashoffset:{offset_new:0.8f}', style_new)
        style_new = re.sub('stroke-dasharray:[^;"]*', f'stroke-dasharray:2,1', style_new)

        path_elem.set('style', style_new)


    #print(offset['path1427'])

    tree.write(file_output)

    p.stdin.write(f'file-open:{file_output};'
                  'export-area-page;'
                  'export-dpi:600;'
                  f'export-filename:Animation/animation_frame_{i:06d}.png;'
                  'export-do;'
                  '\n')
    p.stdin.flush()

    # blocks until we get a >
    for char in p_output_iter:
        if char == '>':
            break

#subprocess.run('gifski --fps 30 --width 1024 *.png -o animation.gif'.split(' '))
