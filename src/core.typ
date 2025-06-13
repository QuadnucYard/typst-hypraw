/// HTML output module for hypraw code highlighting.

#import "utils.typ": *

/// Maps CSS styles to generated class names for deduplication.
#let hl-class-db() = {
  query(<hypraw:style>).dedup().enumerate().map(((i, m)) => (m.value, "c" + str(i))).to-dict()
}

/// Applies HTML styling to a single text fragment. Generates a span element with CSS classes or inline styles.
#let style-code-text(it, default-color: black, dedup-styles: true) = context {
  // Skip empty lines
  if it.text == "" {
    return none
  }

  // Return whitespace as-is
  if it.text.trim().len() == 0 {
    return it
  }

  // Build CSS style string based on text properties
  let style = {
    let fill = text.fill
    let weight = text.weight

    // Add color style if different from default
    if fill != default-color {
      "color:" + fill.to-hex() + ";"
    }

    // Add font weight if not regular
    if weight != "regular" {
      "font-weight:" + weight
    }
  }

  // Wrap in span element if styling is needed, otherwise return as-is
  if style != none {
    if dedup-styles {
      [#metadata(style)<hypraw:style>]
      context html.elem("span", attrs: (class: hl-class-db().at(style)), it)
    } else {
      html.elem("span", attrs: (style: style), it)
    }
  } else {
    it
  }
}

/// Renders inline code as HTML `<code>` elements with syntax highlighting.
#let show-html-inline(it, dedup-styles: true) = context {
  let default-color = text.fill

  let code-attrs = (
    class: class-list("hypraw", if it.lang != none { "language-" + it.lang }),
  )

  html.elem("code", attrs: code-attrs, {
    show text: style-code-text.with(default-color: default-color, dedup-styles: dedup-styles)
    it.lines.join("\n")
  })
}

/// Renders block code as HTML `<div><pre><code>` structure with syntax highlighting.
#let show-html(it, dedup-styles: true) = context {
  let default-color = text.fill

  html.elem("div", attrs: (class: "hypraw"), {
    html.elem("pre", {
      let code-attrs = (:)

      let cls = class-list(if it.lang != none { "language-" + it.lang })
      if cls != none and cls.len() > 0 {
        code-attrs.class = cls
      }
      html.elem("code", attrs: code-attrs, {
        show text: style-code-text.with(default-color: default-color, dedup-styles: dedup-styles)
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

