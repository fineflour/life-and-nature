$(".accept").click(function() {
  $(".hidden_div").show("slow");
  $("#link").hide("slow");
  if($(this).hasClass("link_1")){
    $("#link_1").show("slow");
  }
  if($(this).hasClass("link_2")){
    $("#link_2").show("slow");
  }

});

$("#close_tab_button").click(function() {
  $("#link_1").hide("slow");
  $("#link_2").hide("slow");
  $(".hidden_div").hide("slow");
  $("#link").show("slow");
  //$($this).hide("slow");
  //
          }); 
