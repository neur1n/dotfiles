use n_hl.nu
source n_palette.nu


let _plt = (n-get-palette)

let n_n = (n_hl create)

let n_bgh = (n_hl create $_plt.bgh)
let n_bgm = (n_hl create $_plt.bgm)
let n_bgs = (n_hl create $_plt.bgs)

let n_fgh = (n_hl create $_plt.fgh)
let n_fgm = (n_hl create $_plt.fgm)
let n_fgs = (n_hl create $_plt.fgs)

let n_grayh = (n_hl create $_plt.grayh)
let n_graym = (n_hl create $_plt.graym)
let n_grays = (n_hl create $_plt.grays)

let n_r = (n_hl create $_plt.red    )
let n_o = (n_hl create $_plt.orange )
let n_y = (n_hl create $_plt.yellow )
let n_g = (n_hl create $_plt.green  )
let n_b = (n_hl create $_plt.blue   )
let n_c = (n_hl create $_plt.cyan   )
let n_p = (n_hl create $_plt.purple )
let n_s = (n_hl create $_plt.special)

let n_rr = (n_hl reverse $n_r)
let n_or = (n_hl reverse $n_o)
let n_yr = (n_hl reverse $n_y)
let n_gr = (n_hl reverse $n_g)
let n_br = (n_hl reverse $n_b)
let n_cr = (n_hl reverse $n_c)
let n_pr = (n_hl reverse $n_p)
let n_sr = (n_hl reverse $n_s)
