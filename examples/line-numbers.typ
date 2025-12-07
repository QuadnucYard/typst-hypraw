#import "/src/lib.typ": *

#show: hypraw.with(line-numbers: true, copy-button: false)

= Hypraw Line Numbers Example

This demonstrates usage of hypraw with line numbers enabled (expressive-code style).

== Basic Usage

Enable line numbers for all code blocks in your document:

```typ
#show: hypraw.with(line-numbers: true)
```

== Code Examples

Here's a Rust example with line numbers:

```rust
fn main() {
    println!("Hello, world!");
    let x = 42;
    let y = x * 2;
    println!("x = {}, y = {}", x, y);
}
```

Here's a longer example to demonstrate line number width handling:

```js
// JavaScript example
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

const numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const doubled = numbers.map(n => n * 2);
const filtered = doubled.filter(n => n > 10);

console.log('Fibonacci sequence:');
for (let i = 0; i < 15; i++) {
    console.log(`  fib(${i}) = ${fibonacci(i)}`);
}

// More lines to show line number width adjustment
const result = filtered.reduce((acc, curr) => acc + curr, 0);
console.log(`Sum of filtered numbers: ${result}`);

export { fibonacci, numbers };
```

== HTML Output Structure

The line numbers feature generates this HTML structure:

```html
<div class="hypraw has-line-numbers">
  <pre><code data-lang="rust"><div class="ec-line"><div class="gutter"><div class="ln"><span aria-hidden="true">1</span></div></div><div class="code"><span class="c0">fn</span> <span class="c1">main</span>() {</div></div><!-- More lines... --></code></pre>
</div>
```

Key features:
- `.has-line-numbers` class enables line number layout via CSS
- Line numbers use `aria-hidden="true"` for accessibility (screen readers skip them)
- Grid layout separates gutter and code content
- CSS variable `--ln-width` adjusts for longer line numbers (> 99 lines)
- Gutter border provides visual separation

#html-script(read("copy-to-clipboard.js"))
#html-style(read("base.css"))
#html-style(read("line-numbers.css"))
