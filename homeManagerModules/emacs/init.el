; Basic settings to make it look gewd

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(recentf-mode 1)

(setq history-length 25)
(savehist-mode 1)

(save-place-mode 1)

; Voeg transparantie toe
(set-frame-parameter (selected-frame) 'alpha '(85 . 85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))

