$(document).ready(function(){$("#content-slider").lightSlider({loop:!0,keyPress:!0}),$("#image-gallery").lightSlider({gallery:!0,item:1,thumbItem:4,slideMargin:0,speed:500,auto:!1,loop:!0,onSliderLoad:function(){$("#image-gallery").removeClass("cS-hidden")}})});