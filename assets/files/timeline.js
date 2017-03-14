var timers = []

function clearAllTimers(t){
  t.forEach(function(timerid){
    clearTimeout(timerid);
  });
  timers = []
}

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

function timeline(times, slidename) {
  slide = $(".slide." + slidename);
  bind_times(times,slide);
}

function bind_audio(slide, player, pauseAtEndOfSlide = 1000){
  player.addEventListener("loadeddata", function() {
    slide.bind("showoff:show", function(event){
      player.currentTime = 0;
      player.play();
      timers.push(setTimeout(function(){
        nextStep()
      },player.duration * 1000 + pauseAtEndOfSlide));
    });
    slide.bind("showoff:prev", function (event) {
      player.pause();
    });
    slide.bind("showoff:next", function (event) {
      player.pause();
    });
  });
}

function audio(slidename){
  slide = $(".slide." + slidename);
  slide.append(`
    <audio id="${slidename}" preload="auto">
      <source src="file/_files/audio/${slidename}.mp3" type="audio/mpeg">
    </audio>`);
  player = $("#" + slidename)[0];

  bind_audio(slide,player, 5000);
  
}
