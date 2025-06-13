#import "/src/lib.typ": *

#show: hypraw

Inline raw:

`#import "/src/lib.typ": *`
or
```typ #import "/src/lib.typ": *```

Blocky raw:

```typ
#let hypraw(body, dedup-styles: true) = context {
  if is-html-target() {
    import "html.typ": hypraw-html-show, hypraw-html-show-inline

    show raw: it => {
      show underline: html.elem.with("span", attrs: (class: "underline"))
      it
    }
    show raw.where(block: false): hypraw-html-show-inline.with(dedup-styles: dedup-styles)
    show raw.where(block: true): hypraw-html-show.with(dedup-styles: dedup-styles)
    body
  } else {
    body
  }
}
```

#hypraw-styles(read("example.css"))
