use platform

fn logo {
  if (eq $platform:os "darwin") {
    put "\nf179"
  } elif (eq $platform:os "linux") {
    put "\nf17c"
  } elif (eq $platform:os "windows") {
    put "\uf17a"
  }
}
