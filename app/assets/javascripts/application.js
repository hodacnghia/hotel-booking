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
//= require npm
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .


Gmaps.map.createMarker({Lat: Gmaps.map.userLocation.lat(),
               Lng: Gmaps.map.userLocation.lng(),
               rich_marker: null,
               marker_picture: ""
              })

        (function() {

            var width, height, largeHeader, canvas, ctx, points, target, animateHeader = true;

            // Main
            initHeader();
            initAnimation();
            addListeners();

            function initHeader() {
                width = window.innerWidth;
                height = window.innerHeight;
                target = {x: width/2, y: height/2};

                largeHeader = document.getElementById('large-header');
                largeHeader.style.height = height+'px';

                canvas = document.getElementById('demo-canvas');
                canvas.width = width;
                canvas.height = height;
                ctx = canvas.getContext('2d');

                // create points
                points = [];
                for(var x = 0; x < width; x = x + width/20) {
                    for(var y = 0; y < height; y = y + height/20) {
                        var px = x + Math.random()*width/20;
                        var py = y + Math.random()*height/20;
                        var p = {x: px, originX: px, y: py, originY: py };
                        points.push(p);
                    }
                }

                // for each point find the 5 closest points
                for(var i = 0; i < points.length; i++) {
                    var closest = [];
                    var p1 = points[i];
                    for(var j = 0; j < points.length; j++) {
                        var p2 = points[j]
                        if(!(p1 == p2)) {
                            var placed = false;
                            for(var k = 0; k < 5; k++) {
                                if(!placed) {
                                    if(closest[k] == undefined) {
                                        closest[k] = p2;
                                        placed = true;
                                    }
                                }
                            }

                            for(var k = 0; k < 5; k++) {
                                if(!placed) {
                                    if(getDistance(p1, p2) < getDistance(p1, closest[k])) {
                                        closest[k] = p2;
                                        placed = true;
                                    }
                                }
                            }
                        }
                    }
                    p1.closest = closest;
                }

                // assign a circle to each point
                for(var i in points) {
                    var c = new Circle(points[i], 2+Math.random()*2, 'rgba(255,255,255,0.3)');
                    points[i].circle = c;
                }
            }

            // Event handling
            function addListeners() {
                if(!('ontouchstart' in window)) {
                    window.addEventListener('mousemove', mouseMove);
                }
                window.addEventListener('scroll', scrollCheck);
                window.addEventListener('resize', resize);
            }

            function mouseMove(e) {
                var posx = posy = 0;
                if (e.pageX || e.pageY) {
                    posx = e.pageX;
                    posy = e.pageY;
                }
                else if (e.clientX || e.clientY)    {
                    posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
                    posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
                }
                target.x = posx;
                target.y = posy;
            }

            function scrollCheck() {
                if(document.body.scrollTop > height) animateHeader = false;
                else animateHeader = true;
            }

            function resize() {
                width = window.innerWidth;
                height = window.innerHeight;
                largeHeader.style.height = height+'px';
                canvas.width = width;
                canvas.height = height;
            }

            // animation
            function initAnimation() {
                animate();
                for(var i in points) {
                    shiftPoint(points[i]);
                }
            }

            function animate() {
                if(animateHeader) {
                    ctx.clearRect(0,0,width,height);
                    for(var i in points) {
                        // detect points in range
                        if(Math.abs(getDistance(target, points[i])) < 4000) {
                            points[i].active = 0.3;
                            points[i].circle.active = 0.6;
                        } else if(Math.abs(getDistance(target, points[i])) < 20000) {
                            points[i].active = 0.1;
                            points[i].circle.active = 0.3;
                        } else if(Math.abs(getDistance(target, points[i])) < 40000) {
                            points[i].active = 0.02;
                            points[i].circle.active = 0.1;
                        } else {
                            points[i].active = 0;
                            points[i].circle.active = 0;
                        }

                        drawLines(points[i]);
                        points[i].circle.draw();
                    }
                }
                requestAnimationFrame(animate);
            }

            function shiftPoint(p) {
                TweenLite.to(p, 1+1*Math.random(), {x:p.originX-50+Math.random()*100,
                    y: p.originY-50+Math.random()*100, ease:Circ.easeInOut,
                    onComplete: function() {
                        shiftPoint(p);
                    }});
            }

            // Canvas manipulation
            function drawLines(p) {
                if(!p.active) return;
                for(var i in p.closest) {
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(p.closest[i].x, p.closest[i].y);
                    ctx.strokeStyle = 'rgba(156,217,249,'+ p.active+')';
                    ctx.stroke();
                }
            }

            function Circle(pos,rad,color) {
                var _this = this;

                // constructor
                (function() {
                    _this.pos = pos || null;
                    _this.radius = rad || null;
                    _this.color = color || null;
                })();

                this.draw = function() {
                    if(!_this.active) return;
                    ctx.beginPath();
                    ctx.arc(_this.pos.x, _this.pos.y, _this.radius, 0, 2 * Math.PI, false);
                    ctx.fillStyle = 'rgba(156,217,249,'+ _this.active+')';
                    ctx.fill();
                };
            }

            // Util
            function getDistance(p1, p2) {
                return Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2);
            }

        })();

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
       $(document).ready(function(){
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
                <%# if(f.getYear() == t.getYear()){

                if(f.getMonth() == t.getMonth()){
                    alert(f.getMonth());
                    alert(t.getMonth());
                  if (f.getDate() == t.getDate()){
                    var tmp = (f.getMonth()+1+"/"+f.getDate()+"/"+f.getFullYear()).toString();
                    dateorder.push(tmp);
                  }
                  else{

                  var count = t.getDate()-f.getDate();

                  for (var j = 0; j <= count ; j++) {

                    var tmp = (f.getMonth()+1+"/"+f.getDate()+"/"+f.getFullYear()).toString();
                    dateorder.push(tmp);

                    f.setDate(f.getDate() + 1);


                  }
                  }
                }
                else{
                  var count = t.getMonth()-f.getMonth();
                  alert(t.getMonth());
                }
              } %>
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
        });
        


          });
                });

