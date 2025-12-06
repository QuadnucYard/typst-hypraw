/// A lightweight package for creating headless code blocks optimized for HTML export.

#import "core.typ": additional-styles
#import "utils.typ": is-html-target

/// Creates a custom `<style>` element for HTML output. Ignored for other formats.
#let html-style(style) = context {
  if is-html-target() {
    html.style(style)
  }
}

/// Creates a custom `<script>` element for HTML output. Ignored for other formats.
#let html-script(script) = context {
  if is-html-target() {
    html.script(script)
  }
}

/// Enables enhanced HTML code block rendering. Transforms raw code blocks
/// into structured HTML when targeting HTML, preserves normal behavior otherwise.
///
/// - dedup-styles (bool): Deduplicate CSS styles for smaller output (default: true)
/// - attach-styles (bool): Automatically include generated CSS styles (default: true)
/// - copy-button (bool): Add copy button to code blocks (default: true)
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
