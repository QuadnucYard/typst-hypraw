# Hypraw

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A lightweight package for creating headless code blocks optimized for HTML export. Inspired by [zebraw](https://github.com/hongjr03/typst-zebraw).

## Features

- Generates clean, semantic HTML structure
- CSS class deduplication for smaller output
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

### `hypraw(body, dedup-styles: true, attach-styles: true, copy-button: true)`

Enables enhanced HTML code block rendering.

```typ
// Enable hypraw for entire document (use only once)
#show: hypraw

// To disable copy button for entire document
#show: hypraw.with(copy-button: false)

// Custom settings for entire document
#show: hypraw.with(dedup-styles: false, attach-styles: false)
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
  <pre><code class="language-rust">
    <span class="c0">fn</span> <span class="c1">main</span>...
  </code></pre>
</div>
```

The copy button includes:

- `data-copy` attribute with the raw code content
- Proper accessibility attributes
- CSS classes for styling and state management

For maximal flexibility, copy buttons are headless. You need to add `<style>` and `<script>` for them, or use our those in our examples.

## License

MIT License — see [LICENSE](LICENSE) for details.
