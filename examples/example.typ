#import "/src/lib.typ": *

#show: hypraw.with(copy-button: false)

= Hypraw Example (Without Copy Buttons)

This demonstrates usage of hypraw with copy buttons disabled.

All code blocks in this document have no copy buttons. This is controlled by the global setting:

```typ
#show: hypraw.with(copy-button: false)
```

== Inline Code

Inline raw: `#import "/src/lib.typ": *` or with language ```typ #import "/src/lib.typ": *```

== Block Code

```typ
#let hypraw(body, dedup-styles: true) = context {
  if is-html-target() {
    import "core.typ": show-html, show-html-inline

    show raw: it => {
      show underline: html.elem.with("span", attrs: (class: "underline"))
      it
    }
    show raw.where(block: false): show-html-inline.with(dedup-styles: dedup-styles)
    show raw.where(block: true): show-html.with(dedup-styles: dedup-styles)
    body
  } else {
    body
  }
}
```

== Note

Since `hypraw` is stateless and affects the entire document, you cannot mix enabled and disabled copy buttons within the same document. Use separate documents for different settings.

#html-style(read("example.css"))
