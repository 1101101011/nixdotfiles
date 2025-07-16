; ;; ~/.config/nvim/queries/blade/injections.scm
; ; inherits: html
;
; ((escaped_echo_statement
;    (raw_text) @injection.content
;    (#set! injection.language "php_only")
;    (#set! injection.include-children)))
;
; ((unescaped_echo_statement
;    (raw_text) @injection.content
;    (#set! injection.language "php_only")
;    (#set! injection.include-children)))
;
; ((directive
;    (directive_argument
;      (raw_text) @injection.content
;      (#set! injection.language "php_only")
;      (#set! injection.include-children))))
;
; ((alpine_attribute
;    (attribute_name)
;    (quoted_attribute_value
;      (attribute_value) @injection.content
;      (#set! injection.language "javascript")
;      (#set! injection.include-children))))
;
; ((expression_attribute
;    (attribute_name)
;    (quoted_attribute_value
;      (attribute_value) @injection.content
;      (#set! injection.language "php_only")
;      (#set! injection.include-children))))
;
; (php_directive
;   (raw_text) @injection.content
;   (#set! injection.language "php_only")
;   (#set! injection.include-children))
((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))

; tree-sitter-comment injection
; if available
((comment) @injection.content
 (#set! injection.language "comment"))

; could be bash or zsh
; or whatever tree-sitter grammar you have.
((text) @injection.content
    (#has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language bash))


((php_only) @injection.content
    (#set! injection.language php_only))

((parameter) @injection.content                                                                                                 
    (#set! injection.include-children) ; You may need this, depending on your editor e.g Helix                                                                                          
    (#set! injection.language "php-only"))
