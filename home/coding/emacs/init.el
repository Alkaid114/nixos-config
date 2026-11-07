;;; init.el -*- lexical-binding: t; -*-

;; 基础设置
(setq inhibit-startup-screen t)   ; 关闭默认启动画面
(global-display-line-numbers-mode 1) ; 显示行号
(tool-bar-mode -1)                ; 隐藏工具栏
(menu-bar-mode -1)                ; 隐藏菜单栏
(scroll-bar-mode -1)              ; 隐藏滚动条
(setq display-line-numbers-width 4)
(setopt elisp-fontify-semantically t)
(set-frame-font "Jetbrains Maple Mono-14" nil t)
(set-face-attribute 'default nil
		    :family "Jetbrains Maple Mono"
		    :height 140)
(setq catppuccin-flavor 'mocha)
(load-theme 'catppuccin t)

(use-package display-line-numbers
  :ensure nil ; 内置包
  :init
  (setq display-line-numbers-width 4)
  :config
  (global-display-line-numbers-mode 1)

  ;; 根据当前状态切换行号类型
  (defun my-evil-line-numbers-setup ()
    (if (eq evil-state 'insert)
        ;; Insert 模式：设为 nil 彻底隐藏，或者设为 t 显示绝对行号
        (setq display-line-numbers-type t) 
      ;; Normal / Visual 模式：显示相对行号
      (setq display-line-numbers-type 'relative))
    
    ;; 强制刷新当前缓冲区的行号显示
    (when (bound-and-true-p display-line-numbers-mode)
      (display-line-numbers-mode 1)))

  ;; 把函数挂载到 Evil 的状态切换钩子上
  (add-hook 'evil-insert-state-entry-hook #'my-evil-line-numbers-setup)
  (add-hook 'evil-normal-state-entry-hook #'my-evil-line-numbers-setup)
  (add-hook 'evil-replace-state-entry-hook #'my-evil-line-numbers-setup))

;; 设置一个专门存放垃圾文件的目录
(defvar my-backup-dir (expand-file-name "var/backups" user-emacs-directory))
(unless (file-exists-p my-backup-dir)
  (make-directory my-backup-dir t))

;; 备份文件 (`~`) 
(setq backup-directory-alist `(("." . ,my-backup-dir)))
;; 设置备份文件不随保存次数叠加
(setq delete-old-versions t)

;; 自动保存文件 (`#`)
(setq auto-save-file-name-transforms
      `((".*" ,my-backup-dir t)))

;; 关闭锁文件
(setq create-lockfiles nil)

;; which-key按键提示
(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :config
  (setq which-key-show-operator-state-maps t)
  (setq which-key-show-major-mode t)
  (setq which-key-idle-delay 0.5)) ; 半秒后弹出

;; undo-tree撤销历史
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode 1))

;; 确保目录存在
(make-directory (expand-file-name "var/undo-tree" user-emacs-directory) t)

;; 历史文件存指定文件夹
(setq undo-tree-history-directory-alist
      `(("." . ,(expand-file-name "var/undo-tree" user-emacs-directory))))

;; recentf
(setq recentf-save-file (expand-file-name "var/recentf.eld" user-emacs-directory))
;; 开启记录最近文件的功能
(recentf-mode 1)
;; 最多记录50个
(setq recentf-max-saved-items 50)

;; 忽略一些文件类型
(add-to-list 'recentf-exclude "\\.emacs\\.d/var/")
(add-to-list 'recentf-exclude "^/tmp/")

;; Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)   ; 与 Emacs 原生键位集成）
  (setq evil-want-keybinding nil)  ; 交给 evil-collection 处理
  :config
  (setq evil-undo-system 'undo-tree)
  (evil-mode 1))

;; evil-collection
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init)) ; 启用所有

;; doom-modeline状态栏
(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-height 32)
  (setq doom-modeline-support-imenu t)
  (setq doom-modeline-buffer-file-name-style 'auto)
  (setq doom-modeline-icon t)
  (setq doom-modeline-buffer-name t)
  (doom-modeline-mode 1))

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-banner-logo-title "Welcome to Emacs")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5))))

;; magit：Git界面
(use-package magit
  :ensure t)

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package avy
  :ensure t
  :defer t
  :config
  ;; 设置跳转时使用的引导键
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  ;; 设置跳转样式（'at 表示在字符所在位置显示引导键）
  (setq avy-style 'at)
  ;; 限制avy只在当前窗口生效
  (setq avy-all-windows nil))

(use-package evil-avy
  :ensure t
  :after (avy evil)
  :config
  (evil-avy-mode 1))

(use-package consult
  :ensure t
  :bind (;; 覆盖原生C-x b，使用consult
         ("C-x b" . consult-buffer)
	 ("C-s" . consult-line)
	 ("C-x g" . magit-status)))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  ;; 允许在搜索时用空格分开多个关键词
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((file (styles basic partial-completion)))))

(use-package general
  :ensure t
  :config
  ;; 设置 SPC 为 Evil 的 Leader 键
  (general-evil-setup t)
  
  ;; 创建统一的定义器
  (general-create-definer my-leader-def
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC")

  ;; 定义菜单树
  (my-leader-def
    ;; Buffer 相关
    "b"  '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch buffer")
    "bd" '(kill-current-buffer :which-key "kill buffer")
    "bi" '(ibuffer :which-key "ibuffer list")
    
    ;; 文件/目录 相关
    "f"  '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fd" '(dired :which-key "open dired")
    
    ;; 搜索 相关
    "s"  '(:ignore t :which-key "search")
    "sl" '(consult-line :which-key "search in buffer")
    "sg" '(consult-ripgrep :which-key "search in project")
    
    ;; 窗口 相关
    "w"  '(:ignore t :which-key "windows")
    "wh" '(evil-window-left :which-key "window left")
    "wj" '(evil-window-down :which-key "window down")
    "wk" '(evil-window-up :which-key "window up")
    "wl" '(evil-window-right :which-key "window right")
    "wd" '(evil-window-delete :which-key "close window")
    "wo" '(delete-other-windows :which-key "close other windows")

    ;; 跳转 (Avy) 相关
    "j"  '(:ignore t :which-key "jump (avy)")
    "jc" '(avy-goto-char :which-key "goto char")
    "jw" '(avy-goto-word-0 :which-key "goto word")
    "jl" '(avy-goto-line :which-key "goto line")

    ;; Git (Magit) 相关
    "g"  '(:ignore t :which-key "git")
    "gg" '(magit-status :which-key "magit status")
    "gl" '(magit-log-current :which-key "magit log")))

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :config
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

;; 内置eglot LSP配置
(use-package eglot
  :ensure nil ; 内置包
  :hook (prog-mode . eglot-ensure) ; 编程模式下自动启动
  :config
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("ty" "server")))
  )
;; tree-sitter语法高亮
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt) ; 打开文件时提示安装缺失的语法
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) ; 自动将-ts-mode加入auto-mode-alist
  (global-treesit-auto-mode)) ; 全局启用

;; apheleia代码格式化
(use-package apheleia
  :ensure t
  :hook (prog-mode . apheleia-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1) ; 开启垂直补全模式
  :config
  ;; 支持循环滚动
  (setq vertico-cycle t))

(use-package nerd-icons
  :ensure t)

(provide 'init)
