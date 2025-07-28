/// A lightweight package for creating headless code blocks optimized for HTML export.

#import "core.typ": additional-styles
#import "utils.typ": is-html-target

/// Creates a custom `<style>` element for HTML output. Ignored for other formats.
#let html-style(style) = context {
  if is-html-target() {
    html.elem("style", style)
  }
}

/// Creates a custom `<script>` element for HTML output. Ignored for other formats.
#let html-script(script) = context {
  if is-html-target() {
    html.elem("script", script)
  }
}

/// Enables enhanced HTML code block rendering. Transforms raw code blocks
/// into structured HTML when targeting HTML, preserves normal behavior otherwise.
///
/// - dedup-styles (bool): Deduplicate CSS styles for smaller output (default: true)
/// - attach-styles (bool): Automatically include generated CSS styles (default: true)
/// - copy-button (bool): Add copy button to code blocks (default: true)
#let hypraw(body, dedup-styles: true, attach-styles: true, copy-button: true) = context {
  if is-html-target() {
    import "core.typ": code-inline-rule, code-rule

    show raw: it => {
      show underline: html.elem.with("span", attrs: (class: "underline"))
      it
    }
    show raw.where(block: false): code-inline-rule.with(dedup-styles: dedup-styles)
    show raw.where(block: true): code-rule.with(
      dedup-styles: dedup-styles,
      copy-button: copy-button,
    )
    body

    if attach-styles {
      html-style(additional-styles())
    }
  } else {
    body
  }
}
