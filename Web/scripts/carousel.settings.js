(function () {
    var mycarousel_initCallback = function (carousel) {
        // Pause autoscrolling if the user moves with the cursor over the clip.
        carousel.clip.hover(function () {
            carousel.stopAuto();
        }, function () {
            carousel.startAuto();
        });
    };

    var init = function () {
        var $this = $(this);
        var settings = $this.data('settings') || {
            height: "100%",
            width: "100%",
            auto: 6,    
            wrap: 'circular',
            scroll: 1
        };

        $this.jcarousel({
            auto: settings.auto,
            wrap: settings.wrap,
            scroll: settings.scroll,
            initCallback: mycarousel_initCallback,
            itemVisibleInCallback: {
                onAfterAnimation: function (carousel, li, index, state) {
                    $('.carousel-paging .carousel-paging-item').removeClass('active');
                    var $items = $('.carousel-paging .carousel-paging-item');
                    $($items.get((index - 1) % $items.length)).addClass('active');
                }
            }
        });
    };

    $(function () {
        $(".carousel").each(init);
    });
} ());