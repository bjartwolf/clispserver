# clispserver
Only to play around, I want to fix routes on the fly

## Things we need 

- sbcl (compiler and runtime, there are others such as Allegro and CLISP)
```sudo apt install sbcl```
- quicklisp (library manager, the beta is appearently the standard)
https://www.quicklisp.org/
```
curl -O https://beta.quicklisp.org/quicklisp.lisp
curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
gpg --keyserver hkps://keys.openpgp.org --recv-key 307965AB028B5FF7
gpg --verify quicklisp.lisp.asc quicklisp.lisp
sbcl --load quicklisp.lisp
```

In sbcl
```
(quicklisp-quickstart:install)
(ql:add-to-init-file)
(quit)
```

```
sbcl --eval '(ql:quickload :alexandria)' --quit
```

sbcl --load  /home/bjartwolf/quicklisp/setup.lisp
sbcl --load  /home/bjartwolf/quicklisp/setup.lisp --eval '(ql:quickload :alexandria)' --quit
❯ sbcl --load /home/bjartwolf/quicklisp/setup.lisp --eval '(ql:add-to-init-file)' --quit
cat ~/.sbclrc 
it seems this add to init file is important...

IDE:
- emacs + sly (or slime for old-school feel?)
- doom emacs https://doomemacs.org/
- or neovim + vlime 

Common Lisp libraries (via quicklisp):
- hunchentoot as web framework 
- swank (remote REPL/debugger)

Stuff that is assumed there on lambda server
- systemd, ssh, caddy

Notes:
- caddy terminates TLS and proxies to hunchentoot over a unix socket.
- swank binds 127.0.0.1, tunnel with ssh over port 4005 
