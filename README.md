# Hypraw

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A lightweight package for creating headless code blocks optimized for HTML export. Inspired by [zebraw](https://github.com/hongjr03/typst-zebraw).

## Features

- Zero configuration — works with `#show: hypraw`
- Generates clean, semantic HTML structure
- CSS class deduplication for smaller output
- Only affects HTML output; other formats remain unchanged

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

## API

### `hypraw(body, dedup-styles: true, attach-styles: true)`

Enables enhanced HTML code block rendering.

### `hypraw-styles(styles)`

Adds custom CSS styles for HTML output. Accepts a CSS string or file content.

```typ
#hypraw-styles(".hypraw { background: #f5f5f5; }")
// Or read from file
#hypraw-styles(read("styles.css"))
```

### `additional-styles()`

Returns additional style strings when deduplication is enabled.
Call this when you set `attach-styles` to `false`.

## HTML Output

Generates headless HTML structure that you can style with your own CSS:

```html
<div class="hypraw">
  <pre><code class="language-rust">
    <span class="c0">fn</span> <span class="c1">main</span>...
  </code></pre>
</div>
```

## License

MIT License — see [LICENSE](LICENSE) for details.
