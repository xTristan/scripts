#!/bin/sh

tmux split-window -h
tmux split-window -h
tmux select-layout even-horizontal
tmux split-window -v -t 1 -p 33
tmux split-window -v -t 2 -p 67
tmux split-window -v -t 4 -p 50
tmux select-pane -t 0
