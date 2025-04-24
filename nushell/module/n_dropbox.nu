export def ignore [path: path] {
  let cmd = [
              "powershell", "-command", "Set-Content", "-Path", $path,
              "-Stream", "com.dropbox.ignored", "-Value", "1"
            ]
  run-external ...$cmd
}
