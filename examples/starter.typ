#import "/src/lib.typ": *

#show: hypraw.with(line-numbers: false, copy-button: false)

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
#let hypraw(body, dedup-styles: true, attach-styles: true, copy-button: true) = context {
  if not is-html-target() {
    return body
  }

  import "core.typ": code-inline-rule, code-rule, code-span-rule

  // Dedup styles and override code rendering rules
  show html.elem.where(tag: "code"): it => if dedup-styles {
    show html.elem.where(tag: "span"): code-span-rule
    it
  } else {
    it
  }
  show raw.where(block: false): code-inline-rule
  show raw.where(block: true): code-rule.with(copy-button: copy-button)
  body

  // Attach generated styles at the end of the document
  if attach-styles {
    html-style(additional-styles())
  }
}
```

== Note

Since `hypraw` is stateless and affects the entire document, you cannot mix enabled and disabled copy buttons within the same document. Use separate documents for different settings.

#html-style(read("base.css"))
