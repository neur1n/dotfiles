def --env fast [] {
  let selection_file = ($nu.temp-dir | path join $"fast-selection-(random uuid).bin")
  let fast_bin = ($env.FAST_BIN? | default "fast")

  # Keep the TUI attached to the terminal while ignoring cancellation errors.
  do --ignore-errors { run-external $fast_bin "--select" $selection_file }

  if ($selection_file | path exists) {
    let target = (
      open --raw $selection_file
      | decode utf-8
      | str trim --right --char (char nul)
    )
    do --ignore-errors { rm --permanent --force $selection_file }

    if not ($target | is-empty) {
      cd $target
    }
  }
}
