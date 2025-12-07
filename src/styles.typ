
#let hypraw-state = state("hypraw-style", (:))

/// Override settings for the next code block only. Settings reset after use.
///
/// - line-numbers (auto, bool, int, array, none): Line number configuration:
///   - `none` or `false`: Disable line numbers
///   - `true`: Enable with default start (1)
///   - `int`: Start from this line number
///   - `array`: Custom labels per line (must match line count)
/// - copy-button (auto, bool): Enable/disable copy button for next block
#let hypraw-set(line-numbers: auto, copy-button: auto) = context {
  if line-numbers != auto {
    hypraw-state.update(s => {
      s.line-numbers = line-numbers
      s
    })
  }
  if copy-button != auto {
    hypraw-state.update(s => {
      s.copy-button = copy-button
      s
    })
  }
}

#let resolve-line-numbers(line-numbers, line-count) = {
  if line-numbers == false or line-numbers == none {
    // No line number
    none
  } else if line-numbers == true {
    // Use 1 as default start number
    range(1, 1 + line-count)
  } else if type(line-numbers) == int {
    // As start number
    range(line-numbers, line-numbers + line-count)
  } else if type(line-numbers) == array {
    // As specified numbers.
    if line-numbers.len() != line-count {
      panic(
        "Should provide line numbers for each line. Expected "
          + str(line-count)
          + ", received "
          + str(line-numbers.len())
          + ".",
      )
    }
    line-numbers
  } else {
    // Invalid
    panic("Invalid line numbers format: " + repr(line-numbers))
  }
}
