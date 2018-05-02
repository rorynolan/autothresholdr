pkgs <- c("hexSticker", "tidyverse", "here", "magick", "EBImage", "magrittr")
invisible(lapply(pkgs, library, character.only = TRUE))

sticker(here("junk", "autothresholdr.png"), package = "autothresholdr",
        filename = here("junk", "sticker.png"),
        s_x = 1, s_y = 1, s_width = 0.9,
        url = "github.com/rorynolan/autothresholdr",
        p_y = 1.5, p_color = "white", p_size = 5,
        u_x = 1.13, u_color = "black", u_size = 0.8,
        h_color = "orange", h_fill = "deeppink")
image_read(here("junk", "sticker.png"))
