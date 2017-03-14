function timeline(times, slidename) {
  slide = $(".slide." + slidename);
  slide.bind("showoff:show", function (event) {
    times.forEach(function(time,index) {
      setTimeout(function(){
        $(".time" + (index + 1)).css('visibility', 'visible');
      },time);
    });
  });
}

function audio(slidename) {
  slide = $(".slide." + slidename);
  slide.append(`<audio id="${slidename}">
      <source src="file/audio/${slidename}.mp3" type="audio/mpeg">
      </audio>`);
  $(".slide." + slidename).find("#" + slidename)[0].onended = function(){
    fireEvent("showoff:next");
  };
  slide.bind("showoff:show", function (event) {
    player = $(".slide." + slidename).find("#" + slidename)[0];
    player.load();
    player.play();
  });
  slide.bind("showoff:prev", function (event) {
    player = $(".slide." + slidename).find("#" + slidename)[0];
    player.pause();
  });
  slide.bind("showoff:next", function (event) {
    player = $(".slide." + slidename).find("#" + slidename)[0];
    player.pause();
  });
}
