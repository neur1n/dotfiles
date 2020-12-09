(global-display-line-numbers-mode)
(set 'display-line-numbers-type 'relative)

(set-face-attribute 'default nil :font "GohuFont NF 12")

(when window-system
  (set-frame-position (selected-frame) 200 200)
  (set-frame-size (selected-frame) 100 35))
