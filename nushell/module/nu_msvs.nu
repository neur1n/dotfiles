use std-rfc/kv *

export-env {
  job spawn {find}
}

export def --env activate [
    --host   (-h): string = "x64",    # Host architecture, must be x64 or x86 (case insensitive)
    --target (-t): string = "x64",    # Target architecture, must be x64 or x86 (case insensitive)
    --sdk    (-s): string = "latest"  # Version of Windows SDK, must be "latest" or a valid version string
  ] {
  if ($env.MSVS_ROOT? | is-empty) {
    find
    kv get "msvs envars" | load-env
  }

  if (($env.MSVS_ROOT | is-empty) or ($env.MSVS_MSVC_ROOT | is-empty)) {
    print "Neither Microsoft Visual Studio nor MSVC is available."
    return
  }

  let fh = ($host | str downcase)
  let ft = ($target | str downcase)
  let fs = (if ($sdk != "latest") {$sdk} else {$env.MSVS_MSDK_VER})

  if (($fh != "x64") and ($fh != "x86")) {
    print $"Wrong host architecture specified: ($fh)."
    help msvs activate
    return
  }

  if (($ft != "x64") and ($ft != "x86")) {
    print $"Wrong target architecture specified: ($ft)."
    help msvs activate
    return
  }

  if not ($"($env.MSVS_MSDK_ROOT)bin/($fs)" | path exists) {
    print $"Invalid Windows SDK version specified: ($fs)."
    return
  }

  let env_path = [
    $"($env.MSVS_ROOT)/../Shared/Common/VSPerfCollectionTools/vs2019",
    $"($env.MSVS_ROOT)/Common7/IDE",
    $"($env.MSVS_ROOT)/Common7/IDE/CommonExtensions/Microsoft/TestWindow",
    $"($env.MSVS_ROOT)/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer",
    $"($env.MSVS_ROOT)/Common7/IDE/Extensions/Microsoft/IntelliCode/CLI",
    $"($env.MSVS_ROOT)/Common7/IDE/Tools",
    $"($env.MSVS_ROOT)/Common7/IDE/VC/VCPackages",
    $"($env.MSVS_ROOT)/Common7/Tools/devinit",
    $"($env.MSVS_ROOT)/MSBuild/Current/bin",
    $"($env.MSVS_ROOT)/MSBuild/Current/bin/Roslyn",
    $"($env.MSVS_ROOT)/Team Tools/DiagnosticsHub/Collector",
    $"($env.MSVS_ROOT)/Team Tools/Performance Tools",
    $"($env.MSVS_MSVC_ROOT)/bin/Host($fh)/($ft)",
    $"($env.MSVS_MSDK_ROOT)bin/($ft)",
    $"($env.MSVS_MSDK_ROOT)bin/($fs)/($ft)"
  ]

  let env_path = (
      if ($ft == "x64") {
        ($env_path | prepend $"($env.MSVS_ROOT)/../Shared/Common/VSPerfCollectionTools/vs2019/x64")
      } else {
        $env_path
      })

  let env_path = (
      if ($ft == "x64") {
        ($env_path | prepend $"($env.MSVS_ROOT)/Team Tools/Performance Tools/x64")
      } else {
        $env_path
      })

  let env_path = (
      if ($ft != $fh) {
        ($env_path | prepend $"($env.MSVS_MSVC_ROOT)/bin/Host($fh)/($fh)")
      } else {
        $env_path
      })

  let env_path = ($env.MSVS_BASE_PATH | prepend $env_path)

  let lib_path = ([
    $"($env.MSVS_MSDK_ROOT)Lib/($env.MSVS_MSDK_VER)/ucrt/($ft)",
    $"($env.MSVS_MSDK_ROOT)Lib/($env.MSVS_MSDK_VER)/um/($ft)",
    $"($env.MSVS_MSVC_ROOT)/lib/($ft)",
  ] | str join ";")

  load-env {
    Path: $env_path,
    INCLUDE: $env.MSVS_INCLUDE_PATH,
    LIB: $lib_path
  }

  $env.MSVS_ACTIVATED = true
}

export def --env deactivate [] {
  if ($env.MSVS_ROOT? | is-empty) {
    find
    kv get "msvs envars" | load-env
  }

  if (($env.MSVS_ROOT? | is-empty) or ($env.MSVS_MSVC_ROOT? | is-empty)) {
    print "Neither Microsoft Visual Studio nor MSVC is available."
    return
  }

  load-env {
    Path: $env.MSVS_BASE_PATH,
  }

  hide-env MSVS_BASE_PATH
  hide-env MSVS_ACTIVATED
  hide-env MSVS_ROOT
  hide-env MSVS_MSVC_ROOT
  hide-env MSVS_MSDK_ROOT
  hide-env MSVS_MSDK_VER
  hide-env MSVS_INCLUDE_PATH
  hide-env INCLUDE
  hide-env LIB
}

export def find [] {
  let base_path = $env.Path

  let info = (
      if not (which vswhere | is-empty) {
        (vswhere -nocolor -nologo -sort -utf8 -format json | from json)
      } else {
        ('{"installationPath": [""]}' | from json)
      }
  )

  let root = ($info.installationPath.0 | str replace -a '\\' '/')

  let msvc_root = (
      if not ($"($root)/VC/Tools/MSVC/" | path exists) {
        ""
      } else if (ls ($"($root)/VC/Tools/MSVC/*" | into glob) | is-empty) {
        ""
      } else {
        ((ls ($"($root)/VC/Tools/MSVC/*" | into glob)).name.0 | str replace -a '\\' '/')
      })

  let msdk_root = (registry query --hklm 'SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v10.0' InstallationFolder | get value)

  let msdk_ver = (registry query --hklm 'SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v10.0' ProductVersion | get value) + ".0"

  let include_path = ([
    $"($root)/Include/($msdk_ver)/cppwinrt/winrt",
    $"($msvc_root)/include",
    $"($msdk_root)Include/($msdk_ver)/cppwinrt/winrt",
    $"($msdk_root)Include/($msdk_ver)/shared",
    $"($msdk_root)Include/($msdk_ver)/ucrt",
    $"($msdk_root)Include/($msdk_ver)/um",
    $"($msdk_root)Include/($msdk_ver)/winrt"
  ] | str join ";")

  let vars = {
    MSVS_BASE_PATH: $base_path
    MSVS_ACTIVATED: false
    MSVS_ROOT: $root,
    MSVS_MSVC_ROOT: $msvc_root,
    MSVS_MSDK_ROOT: $msdk_root,
    MSVS_MSDK_VER: $msdk_ver,
    MSVS_INCLUDE_PATH: $include_path,
  }

  kv set "msvs envars" $vars
}
