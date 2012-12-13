// JavaScript Document
var carousel;

$(document).ready(function() {


    /*Кнопка Фото учасниц*/
    var $buton_foto_uchasnic = $("#conteiner_bloc_frame .buton_foto_uchasnic");
    $buton_foto_uchasnic.addClass("active");
    $buton_foto_uchasnic.click(function() {

        if ($buton_foto_uchasnic.hasClass("active")) {



        } else {

            $buton_foto_uchasnic.addClass("active");
            $buton_pravila.removeClass("active");
            $buton_instrukcia.removeClass("active");
            $("#conteiner_bloc_frame .instrukcia").hide();
            $("#conteiner_bloc_frame .pravila").hide();
            $("#conteiner_bloc_frame .foto_uchasnic").show();

        }
    });


    /*Кнопка Правила*/
    var $buton_pravila = $("#conteiner_bloc_frame .buton_pravila");
    $buton_pravila.click(function() {

        if ($buton_pravila.hasClass("active")) {


        } else {
            $buton_pravila.addClass("active");
            $buton_foto_uchasnic.removeClass("active");
            $buton_instrukcia.removeClass("active");
            $("#conteiner_bloc_frame .instrukcia").hide();
            $("#conteiner_bloc_frame .foto_uchasnic").hide();
            $("#conteiner_bloc_frame .pravila").show();
        }
    });


    /*Кнопка Инструкция*/
    var $buton_instrukcia = $("#conteiner_bloc_frame .buton_instrukcia");
    $buton_instrukcia.click(function() {

        if ($buton_instrukcia.hasClass("active")) {




        } else {
            $buton_instrukcia.addClass("active");
            $buton_foto_uchasnic.removeClass("active");
            $buton_pravila.removeClass("active");
            $("#conteiner_bloc_frame .pravila").hide();
            $("#conteiner_bloc_frame .foto_uchasnic").hide();
            $("#conteiner_bloc_frame .instrukcia").show();

        }
    });



    $.ajax({url: '/gallery/1.js', dataType: 'script'});


    $('.foto_uchasnic .photos').data('event-list',0);
    $('.foto_uchasnic .photos img').live('click', function(){
        if ( $(this).closest('.bigImageContainer').length > 0 ) // следующая картинка
        {
            if ( $('.foto_uchasnic .photos').data('event-list') == 1 ) return false;

            var style = $('.bigImageContainer').attr('style');
            $('.foto_uchasnic .photos').data('event-list',1);
            var ipos = $('.foto_uchasnic .photos').data('img-pos')*1;

            var $img = $('.foto_uchasnic .photos .imgitem:eq(' + ipos +')');
            if ( ipos+1 < $('.foto_uchasnic .photos .imgitem').length )
            {
                $('.foto_uchasnic .photos').data('event-list',0);
                $img.next().trigger('click');
                $('.bigImageContainer').attr('style', style);
            }
            else
            {
                $(document).one('ajax:complete', function(){
                    $('.foto_uchasnic > .photos > img').first().click();
    				
					// Kir V : заглушка на битые картинки
					$('.foto_uchasnic img').unbind("error").bind('error', function()
					{
						$(this).unbind("error").attr("src", "/assets/img_error.jpg"); 
						return false;
					});
                });
                $('.foto_uchasnic > .links > .next').click();
            }

            return false;
        }

        $('.bigImageContainer').remove();

        $('.foto_uchasnic .photos').data('img-pos', $('.foto_uchasnic .photos .imgitem').index( $(this) ) );

        var $p = $('.foto_uchasnic .photos');
        var left = $(this).offset().left-90;
        var top = $(this).offset().top-90;

        $('.foto_uchasnic .photos').prepend('<div class="bigImageContainer"><div class="topLine"><a href="http://instagram.com/'+$(this).attr('data-username')+'" class="name">@'+$(this).attr('data-username')+'</a><a href="javascript:void(0)" class="closePhoto">закрыть</a></div><img src="' + $(this).attr('src') + '" height="100%" /></div>')

        left = left - $p.offset().left-1;
        top = top - $p.offset().top-1;
        if ( left < 0 ) left = 0;
        if ( top < 0 ) top = 0;
        if ( left > 90 ) left = 0;
        if ( $('.bigImageContainer').height()+top > $p.height() ) top = $p.height()-$('.bigImageContainer').height()-10;

        $('.bigImageContainer').css({
            left : 	left,
            top:	top
        });
    });

    $('.closePhoto').live('click', function(){
        $('.bigImageContainer').remove();
    });


    // карусель
    (function()
    {
		// Kir V : подменяем картинки
		var i = 1;
		var link_arr = [
			'http://www.maybelline.com.ru/PRODUCTS/Face/POWDER/AffinitonePowder.aspx',
			'http://www.maybelline.com.ru/PRODUCTS/Face/CONCEALER/AffinitoneConcealer.aspx',
			'http://www.maybelline.com.ru/PRODUCTS/Face/FOUNDATION/Affinitone.aspx',
			'http://www.maybelline.com.ru/PRODUCTS/Eyes/MASCARA/OneByOneSatinBlack.aspx',
			'http://www.maybelline.com.ru/PRODUCTS/Eyes/EYE_SHADOW/Color_Tattoo.aspx'
		];
		$('#liquid img').each(function(){
			$(this).attr('src', '/assets/products/'+i+'.jpg');
			$(this).data('url', link_arr[ i-1 ]);
			i++;
		});
	
        $('#liquid').jcarousel({
			visible : 3,
			scroll : 1,
			wrap: 'circular',
			initCallback : function(c)
			{
				carousel = c;
			}
		});
		
		$('#liquid').append('<div class="hovered-overlay"></div>');
	
		var timeout_timer;
		$('#liquid li').mouseenter(function(){
			clearTimeout(timeout_timer);
			
			var offset = $(this).offset().left - $('#liquid').offset().left;
			
			$('#liquid .hovered-overlay').html(
				'<a target="_blank" href="'+$(this).find('img').data('url')+'" class="mask"></a>' // kir v links
			);
			
			$('#liquid .hovered-overlay').css({
				left : offset,
				display: 'block'
			});
			
			(function( elem )
			{
				timeout_timer = setTimeout(function()
				{
					var offset = elem.offset().left - $('#liquid').offset().left;
					$('#liquid .hovered-overlay').css({
						left : offset
					});
				},300);
			})( $(this) );
		});
		
	
		$('#liquid').mouseleave(function()
		{
			$('#liquid .hovered-overlay').hide();
		});
		$('#liquid .jcarousel-prev,#liquid .jcarousel-next').mouseenter(function()
		{
			$('#liquid .hovered-overlay').hide();
		});
		
		// kir v - hack
		$('#liquid').append('<div class="overlay-carousel-events"></div>');
		$('#liquid .jcarousel-prev,#liquid .jcarousel-next').click(function(){
			$('.overlay-carousel-events').show();
			setTimeout(function()
			{
				$('.overlay-carousel-events').hide();
			},500);
		});
    })();


    $('.s-tab  .send-nick button').click(function(){

        $('.s-tab  .send-nick .error').html('');

        var F = $(this).closest('form');
        if ( F.find('input[name=login]')[0].value == '' )
        {
            F.find('.error-login').html('неверно введены данные');
            return false;
        }

        /*if ( F.find('input[name=email]')[0].value == '' )
         {
         F.find('.error-login').html('неверно введены данные');
         return false;
         }*/

        $('.s-tab  .send-nick *').hide();
        $('.s-tab  .send-nick p').show();
        return false;
    });
});


