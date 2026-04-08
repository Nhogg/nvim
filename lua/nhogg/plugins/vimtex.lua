return {
  "lervag/vimtex",
  lazy = false, -- Important: VimTeX needs to load at startup for filetype detection
  init = function()
    -- Use Zathura as the PDF viewer (Best for Arch/Omarchy)
    vim.g.vimtex_view_method = "zathura"
    
    -- Do not open the quickfix window automatically on error
    vim.g.vimtex_quickfix_mode = 0
    
    -- Optional: Conceal math symbols (e.g., \alpha displays as α in the editor)
    -- vim.opt.conceallevel = 1
    -- vim.g.tex_conceal = "abdmg"
  end,
}
