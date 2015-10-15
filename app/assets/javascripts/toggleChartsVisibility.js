$(function(){
  $(".button-charts").on("click", function(){
    var $fieldset = $(this).closest(".content");
    var $form = $fieldset.find(".charts");
    $form.toggleClass("hide-height");
  });
});
