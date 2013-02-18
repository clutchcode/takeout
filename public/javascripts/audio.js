
function doAudioPlayer() {
    var audio = $('#audio').get(0);
    audio.preload = true;
    audio.autoplay = false;

    var loadTrack = function(track) {
        $(track).addClass('playing').siblings().removeClass('playing');
        audio.src = $(track).find('a[data-src]').attr('data-src');
        audio.load();
    };

    var firstTrack = function() {
        var first = $('ol li').first();
        loadTrack(first);
    };

    var nextTrack = function() {
        var next = $('ol li.playing').next();
        if (!next.length) {
            next = $('ol li').first();
        }
        loadTrack(next);
    };

    var prevTrack = function() {
        var prev = $('ol li.playing').prev();
        if (!prev.length) {
            prev = $('ol li').last();
        }
        loadTrack(prev);
    };

    var playPause = function() {
        if (audio.autoplay) {
            audio.pause();
        }
        else {
            audio.play();
        }
    };

    $('ol li').click(function(e) {
        e.preventDefault();
        if ($(this).hasClass('playing')) {
            playPause();
        }
        else {
            audio.autoplay = true;
            loadTrack(this);
        }
    });

    audio.addEventListener('play', function() {
        audio.autoplay = true;
    });

    audio.addEventListener('pause', function() {
        audio.autoplay = false;
    });

    audio.addEventListener('ended', function() {
        nextTrack();
    });

    $(document).keydown(function(e) {
        var unicode = e.charCode ? e.charCode : e.keyCode;
        if (unicode == 39) {
            nextTrack();
        }
        else if (unicode == 37) {
            prevTrack();
        }
        else if (unicode == 32) {
            playPause();
        }
    })

    firstTrack();
}
