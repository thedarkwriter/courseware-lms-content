function timeline(times, slidename) {
  slide = $(".slide." + slidename);
  slide.bind("showoff:show", function (event) {
    times.forEach(function(time,index) {
      $(".time" + (index + 1)).css('visibility', 'hidden');
      setTimeout(function(){
        $(".time" + (index + 1)).css('visibility', 'visible');
      },time);
    });
  });
}

function audio(slidename) {
  slide = $(".slide." + slidename);
  slide.append(`
    <audio id="${slidename}">
      <source src="file/audio/${slidename}.mp3" type="audio/mpeg">
    </audio>`);
  player = $("#" + slidename)[0];
  slide.bind("showoff:show", function (event) {
    player.currentTime = 0;
    player.play();
  });
  slide.bind("showoff:prev", function (event) {
    player.pause();
  });
  slide.bind("showoff:next", function (event) {
    player.pause();
  });
}
