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

/// Renders a single line with optional line number gutter.
#let render-line(line, line-number) = {
  html.div(class: "ec-line", {
    // Add gutter with line number
    html.div(class: "gutter", {
      html.div(class: "ln", {
        html.span(aria-hidden: true, str(line-number))
      })
    })
    // Code content
    html.div(class: "code", line)
  })
}

/// Renders block code as HTML `<div><pre><code>` structure with syntax highlighting.
/// Supports optional line numbers displayed in a gutter.
#let code-rule(it, copy-button: true, line-numbers: false, start-line-number: 1) = {
  let line-count = it.lines.len()
  // Calculate the width needed for line numbers (number of digits)
  let end-line = start-line-number + line-count - 1
  let ln-width = calc.max(str(start-line-number).len(), str(end-line).len())

  let attrs = (class: "hypraw")
  // Add class to indicate line numbers are enabled
  if line-numbers {
    attrs.class = "hypraw has-line-numbers"
    // Set line number width as CSS variable when width > 2
    if ln-width > 2 {
      attrs.style = "--ln-width:" + str(ln-width) + "ch"
    }
  }

  html.div(..attrs, {
    // Add copy button if enabled
    if copy-button {
      html.elem("button", attrs: (
        class: "hypraw-copy-btn",
        aria-label: "Copy code",
        data-copy: it.text,
      ))
    }

    html.pre({
      let code-attrs = (:)
      if it.lang != none {
        code-attrs.data-lang = it.lang
      }
      html.elem("code", attrs: code-attrs, {
        if line-numbers {
          // Render with line structure for line numbers
          for (i, line) in it.lines.enumerate() {
            render-line(line, i + start-line-number)
          }
        } else {
          // Original simple rendering without line structure
          it.lines.join("\n")
        }
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

