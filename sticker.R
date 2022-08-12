library(hexSticker)
library(magick)
library(sysfonts)
library(tidyverse)
st_img <- image_read("st.png")

sticker(
  subplot = st_img,
  package = "Mineração de Dados",
  s_width = 1.2,
  s_height = 1.5,
  s_x = 1,
  s_y = 0.75,
  p_size = 10,
  p_color = "black",
  h_fill = "white",
  filename = "md.png"
  ) %>% print()
