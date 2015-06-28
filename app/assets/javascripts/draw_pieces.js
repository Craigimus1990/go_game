function isEmpty( el ){
		return !$.trim($(el).html())
}

function clearHighlights() {
	$(".cell").css("background-color", "white");
}

function setupCircle(canvas) {
      var context = canvas.getContext('2d');
      var centerX = canvas.width / 2;
      var centerY = canvas.height / 2;
      var radius = 40;

      context.beginPath();
      context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);

			return context;
}

function drawPieces() {
	$( ".white" ).each(function( index ) {
				var context = setupCircle(this);
				
				context.fillStyle = 'white';
				context.fill();
				context.lineWidth = 8;
				context.strokeStyle = 'black';
				context.stroke();
	});

	$( ".black" ).each(function( index) {
			var context = setupCircle(this);
			
			context.fillStyle = 'black';
			context.fill();
			context.lineWidth = 8;
			context.strokeStyle = 'gray';
			context.stroke();
	});

	$( ".no" ).each(function( index) {
			var ctx = this.getContext("2d");
			ctx.fillStyle = 'white';
			ctx.fill();
			ctx.beginPath();
			ctx.moveTo(50, 0);
			ctx.lineTo(50, 105);
			ctx.moveTo(0, 50);
			ctx.lineTo(105, 50);
			ctx.strokeStyle = 'black';
			ctx.stroke();
	});
}

function clickHandler(e) {
	clearHighlights();
  clazz = $(e.target).attr('class')
	if (clazz == "cell") {
		if (isEmpty(e.target)) {
			$(e.target).css("background-color", "green");
		} else {
			$(e.target).css("background-color", "red");
		}
	} 

}

function dblClickHandler(e) {
	if ($(e.target).attr('class').indexOf('filled') == -1) {
		$(e.target).html("");
		$(e.target).append(getNextPiece());
		$(e.target).attr('class', 'cell filled');
		drawPieces();
		clearHighlights();

		callAjax();
	}
}

function getNextPiece() {
	piece = $(document.createElement('canvas'));

	piece.attr("class", color + " piece");
	piece.attr("height", "100");
	piece.attr("width", "100");

	if (color == "black") {
		color = "white";
	} else {
		color = "black";
	}

	return piece;
}

function callAjax() {

	$("table tr").each(function(row_num, row) {
		$td_elem = $(row).find('td');
		$td_elem.each(function(col_num, cell) {
			if ($(cell).children().size() >= 1) {
				if ($(cell).children().first().hasClass("white")) {
					board[row_num][col_num] = -1;
				} else {
					board[row_num][col_num] = 1;
				}
			} else {
				board[row_num][col_num]=0;
			}
		});
	});

  return $.ajax({
		type: "POST",
    url: "/game/validate",
    data: JSON.stringify({"board": board}),
		contentType: "application/json; charset=utf-8",
		dataType: "json"
  }).done( function( data ) {

  });
}

$(document).ready(function() {
  $("table").on({"dblclick":dblClickHandler}, {});
	$("table").on({"click":clickHandler}, {});
	drawPieces();
	color = "black";
	
	size = $("table tr").size();
	console.log(size);
	board = new Array(size);
	for (i=0; i<size; i++) {
		board[i] = new Array(size);
	}
});

