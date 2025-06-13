/// A lightweight package for creating headless code blocks optimized for HTML export.

#import "core.typ": additional-styles
#import "utils.typ": is-html-target

/// Creates a custom `<style>` element for HTML output. Ignored for other formats.
#let hypraw-styles(styles) = context {
  if is-html-target() {
    html.elem("style", styles)
  }
}

/// Enables enhanced HTML code block rendering. Transforms raw code blocks
/// into structured HTML when targeting HTML, preserves normal behavior otherwise.
///
/// - dedup-styles (bool): Deduplicate CSS styles for smaller output (default: true)
/// - attach-styles (bool): Automatically include generated CSS styles (default: true)
#let hypraw(body, dedup-styles: true, attach-styles: true) = context {
  if is-html-target() {
    import "core.typ": show-html, show-html-inline

    show raw: it => {
      show underline: html.elem.with("span", attrs: (class: "underline"))
      it
    }
    show raw.where(block: false): show-html-inline.with(dedup-styles: dedup-styles)
    show raw.where(block: true): show-html.with(dedup-styles: dedup-styles)
    body

    if attach-styles {
      hypraw-styles(additional-styles())
    }
  } else {
    body
  }
}
