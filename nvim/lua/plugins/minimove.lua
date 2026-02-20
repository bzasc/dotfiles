-- Moving selections.
return {
    {
        'nvim-mini/mini.move',
        event = 'BufReadPre',
        opts = {
            mappings = {
                left      = '<C-Left>',
                right     = '<C-Right>',
                down      = '<S-Down>',
                up        = '<S-Up>',
                line_left  = '<C-Left>',
                line_right = '<C-Right>',
                line_down  = '<S-Down>',
                line_up    = '<S-Up>',
            },
        },
    },
}