var time_video = 0;
var time_video_timer_id = 0;
var carousel_pos= -1;
function change_pos(pos)
{
    if ( carousel_pos != pos )
    {
        $('#liquid .hovered-overlay').stop().animate({opacity: 0},250);
        carousel.scroll(pos);
        setTimeout(function()
        {
            $('#liquid .hovered-overlay').stop().animate({opacity: 1},250);
            $('.jcarousel-list li:eq('+(pos-1)+')').trigger('mouseenter');
            carousel_pos = pos;
        },500);
    }
}
function start_time_tick()
{
    time_video++;

    if ( time_video <= 90 )
    {
        change_pos(1);
    }
    else
    {
        if ( time_video <= 110 )
        {
            change_pos(2);
        }
        else
        {
            if ( time_video <= 135 )
            {
                change_pos(3);
            }
            else
            {
                if ( time_video <= 240 )
                {
                    change_pos(4);
                }
                else
                {
                    change_pos(5);
                }
            }
        }
    }
}

var ytplayer;
function onYouTubePlayerReady()
{
    ytplayer = document.getElementById("myytplayer");
    ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
}

function onytplayerStateChange(newState) {
    if ( newState == 1 )
    {
        time_video = Math.round(ytplayer.getCurrentTime());
        time_video_timer_id = setInterval(start_time_tick,1000);
    }

    if ( newState == 2 || newState == 3 )
    {
        time_video = Math.round(ytplayer.getCurrentTime());
        clearInterval(time_video_timer_id);
    }

    if ( newState == 0 )
    {
        time_video = 0;
        clearInterval(time_video_timer_id);
    }
}
