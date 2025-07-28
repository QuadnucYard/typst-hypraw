#import "/src/lib.typ": *

#show: hypraw

= CSS Customization Examples

This document demonstrates how to customize copy button appearance using CSS targeting techniques.

*Note:* All customization is achieved through CSS using selectors like `:nth-of-type()` or custom classes. See `copy-button-styles.css` for implementation details.

== Method 1: CSS Content

#let m1 = ```css
/* Targets the first code block */
.hypraw:nth-of-type(1) .hypraw-copy-btn::before {
  content: "Copy";
  font-size: 0.875rem;
  font-family: system-ui, sans-serif;
}

.hypraw:nth-of-type(1) .hypraw-copy-btn.copied::before {
  content: "✓ Copied!";
  color: hsla(120, 60%, 40%, 1);
}
```
#m1

#let m2 = ```css
.hypraw:nth-of-type(2) .hypraw-copy-btn::before {
  content: "📄 Copy Code";
  font-size: 0.875rem;
}

.hypraw:nth-of-type(2) .hypraw-copy-btn.copied::before {
  content: "✅ Copied!";
}
```
#m2

#let m3 = ```css
.hypraw:nth-of-type(3) .hypraw-copy-btn::before {
  content: "📑";
  font-size: 1rem;
}

.hypraw:nth-of-type(3) .hypraw-copy-btn.copied::before {
  content: "✅";
}
```
#m3

== Method 2: CSS Custom Properties

#let m4 = ```css
/* Method 2: CSS custom properties for easy theming */
.hypraw:nth-of-type(4) {
  --copy-btn-content: "📋 Copy";
  --copy-btn-content-copied: "✅ Copied!";
}

.hypraw:nth-of-type(4) .hypraw-copy-btn::before {
  content: var(--copy-btn-content);
  font-size: 0.875rem;
}

.hypraw:nth-of-type(4) .hypraw-copy-btn.copied::before {
  content: var(--copy-btn-content-copied);
}
```
#m4

#html-script(read("copy-to-clipboard.js"))
#html-style(read("copy-button-styles.css") + (m1, m2, m3, m4).map(it => it.text).join())
