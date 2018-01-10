// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.raty
//= require ckeditor/init
//= require ratyrate
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap.min
//= require jquery-ui
//= require npm
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .
Date.prototype.addDays = function(days) {
    var dat = new Date(this.valueOf())
    dat.setDate(dat.getDate() + days);
    return dat;
}

function getDates(startDate, stopDate) {
   var dateArray = new Array();
   var currentDate = startDate;
   while (currentDate <= stopDate) {
     dateArray.push(currentDate)
     currentDate = currentDate.addDays(1);
   }
   return dateArray;
 }
document.addEventListener("turbolinks:load", function() {



      var today = new Date();
      

         var datefrom = [];
         var dateto = [];
         var dateorder = [];

         $(".cus_order_show").find("strong.form").each(function(){ datefrom.push(this.id); });
         $(".cus_order_show").find("strong.to").each(function(){ dateto.push(this.id); });
         var d = new Date(dateto[0]);

         var q = new Date(datefrom[0]);
         for (var i = 0; i < datefrom.length; i++) {
           var f = new Date(datefrom[i]);
           var t = new Date(dateto[i]);
           var dateArray = getDates(f, t);
           dateorder =dateorder.concat(dateArray);

         }

       $('#datetimepicker6').datetimepicker({
         useCurrent: false ,
         minDate: today,
         format: 'YYYY/MM/DD',
                 disabledDates: dateorder
         });
       $('#datetimepicker7').datetimepicker({ 
         useCurrent: false ,//Important! See issue #1075
         minDate: today,
         format: 'YYYY/MM/DD',
                 disabledDates: dateorder
         });
       $("#datetimepicker6").on("dp.change", function (e) {
        $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
       });
       $("#datetimepicker7").on("dp.change", function (e) {
         $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
       });

      $("#order-btn").click(function(e){
       var orderfrom = new Date(document.getElementById("datefrom").value);
       var orderto = new Date(document.getElementById("dateto").value);
     $.each(dateorder , function (index, value){
       if(orderfrom < value && orderto > value){
         e.preventDefault();
         alert("Phòng đã bị đặt trong khoảng thời gian ");
         return false;
        }
        if (orderfrom == "Invalid Date" ||orderto == "Invalid Date"  ){
            e.preventDefault();
          alert("Ngày Không được để trống ");
          return false;          }

     });
     


       });
             });



