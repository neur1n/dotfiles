def --env fast [] {
  let selection = ($nu.temp-dir | path join $"fast-selection-(random uuid).bin")
  let fast_bin = ($env.FAST_BIN? | default "fast")

  # Keep the TUI attached to the terminal while ignoring cancellation errors.
  do --ignore-errors { run-external $fast_bin "--select" $selection }

  if ($selection | path exists) {
    let target = (
      open --raw $selection
      | decode utf-8
      | str trim --right --char (char nul)
    )
    do --ignore-errors { rm --permanent --force $selection }

    if not ($target | is-empty) {
      cd $target
    }
  }
}
