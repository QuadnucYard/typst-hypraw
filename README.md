# Hypraw

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A lightweight package for creating headless code blocks optimized for HTML export. Inspired by [zebraw](https://github.com/hongjr03/typst-zebraw).

## Features

- Generates clean, semantic HTML structure
- CSS class deduplication for smaller output
- **Line numbers** — expressive-code styled gutter with proper accessibility
- **Copy button support** — headless, accessible, and customizable

## Installation

Since this package is HTML-only (not accepted by Typst Universe), you can install it via:

- [typship](https://github.com/sjfhsjfh/typship) package manager
- Manual installation to local packages directory
- Git submodule in your project

## Usage

````typ
#show: hypraw

Here's inline code: `println!("Hello!")`

```rust
fn main() {
    println!("Hello, world!");
}
```

#hypraw-styles(read("styles.css"))
````

See `examples/` directory for complete styling implementation.

**Important**: `hypraw` is stateless and should only be used once per document. It applies globally to all code blocks in the document. Multiple `#show: hypraw` calls are unnecessary and should be avoided.

## API

### `hypraw(..)`

Enables enhanced HTML code block rendering.

```typ
// Enable hypraw for entire document (use only once)
#show: hypraw

// Enable line numbers (expressive-code style)
#show: hypraw.with(line-numbers: true)

// To disable copy button for entire document
#show: hypraw.with(copy-button: false)

// Custom settings for entire document
#show: hypraw.with(dedup-styles: false, attach-styles: false)
```

### `hypraw-set(line-numbers: auto, copy-button: auto)`

Override settings for the next code block only. Resets after use.

```typ
// Disable line numbers for this block (when globally enabled)
#hypraw-set(line-numbers: none)

// Start from line 2
#hypraw-set(line-numbers: 2)

// Custom labels per line (e.g., for diff display)
#hypraw-set(line-numbers: ("+", "-"))
```

### `additional-styles()`

Returns additional style strings when deduplication is enabled.
Call this when you set `attach-styles` to `false`.

### `html-style(style)`

Adds custom CSS styles for HTML output. Accepts a CSS string or file content.

```typ
#html-style(".hypraw { background: #f5f5f5; }")
// Or read from file
#html-style(read("styles.css"))
```

### `html-script(script)`

Similar to `html-style`, it creates a `<script>` element.

## HTML Output

Generates headless HTML structure that you can style with your own CSS:

```html
<div class="hypraw">
  <button class="hypraw-copy-btn" aria-label="Copy code" data-copy="..." />
  <pre><code data-lang="rust">
    <span class="c0">fn</span> <span class="c1">main</span>...
  </code></pre>
</div>
```

### With Line Numbers

When `line-numbers: true` is enabled, the structure includes a gutter:

```html
<div class="hypraw has-line-numbers" style="--ln-width:3ch">
  <button class="hypraw-copy-btn" aria-label="Copy code" data-copy="..." />
  <pre><code data-lang="rust"><div class="ec-line"><div class="gutter"><div class="ln"><span aria-hidden="true">1</span></div></div><div class="code"><span class="c0">fn</span> <span class="c1">main</span>() {</div></div><!-- More lines... --></code></pre>
</div>
```

Key features:
- `.has-line-numbers` class enables line number layout
- `aria-hidden="true"` on line numbers for screen reader accessibility
- `--ln-width` CSS variable auto-adjusts for longer line numbers
- Grid layout separates gutter from code content
- `.ec-line` class follows expressive-code conventions

### Copy Button

The copy button includes:

- `data-copy` attribute with the raw code content
- Proper accessibility attributes
- CSS classes for styling and state management

For maximal flexibility, copy buttons are headless. You need to add `<style>` and `<script>` for them, or use our those in our examples.

## License

MIT License — see [LICENSE](LICENSE) for details.
