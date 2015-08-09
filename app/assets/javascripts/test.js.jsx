var turn = 1;

var Test = React.createClass({
  render: function() {
    return (
      <div className="comment">
        <h2 className="commentAuthor">
          "Test"
        </h2>
      </div>
    );
  }
});


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
		var size = parseInt(this.props.size.toString());
		var board = [];
		for (i=0; i<size; i++) {
			board.push(Array.apply(null, Array(size)).map(Number.prototype.valueOf,0));
		}

		return { board: board };
	},
	setCell: function(x, y, val) {
		this.state.board[y][x] = val;
		this.setState({ board: this.state.board });
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
			this.props.setCell(x,y,turn);
			turn = turn * -1;
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
	var testBoard = [[0,0,0],[0,-1,0],[0,0,1]];
  React.render(
    <Board size="10" />,
    document.getElementById('content')
  );
});

