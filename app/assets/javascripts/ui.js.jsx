var turn = 1;

var EmptyIcon = React.createClass({
	render: function() {
			var vertLineStyle = {
				backgroundColor: 'black',
				position: 'absolute',
				top: '25px',
				height: '1px',
				width: '100%'
			};

			var hortLineStyle = {
				backgroundColor: 'black',
				position: 'absolute',
				left: '25px',
				width: '1px',
				height: '100%'
			};
	
			return (
				<div>
					<span style={vertLineStyle} />	
					<span style={hortLineStyle} />
				</div>
			);
	}
});


var BlackPiece = React.createClass({
	render: function() {
		var blackCircleStyle = {
			backgroundColor: 'black',
			width: '50px',
			height: '50px',
			borderRadius: '50%'
		};

		return (
			<div style={blackCircleStyle}></div>
		);
	}		
});


var WhitePiece = React.createClass({
	render: function() {
		var whiteCircleStyle = {
			backgroundColor: 'white',
			width: '50px',
			height: '50px',
			borderRadius: '50%'
		};

		return (
			<div style={whiteCircleStyle}></div>
		);
	}		
});

var Board = React.createClass({
	getInitialState: function () {

		return { board: this.props.board, id: this.props.id };
	},
	setCell: function(x, y) {
		this.callServer(x,y,this.state.id);
		
		this.setState({ board: this.state.board, id: this.state.id });
		
	},
	callServer: function(x,y,id) {
		$.ajax({
				type: "POST",
				url: "/game/validate",
				data: JSON.stringify({"x": x, "y": y, "id": id }),
				contentType: "application/json; charset=utf-8",
				dataType: "json"
			}).done( function( data ) {
				console.log(data);
				this.setState({ board: data.board, id: data.id });
				turn = data.turn;
			}.bind(this));
	},

	render: function() {
		var setCellFunc=this.setCell

		return (
			<div>
				{this.state.board.map(function(row, index) {
					return <Row key={row.id} values={row} row={index} setCell={setCellFunc} />;
				})}
			</div>
		);
	}
});


var Row = React.createClass({
	render: function() {
		var rowStyle = {
			height: '50px'
		};

		var rowNum = this.props.row.toString();
		var setCellFunc = this.props.setCell;

		function getCell(value, index) {
			return <Cell key={value.id} contents={value} row={rowNum} col={index} setCell={setCellFunc}/>
		};

		return (
		<div style={rowStyle} >
			{this.props.values.map(getCell)}
		</div>);
	}
});

var Cell = React.createClass({
	handleClick: function(event) {
		var x = this.props.col.toString();
		var y = this.props.row.toString();
		var contents = this.props.contents.toString();

		if (contents == 0) {
			this.props.setCell(x,y);
		}
	},
	render: function() {
		var backgroundDivStyle = {
				backgroundColor: '#993D00',
				position: 'relative',
				height: '50px',
				width: '50px',
				display: 'inline-block'
		};

		var contents = this.props.contents.toString();
		var content = <div />
		if (contents == 0) {   //Empty
			content = <EmptyIcon />
		} else if (contents == 1) {  //Black
			content = <BlackPiece />
		} else if (contents == -1) {  //White
			content = <WhitePiece />
		}
			
		return (
			<div style={backgroundDivStyle} onClick={this.handleClick} >	
				{content}
			</div>
		);
	}
});



$(function() {
  React.render(
    <Board board={current_board} id={current_board_id} />,
    document.getElementById('content')
  );
});

