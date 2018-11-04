## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7, fig.height = 6
)
library(lattice)

## ----load libraries, results='hide'--------------------------------------
library(autothresholdr)
library(ijtiff)
library(magrittr)

## ----the image-----------------------------------------------------------
img <- read_tif(system.file("extdata", "fiji_eg.tif", 
                            package = "autothresholdr"))
dim(img)
display(img[, , 1, 1])  # first channel, first frame

## ----guess twenty--------------------------------------------------------
display(img[, , 1, 1] > 20)

## ----thresh mask apply---------------------------------------------------
auto_thresh(img, "huang")
auto_thresh_mask(img, "huang") %>% {display(.[, , 1, 1])}
auto_thresh_apply_mask(img, "huang") %>% {display(.[, , 1, 1])}

## ----the image stack-----------------------------------------------------
img <- read_tif(system.file("extdata", "50.tif", 
                            package = "autothresholdr"))
dim(img)
display(img[, , 1, 1])
mean_stack_thresh(img, "tri") %>% {display(.[, , 1, 1])}
med_stack_thresh(img, "tri") %>% {display(.[, , 1, 1])}

