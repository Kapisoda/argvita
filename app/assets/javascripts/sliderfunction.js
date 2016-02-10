 $(function () {

        $("#range").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: 0,
            max: 5000,
            from: 0,
            to: 5000,
            type: 'double',
            step: 10,
            prefix: " kn",
            grid: true
        });

    });
