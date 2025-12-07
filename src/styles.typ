
#let _hypraw-state = state("hypraw-style", (:))

///
///
/// - line-numbers ():
/// - copy-button ():
/// ->
#let hypraw-set(line-numbers: auto, copy-button: auto) = context {
  if line-numbers != auto {
    _hypraw-state.update(s => {
      s.line-numbers = line-numbers
      s
    })
  }
  if copy-button != auto {
    _hypraw-state.update(s => {
      s.copy-button = copy-button
      s
    })
  }
}

#let retrieve-styles() = {
  let style-state = _hypraw-state.get()
  _hypraw-state.update((:)) // Reset upon used
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
    range(1, line-numbers + line-count)
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
