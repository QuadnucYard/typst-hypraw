/// HTML output module for hypraw code highlighting.

#import "utils.typ": *

/// Maps CSS styles to generated class names for deduplication.
#let hl-class-db() = {
  query(<hypraw:style>).dedup().enumerate().map(((i, m)) => (m.value, "c" + str(i))).to-dict()
}

/// Applies HTML styling to a single text fragment. Generates a span element with CSS classes or inline styles.
#let code-span-rule(it) = {
  let fields = it.fields()
  if "attrs" in fields and "style" in fields.attrs {
    let style = fields.attrs.remove("style")
    [#metadata(style)<hypraw:style>]
    html.span(it.body, class: hl-class-db().at(style, default: "`"))
  } else {
    it
  }
}

/// Renders inline code as HTML `<code>` elements with syntax highlighting.
#let code-inline-rule(it) = {
  let attrs = (
    class: class-list("hypraw", if it.lang != none { "language-" + it.lang }),
  )

  html.elem("code", attrs: attrs, {
    it.lines.join("\n")
  })
}

/// Renders block code as HTML `<div><pre><code>` structure with syntax highlighting.
#let code-rule(it, copy-button: true) = {
  html.div(class: "hypraw", {
    // Add copy button if enabled
    if copy-button {
      html.elem("button", attrs: (
        class: "hypraw-copy-btn",
        aria-label: "Copy code",
        data-copy: it.text,
      ))
    }

    html.pre({
      let attrs = (:)
      if it.lang != none {
        attrs.data-lang = it.lang
      }
      html.elem("code", attrs: attrs, {
        it.lines.join("\n")
      })
    })
  })
}

/// Generates CSS styles for syntax highlighting. Creates `<style>` element with rules for HTML output.
#let additional-styles() = {
  if is-html-target() {
    let db = hl-class-db()
    if db.len() > 0 {
      db.pairs().map(((k, v)) => ".hypraw ." + v + "{" + k + "}\n").join()
    }
  }
}

