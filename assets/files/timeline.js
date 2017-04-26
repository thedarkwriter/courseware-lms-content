var timers = []

function clearAllTimers(t){
  t.forEach(function(timerid){
    clearTimeout(timerid);
  });
  timers = []
}

/* Trigger timing events on a particular slide's events */
function bind_times(times,slide){
  slide.bind("showoff:show", function (event) {
    clearAllTimers(timers);
    times.forEach(function(time,index) {
      $(".time" + (index + 1)).css('visibility', 'hidden');
      timers.push(setTimeout(function(){
        $(".time" + (index + 1)).css('visibility', 'visible');
      },time));
    });
  });
  slide.bind("showoff:prev", function (event) {
    clearAllTimers(timers);
  });
  slide.bind("showoff:next", function (event) {
    clearAllTimers(timers);
  });
}

/* Add timing events to a slide */
function timeline(times, slidename) {
  slide = $(".slide." + slidename);
  bind_times(times,slide);
}

/* Trigger audio events on a slide's events */
function bind_audio(slide, player, repeat, pause, countdown, pauseAtEndOfSlide = 1000){
  player.addEventListener("loadeddata", function() {
    slide.bind("showoff:show", function(event){
      timeRemaining = player.duration * 1000 + pauseAtEndOfSlide;
      player.currentTime = 0;
      player.play();
			countdownTimer = startTimer(timeRemaining / 1000, countdown);	
      countdownTimeout = setTimeout(function(){
        nextStep()
      },timeRemaining);
      timers.push(countdownTimeout);
      repeat.click(function(){
        slide.trigger("showoff:show");
      });
      pause.click(function(){
        player.pause();
      });
    });
    slide.bind("showoff:prev", function (event) {
      pause.trigger("click")
    });
    slide.bind("showoff:next", function (event) {
      pause.trigger("click")
    });
  });
}

/* Attach audio to a slide 
 * Assumes there is a audio directory with mp3 files
 * matching each slide class name*/
function audio(slidename){
  slide = $(".slide." + slidename);
  slide.append(`
    <audio id="${slidename}" >
      <source src="file/_files/audio/${slidename}.mp3" type="audio/mpeg">
    </audio>`);
  player = $("#" + slidename)[0];
	slide.append(`
    <div class="countdown" width="100%" hidden="true">
      <i class="fa fa-repeat fa-fw" aria-hidden="true" hidden="true"></i>
      <i class="fa fa-pause fa-fw" aria-hidden="true" hidden="true"></i>
      <svg class="countdown-timer" width="90%">
        <rect width="0%" height="10"/>
      </svg>
    </div>`);
  repeat = slide.find(".countdown > .fa-repeat");
  pause = slide.find(".countdown > .fa-pause");
  countdown = slide.find(".countdown-timer > rect");

  bind_audio(slide,player,repeat,pause,countdown,5000);
}

/* Shorten element over a duration by % */
function startTimer(duration, display) {
  var tick = (100 / duration) / 100
  var timer = duration * tick * 100
  return setInterval(function () {
    display.attr("width", (100 - timer) + "%");
    timer = timer - tick
    if (timer < 0) {
        timer = duration;
    }
  }, 10);
}
