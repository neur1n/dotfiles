use n_hl.nu
use n_plt.nu


export env n_bgh {n_hl create (plt).bgh}
export env n_bgm {n_hl create (plt).bgm}
export env n_bgs {n_hl create (plt).bgs}

export env n_fgh {n_hl create (plt).fgh}
export env n_fgm {n_hl create (plt).fgm}
export env n_fgs {n_hl create (plt).fgs}

export env n_grayh {n_hl create (plt).grayh}
export env n_graym {n_hl create (plt).graym}
export env n_grays {n_hl create (plt).grays}

export env red     {n_hl create (plt).red    }
export env orange  {n_hl create (plt).orange }
export env yellow  {n_hl create (plt).yellow }
export env green   {n_hl create (plt).green  }
export env blue    {n_hl create (plt).blue   }
export env cyan    {n_hl create (plt).cyan   }
export env purple  {n_hl create (plt).purple }
export env special {n_hl create (plt).special}

export env rred     {n_hl reverse $env."n_cs red"    }
export env rorange  {n_hl reverse $env."n_cs orange" }
export env ryellow  {n_hl reverse $env."n_cs yellow" }
export env rgreen   {n_hl reverse $env."n_cs green"  }
export env rblue    {n_hl reverse $env."n_cs blue"   }
export env rcyan    {n_hl reverse $env."n_cs cyan"   }
export env rpurple  {n_hl reverse $env."n_cs purple" }
export env rspecial {n_hl reverse $env."n_cs special"}

export env rainbow {[
    $env."n_cs red",
    $env."n_cs orange",
    $env."n_cs yellow",
    $env."n_cs green",
    $env."n_cs blue",
    $env."n_cs cyan",
    $env."n_cs purple"
  ]
}

export env reverse-rainbow {[
    $env."n_cs rred",
    $env."n_cs rorange",
    $env."n_cs ryellow",
    $env."n_cs rgreen",
    $env."n_cs rblue",
    $env."n_cs rcyan",
    $env."n_cs rpurple"
  ]
}

def plt [] {
  (n_plt get-palette)
}
