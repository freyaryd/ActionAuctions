var originalValFn=$.fn.val;$.fn.val=function(){var a=originalValFn.apply(this,arguments);return arguments.length>0&&this.trigger("change"),a},$(document).ready(function(){$("#code").keyup(function(a){""===a.target.value?$("#join-btn").prop("disabled",!0):$("#join-btn").prop("disabled",!1)}),$(".quick-item").click(function(){const a=$(this).data("value");$(this).hasClass("-active")?$("#donate-amt").val(a):($(this).siblings().removeClass("-active"),$(this).addClass("-active"),$("#donate-amt").val(a))}),$("#donate-amt").keyup(function(){$(".quick-item").removeClass("-active")}),$("#donate-amt").on("input change propertychange paste",function(){const a=$(this).val();""===a?($("#donate-btn").prop("disabled",!0),$("#mini-donate").hide()):($("#donate-btn").prop("disabled",!1),$("#mini-donate").show())})});
