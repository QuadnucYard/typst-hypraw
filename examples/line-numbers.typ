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

== Line Number Customization

Use `hypraw-set()` to override settings for individual code blocks:

Disable line numbers for this block only:

#hypraw-set(line-numbers: none)
```typ
= H1
== H2
```

Start from line 2:

#hypraw-set(line-numbers: 2)
```typ
= H1
== H2
```

Custom labels per line (e.g., for diff indicators):

#hypraw-set(line-numbers: ("+", "-"))
```typ
= H1
== H2
```

== Line Highlighting

Highlight specific lines (0-based indices):

#hypraw-set(highlight: (0, 2))
```js
console.log('Line 0 - highlighted');
console.log('Line 1 - normal');
console.log('Line 2 - highlighted');
```

Highlight ranges and individual lines:

#hypraw-set(highlight: (0, (2, 4)))
```js
console.log('Line 0 - highlighted');
console.log('Line 1 - normal');
console.log('Line 2 - highlighted');
console.log('Line 3 - highlighted');
console.log('Line 4 - highlighted');
```

Use different highlight styles (ins/del/mark):

#hypraw-set(highlight: (ins: (0, 1), del: (3,), mark: (5,)))
```js
console.log('Line 0 - inserted');
console.log('Line 1 - inserted');
console.log('Line 2 - normal');
console.log('Line 3 - deleted');
console.log('Line 4 - normal');
console.log('Line 5 - marked');
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
